import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/general_error.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/model/category_list_model.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../popular_doctor_screen/controller/popular_doctor_controller.dart';

class CardiologyScreen extends StatefulWidget {
  const CardiologyScreen({super.key});

  @override
  State<CardiologyScreen> createState() => _CardiologyScreenState();
}

class _CardiologyScreenState extends State<CardiologyScreen> {
  final CategoryListModel categoryListModel = Get.arguments;

  final PopularDoctorController popularDoctorController =
      Get.find<PopularDoctorController>();

  @override
  void initState() {
    // TO DO: implement initState
    popularDoctorController.getTherapistbySpeciality(
        therapistID: categoryListModel.id ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: categoryListModel.name,
      ),
      body: Obx(() {
        switch (popularDoctorController.therapistBySpecialityLoader.value) {
          case Status.loading:
            return Center(child: CustomLoader());
          case Status.internetError:
            return GeneralErrorScreen(
                onTap: () => popularDoctorController.getTherapistbySpeciality(
                    therapistID: categoryListModel.id ?? ''));
          case Status.error:
            return GeneralErrorScreen(
                onTap: () => popularDoctorController.getTherapistbySpeciality(
                    therapistID: categoryListModel.id ?? ''));
          case Status.completed:
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: popularDoctorController
                        .specialityScrollController.value,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 0,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                    shrinkWrap: true,
                    itemCount: popularDoctorController
                        .therapistBySpecialityList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = popularDoctorController
                          .therapistBySpecialityList[index];
                      return popularDoctorController.isLoadMoreRunning.value
                          ? CustomLoader()
                          : CustomDoctorCard(
                              onTap: () {
                                Get.toNamed(
                                    AppRoutes.therapistViewProfileScreen,
                                    arguments: data);
                              },
                              imageUrl: ImageHandler.imagesHandle(data.therapist?.profile?.image ?? ""),
                                 // "${ApiUrl.imageUrl}${data.therapist?.profile?.image ?? ""}",
                              firstName: data.therapist?.firstName ?? "",
                              lastName: data.therapist?.lastName ?? "",
                              title:
                                  data.therapist?.profile?.subSpecialty ?? "",
                              price: data
                                      .therapist?.profile?.chargePerHour?.amount
                                      .toString() ??
                                  "",
                              rating: "4.2",
                            );
                    },
                  ),
                ),
              ],
            );
        }
      }),
    );
  }
}
