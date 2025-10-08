import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../authentication/controller/auth_controller.dart';

class EditUploadProfileLogoScreen extends StatelessWidget {
  const EditUploadProfileLogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Edit Profile & Logo",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: "Step -04",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                bottom: 10.h,
              ),
            ),

            /// Profile Photo
            CustomText(
              text: "Upload your Profile photo",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
            SizedBox(height: 20.h),
            Obx(
                  () => GestureDetector(
                onTap: authController.pickProfilePhoto,
                child: DottedBorder(
                  child: SizedBox(
                    height: 210.h,
                    width: 150.w,
                    child: authController.profilePhoto.value != null
                        ? Image.file(
                      authController.profilePhoto.value!,
                      fit: BoxFit.cover,
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined,
                            color: AppColors.primary, size: 30),
                        CustomText(
                          top: 10.h,
                          text: "Upload Image",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),

            /// Brand Logo
            CustomText(
              text: "Upload your Brand Logo",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
            SizedBox(height: 20.h),
            Obx(
                  () => GestureDetector(
                onTap: authController.pickBrandLogo,
                child: DottedBorder(
                  child: SizedBox(
                    height: 210.h,
                    width: 150.w,
                    child: authController.brandLogo.value != null
                        ? Image.file(
                      authController.brandLogo.value!,
                      fit: BoxFit.cover,
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined,
                            color: AppColors.primary, size: 30),
                        CustomText(
                          top: 10.h,
                          text: "Upload Logo",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),

            /// Submit Button with Loading
            Obx(
                  () => authController.uploadingImages.value
                  ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              )
                  : CustomButton(
                onTap: () async {
                  await authController.updateProfileAndLogo();
                },
                title: AppStrings.submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
