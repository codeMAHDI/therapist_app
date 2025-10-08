/*
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/utils/app_images/app_images.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_dropdown/custom_royel_dropdown.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CreateTherapistScreen extends StatelessWidget {
  const CreateTherapistScreen({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomRoyelAppbar(titleName: AppStrings.createAccount,leftIcon: true,),
              ///============ Logo ===========

              ///============ Email ===========
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 50.h),
                      child: Column(
                        children: [
                          /// profile image======
                          Center(
                            child: Stack(
                              children: [
                                CustomNetworkImage(
                                  imageUrl: AppConstants.profileImage,
                                  height: 120.h,
                                  width: 120.w,
                                  boxShape: BoxShape.circle,
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      // authController.getFileImage();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 18,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          ///============ Role Radio ===========
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(value: true, groupValue: true, onChanged: (value){}, activeColor: AppColors.primary,),
                              CustomText(text: "User.",fontSize: 16,fontWeight: FontWeight.w500,),
                              Radio(value: false, groupValue: true, onChanged: (value){
                                //Get.toNamed(AppRoutes.)
                              }),
                              CustomText(text: "Therapist.",fontSize: 16,fontWeight: FontWeight.w500,),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            children: [
                              ///============ First Name ===========
                              Flexible(
                                child: CustomFormCard(
                                  title: AppStrings.fullName,
                                  hintText: AppStrings.typeHere,
                                  controller: TextEditingController(),
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              ///============ Last Name ===========
                              Flexible(
                                child: CustomFormCard(
                                  title: AppStrings.lastName,
                                  hintText: AppStrings.typeHere,
                                  controller: TextEditingController(),
                                ),
                              ),
                            ],
                          ),
                          ///============ Email ===========
                          CustomFormCard(
                            prefixIcon: Icon(Icons.mail_outline_outlined, color: AppColors.primary,),
                            title: AppStrings.email,
                            hintText: AppStrings.enterYourEmail,
                            controller: TextEditingController(),
                          ),
                          ///============ Contact ===========
                          CustomFormCard(
                            prefixIcon: Icon(Icons.contact_phone_outlined, color: AppColors.primary,),
                            title: AppStrings.contact,
                            hintText: AppStrings.typeHere,
                            controller: TextEditingController(),
                          ),
                          ///============ New Password ===========
                          CustomFormCard(
                            title: AppStrings.password,
                            hintText: AppStrings.enterYourPassword,
                            isPassword: true,
                            controller: TextEditingController(),
                          ),
                          ///============ Confirm Password ===========
                          CustomFormCard(
                            title: AppStrings.confirmPassword,
                            hintText: AppStrings.enterYourPassword,
                            isPassword: true,
                            controller: TextEditingController(),
                          ),
                          SizedBox(height: 20.h,),
                          ///============ Login ===========
                          CustomButton(
                            title: AppStrings.submit,
                            onTap: () {
                              //Get.toNamed(AppRoutes.verificationScreen);
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
*/
