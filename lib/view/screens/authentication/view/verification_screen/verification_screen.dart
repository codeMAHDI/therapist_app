// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:counta_flutter_app/utils/ToastMsg/toast_message.dart';
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/utils/app_images/app_images.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_pin_code/custom_pin_code.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/authentication/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  // Auth Controller instance
  final AuthController authController = Get.find<AuthController>();

  // UserModel instance passed via arguments
  final UserModel userModel = Get.arguments as UserModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          image: DecorationImage(
            scale: 4,
            image: AssetImage(AppImages.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Obx(
            () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRoyelAppbar(
                    titleName: AppStrings.verifyCodeText,
                    leftIcon: true,
                  ),

                  /// Logo
                  CustomImage(imageSrc: AppIcons.logo),
                  CustomText(
                    text: "Enter your email to reset your password.",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 40.h),

                  /// Email & OTP Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        /// Pin Code
                        CustomPinCode(
                            controller: authController.otpController.value),
                        SizedBox(height: 20.h),

                        /// Submit Button
                        authController.otpLoading.value
                            ? CustomLoader()
                            : CustomButton(
                                title: AppStrings.submit,
                                onTap: () {
                                  if (authController
                                      .otpController.value.text.isEmpty) {
                                    showCustomSnackBar(
                                      AppStrings.fieldCantBeEmpty,
                                      isError: true,
                                    );
                                    return;
                                  }

                                  authController.verifyOtp(
                                    email: userModel.email,
                                    screenName: userModel.screenName,
                                  );
                                },
                              ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
