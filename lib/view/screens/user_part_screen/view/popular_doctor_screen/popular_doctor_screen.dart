import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/popular_doctor_screen/controller/popular_doctor_controller.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/controller/review_controller.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/general_error.dart';

class PopularDoctorScreen extends StatelessWidget {
  PopularDoctorScreen({super.key});

  final PopularDoctorController popularDoctorController =
      Get.find<PopularDoctorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Popular Doctors",
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            switch (popularDoctorController.popularListLoader.value) {
              case Status.loading:
                return const Center(child: CustomLoader());

              case Status.internetError:
                return GeneralErrorScreen(
                  onTap: () => popularDoctorController.getPopularList(),
                );

              case Status.error:
                return GeneralErrorScreen(
                  onTap: () => popularDoctorController.getPopularList(),
                );

              case Status.completed:
                return Column(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 0,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 0.h,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: popularDoctorController.popularList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = popularDoctorController.popularList[index];
                        String doctorId = data.id ?? "";

                        /// লোকাল review controller
                        final ReviewController tempController =
                            Get.put(ReviewController(), tag: doctorId);

                        /// feedback fetch
                        tempController.fetchFeedbackSummary(doctorId);

                        return Obx(() {
                          double rating = tempController.averageRating.value;
                          int count = tempController.feedbackCount.value;

                          /// UI build complete হলে controller clear
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (Get.isRegistered<ReviewController>(
                                tag: doctorId)) {
                              Get.delete<ReviewController>(tag: doctorId);
                            }
                          });

                          return CustomDoctorCard(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.therapistViewProfileScreen,
                                arguments: data,
                              );
                            },
                            imageUrl: ImageHandler.imagesHandle(
                                data.therapist?.profile?.image ?? ""),
                            firstName: data.therapist?.firstName ?? "",
                            lastName: data.therapist?.lastName ?? "",
                            title:
                                data.therapist?.profile?.speciality?.name ?? "",
                            price: data.therapist?.profile?.chargePerHour?.amount
                                    .toString() ??
                                "",
                            rating:
                                "${rating.toStringAsFixed(1)} ($count)", // avg rating + count দেখাবে
                          );
                        });
                      },
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
