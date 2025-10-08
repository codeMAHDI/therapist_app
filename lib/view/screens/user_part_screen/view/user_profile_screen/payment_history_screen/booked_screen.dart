import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_images/app_images.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/popular_doctor_screen/controller/popular_doctor_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/app_routes/app_routes.dart';

class BookedScreen extends StatelessWidget {
  BookedScreen({super.key});

  final PopularDoctorController popularDoctorController =
      Get.find<PopularDoctorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(imageSrc: AppImages.bookedImage),
            CustomText(
              text: "Appointment Booked",
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              bottom: 20.h,
              top: 10.h,
            ),
            CustomText(
              text:
                  "The appointment has been successfully booked.\nBelow are the details.",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              bottom: 20.h,
            ),
            SizedBox(
              height: 120.h,
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(
                  AppRoutes.invoiceViewScreen,
                  arguments: popularDoctorController.singleInvoice[0],
                );
              },
              title: "Get Invoice",
              fillColor: AppColors.black,
              isBorder: true,
              textColor: AppColors.primary,
              borderWidth: 1,
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.userHomeScreen);
              },
              title: "Go Home",
            ),
          ],
        ),
      ),
    );
  }
}
