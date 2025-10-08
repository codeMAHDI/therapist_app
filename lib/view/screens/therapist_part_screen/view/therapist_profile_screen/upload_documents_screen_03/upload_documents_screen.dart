import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/controller/therapist_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UploadDocumentsScreen extends StatelessWidget {
  UploadDocumentsScreen({super.key});
  final TherapistProfileController therapistPC =
  Get.find<TherapistProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Upload Documents",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Step -03",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                bottom: 6.h,
              ),
              SizedBox(height: 200.h),

              Obx(() => CustomButton(
                onTap: () {
                  therapistPC.pickCvFile();
                },
                height: 48.h,
                isBorder: true,
                fillColor: AppColors.navbarClr,
                textColor: AppColors.primary,
                borderWidth: 1,
                title: (therapistPC.cvFile.value == null || therapistPC.cvFile.value!.path.isEmpty)
                    ? AppStrings.uploadCv
                    : 'CV Uploaded',
              )),

              SizedBox(height: 20.h),

              Obx(() => CustomButton(
                onTap: () {
                  therapistPC.pickCertificateFile();
                },
                height: 48.h,
                isBorder: true,
                fillColor: AppColors.navbarClr,
                textColor: AppColors.primary,
                borderWidth: 1,
                title: (therapistPC.certificateFile.value == null ||
                    therapistPC.certificateFile.value!.path.isEmpty)
                    ? AppStrings.uploadCertificate
                    : 'Certificate Uploaded',
              )),

              SizedBox(height: 20.h),

              CustomText(
                text: "N.B :Accepted formats: PDF, DOCX, JPG, PNG",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                bottom: 40.h,
              ),

              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.uploadLogoScreen);
                },
                title: AppStrings.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}