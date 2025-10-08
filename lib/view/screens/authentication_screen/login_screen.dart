// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/utils/app_images/app_images.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/authentication/controller/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
            scale: 4,
            image: AssetImage(
              AppImages.backgroundImage,
            ),
            fit: BoxFit.cover),
      ),

      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Obx(() {
            return Padding(
              padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 40.h),
              child: Column(
                children: [
                  CustomImage(imageSrc: AppIcons.logo),
                  SizedBox(
                    height: 20.h,
                  ),

                  ///============ Email ===========
                  CustomFormCard(
                    title: AppStrings.email,
                    hintText: AppStrings.enterYourEmail,
                    controller: authController.loginEmailController.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.emailFieldCantBeEmpty;
                      }
                      return null;
                    },
                  ),

                  ///============ Password ===========
                  CustomFormCard(
                    title: AppStrings.password,
                    hintText: AppStrings.enterYourPassword,
                    controller: authController.loginPasswordController.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.passwordFieldCantBeEmpty;
                      } else if (value.length < 8) {
                        return AppStrings.enterThe8Character;
                      }
                      return null;
                    },
                    isPassword: true,
                  ),

                  ///============ Fortgot Password ============
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.forgotPassword);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomText(
                        text: AppStrings.forgotPassword,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                        bottom: 30.h,
                      ),
                    ),
                  ),

                  ///============ Login ===========
                  authController.loginLoading.value
                      ? CustomLoader()
                      : CustomButton(
                          title: AppStrings.login,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              authController.loginUser();
                            }
                          },
                        ),

                  ///============ Create a Account ===========
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.userHomeScreen);
                        },
                        child: CustomText(
                          text: AppStrings.createAccount,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          right: 10.w,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.createAccountScreen);
                        },
                        child: CustomText(
                          text: AppStrings.orSignUpWith,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  ///============ Google ===========
                  ///============ Google ===========
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.therapistHomeScreen);
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 1.8,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: Row(
                        children: [
                          CustomImage(
                            imageSrc: AppIcons.google,
                            height: 24.w,
                            width: 24.w,
                          ),
                          CustomText(
                            text: AppStrings.looginWithGoogle,
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                            left: 5.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  ///============ Apple ===========
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.subscriptionScreen);
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 1.8,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: Row(
                        children: [
                          CustomImage(
                            imageSrc: AppIcons.apple,
                            height: 24.w,
                            width: 24.w,
                          ),
                          CustomText(
                            text: AppStrings.loginWithApple,
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                            left: 5.w,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    ));
  }
}
