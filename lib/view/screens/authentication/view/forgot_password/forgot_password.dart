// ignore_for_file: prefer_const_constructors
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/utils/app_images/app_images.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final AuthController authController = Get.find<AuthController>();
  // UserModel instance passed via arguments
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              child: Obx(
               () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRoyelAppbar(titleName: AppStrings.forgotPassword,leftIcon: true,),
                      ///============ Logo ===========
                      CustomImage(imageSrc: AppIcons.logo),
                      CustomText(text: "Enter your email to reset your password.",fontSize: 16,fontWeight: FontWeight.w500,),
                      SizedBox(height: 40.h,),
                      ///============ Email ===========
                      Padding(
                        padding: EdgeInsets.only(left: 20.h, right: 20.h),
                        child: Column(
                          children: [
                            CustomFormCard(
                              title: AppStrings.email,
                              hintText: AppStrings.enterYourEmail,
                              controller: authController.forgetEmailController.value,
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return AppStrings.emailFieldCantBeEmpty;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h,),
                            ///============ Login ===========
                           authController.forgetPasswordLoading.value
                               ? CustomLoader()
                               : CustomButton(
                              title: AppStrings.submit,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  authController.forgetPassword(email: authController.forgetEmailController.value.text, isForgot: true);
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              ),
            ),
          ),
        ));
  }
}
