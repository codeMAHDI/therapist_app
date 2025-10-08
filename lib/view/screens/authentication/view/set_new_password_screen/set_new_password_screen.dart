import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/utils/app_images/app_images.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key});

  // Auth Controller instance
  final AuthController authController = Get.find<AuthController>();

  // Form Key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey, // Attach the form key
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRoyelAppbar(
                    titleName: AppStrings.setNewPassword,
                    leftIcon: true,
                  ),
                  /// Logo
                  CustomImage(imageSrc: AppIcons.logo),
                  /// New Password Form
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      children: [
                        /// New Password Field
                        CustomFormCard(
                          title: AppStrings.newPassword,
                          hintText: AppStrings.enterYourPassword,
                          isPassword: true,
                          controller: authController.newPasswordController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.passwordFieldCantBeEmpty;
                            } else if (value.length < 8) {
                              return AppStrings.enterThe8Character;
                            }
                            return null;
                          },
                        ),
                        /// Confirm Password Field
                        CustomFormCard(
                          title: AppStrings.confirmPassword,
                          hintText: AppStrings.enterYourPassword,
                          isPassword: true,
                          controller: authController.confirmPasswordController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.passwordFieldCantBeEmpty;
                            } else if (value != authController.newPasswordController.value.text) {
                              return AppStrings.passwordNotMatch;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        /// Submit Button
                        authController.newPasswordLoading.value
                            ? CustomLoader()
                            : CustomButton(
                          title: AppStrings.submit,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              authController.setNewPassword(
                                email: userModel.email,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}