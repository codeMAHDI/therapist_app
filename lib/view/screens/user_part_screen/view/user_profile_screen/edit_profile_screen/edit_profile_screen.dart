import 'dart:io';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../authentication/controller/auth_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final authController = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: AppStrings.editProfile,
        leftIcon: true,
      ),
      body: Form(
        key: formKey,
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.h, right: 20.h, bottom: 50.h),
                      child: Column(
                        children: [
                          /// profile image======
                          Center(
                              child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70),
                                    border: Border.all(
                                        width: 3, color: AppColors.primary),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        // ignore: deprecated_member_use
                                        color: AppColors.white.withOpacity(0.1),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    fit: StackFit.loose,
                                    clipBehavior: Clip.none,
                                    children: [
                                      // ignore: unnecessary_null_comparison
                                      authController.profileImage.value == null ? authController.userProfileModel.value.profile !=null &&authController.userProfileModel.value.profile?.image !=''
                                              ? CustomNetworkImage(
                                                 imageUrl: ImageHandler.imagesHandle(authController.userProfileModel.value.profile?.image ?? ''),
                                                 // imageUrl: '${ApiUrl.imageUrl}${authController.userProfileModel.value.profile?.image ?? ''}',
                                                  height: 150.h,
                                                  width: 150.w,
                                                  boxShape: BoxShape.circle,
                                                )
                                              : CustomNetworkImage(
                                                  imageUrl: ImageHandler.imagesHandle(authController.userProfileModel.value.profile?.image ?? ''),
                                                  height: 150.h,
                                                  width: 150.w,
                                                  boxShape: BoxShape.circle,
                                                  

                                                )
                                          : Container(
                                              width: 120,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      File(
                                                        authController
                                                            .profileImage
                                                            .value!
                                                            .path,
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                      Positioned(
                                        bottom: 5,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            authController.getFileImage();
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                shape: BoxShape.circle),
                                            child: const Icon(
                                              Icons.camera_alt,
                                              size: 18,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              ///============ First Name ===========
                              Flexible(
                                child: CustomFormCard(
                                  title: AppStrings.fullName,
                                  hintText: AppStrings.typeHere,
                                  controller: authController
                                      .userFirstNameController.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppStrings.fieldCantBeEmpty;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),

                              ///============ Last Name ===========
                              Flexible(
                                child: CustomFormCard(
                                  title: AppStrings.lastName,
                                  hintText: AppStrings.typeHere,
                                  controller: authController
                                      .userLastNameController.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppStrings.fieldCantBeEmpty;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          ///============ Contact ===========
                          CustomFormCard(
                            prefixIcon: Icon(
                              Icons.contact_phone_outlined,
                              color: AppColors.primary,
                            ),
                            title: AppStrings.contact,
                            hintText: AppStrings.typeHere,
                            controller:
                                authController.userPhoneController.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.fieldCantBeEmpty;
                              }
                              return null;
                            },
                          ),

                          ///============ Location ===========
                          CustomFormCard(
                            prefixIcon: Icon(
                              Icons.location_searching_outlined,
                              color: AppColors.primary,
                            ),
                            title: AppStrings.location,
                            hintText: AppStrings.typeHere,
                            controller:
                                authController.userLocationController.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.fieldCantBeEmpty;
                              }
                              return null;
                            },
                          ),

                          ///============ Gender ===========
                          Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                text: "Gender",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                bottom: 10,
                              )),
                          Center(
                            child: Obx(
                              () => Container(
                                alignment: Alignment.center,
                                height: 60,
                                width: MediaQuery.sizeOf(context).width,
                                padding: EdgeInsets.only(left: 10.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                ),
                                child: DropdownButton<String>(
                                  value: authController
                                          .selectedGender.value.isEmpty
                                      ? null
                                      : authController.selectedGender.value,
                                  hint: CustomText(
                                    text: "Select Gender",
                                    fontSize: 18.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                    right: 15.w,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 2,
                                  dropdownColor: AppColors.black,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  iconSize: 25,
                                  underline: const SizedBox(),
                                  isExpanded:
                                      true, // This makes the dropdown full-width
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18.w,
                                  ),
                                  items: authController.genderOptions
                                      .map((String gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child: Text(gender),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      authController.setGender(newValue);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),

                          // CustomRoyelDropdown(fillColor: AppColors.black,textColor: AppColors.white, title: AppStrings.gender,isBorder: true,),
                          ///============ Date of Birth ===========
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomFormCard(
                            readOnly: true,
                            onTap: () {
                              authController.pickDate(context);
                            },
                            prefixIcon: Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.primary,
                            ),
                            title: AppStrings.dateOfBirth,
                            hintText: AppStrings.typeHere,
                            // controller: DateConverter.dateFormetString(authController.userDateController.value.value.text.toString()),
                            //  controller: DateConverter.timeFormetString(authController.userDateController.value.text.toString()),
                            controller: authController.userDateController.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.fieldCantBeEmpty;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                          ///============ Login ===========
                          authController.userUpdateLoading.value
                              ? CustomLoader()
                              : CustomButton(
                                  title: AppStrings.savedChanges,
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      authController.updateUserProfile();
                                    }
                                  },
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
