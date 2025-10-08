import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_nav_bar/navbar.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_category_circular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../controller/user_home_controller.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final UserHomeController homeController = Get.find<UserHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.category,
      ),
      body: Column(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: homeController.categoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomCategoryCircular(
                onTap: () {
                  // আপনার নির্দিষ্ট রুট যুক্ত করুন
                  Get.toNamed(AppRoutes.cardiologyScreen,
                      arguments: homeController.categoryList[index]);
                },
                icon:
                    ImageHandler.imagesHandle(homeController.categoryList[index].image ?? ''),
                  //"${ApiUrl.imageUrl}${homeController.categoryList[index].image ?? ""}",
                text: homeController.categoryList[index].name ?? "",
              );
            },
            /*   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),*/
          ),
        ],
      ),
      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }
}
