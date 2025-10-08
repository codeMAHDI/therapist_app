import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/authentication/controller/auth_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/therapist_profile_controller.dart';

class UploadLogoScreen extends StatelessWidget {
  UploadLogoScreen({super.key});
  final AuthController authController = Get.find<AuthController>();
  final TherapistProfileController therapistProfileController =
      Get.find<TherapistProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Upload Logo",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              SizedBox(height: 80.h),
              CustomText(
                text: "Upload your Brand Logo",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              SizedBox(height: 20.h),
              DottedBorder(
                child: GestureDetector(
                  onTap: therapistProfileController.brandLogo,
                  child: Obx(
                    () {
                      final brandLogo =
                          therapistProfileController.brandLogoFile.value;

                      return Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: (brandLogo == null || brandLogo.path.isEmpty)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Upload Logo',
                                    style: TextStyle(color: Colors.yellow),
                                  ),
                                ],
                              )
                            : Image.file(
                                brandLogo,
                                fit: BoxFit.cover,
                              ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.appointmentScreen);
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
