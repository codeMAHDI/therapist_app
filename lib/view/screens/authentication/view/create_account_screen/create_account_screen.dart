// ignore_for_file: prefer_const_constructors
import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/utils/ToastMsg/toast_message.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/utils/app_images/app_images.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/authentication/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../therapist_part_screen/controller/therapist_profile_controller.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final TherapistProfileController therapistPC =
  Get.find<TherapistProfileController>();
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
            image: AssetImage(AppImages.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomRoyelAppbar(
                titleName: AppStrings.createAccount,
                leftIcon: true,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 50.h),
                      child: Column(
                        children: [
                          /// Profile Image
                          Center(
                            child: Stack(
                              children: [
                                Obx(() {
                                  final image = authController.radioButton.value == AppStrings.userRole
                                      ? authController.profileImage.value
                                      : therapistPC.selectedImage.value;

                                  if (image != null) {
                                    return Container(
                                      height: 120.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: FileImage(image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return CustomNetworkImage(
                                      imageUrl: AppConstants.profileImage,
                                      height: 120.h,
                                      width: 120.w,
                                      boxShape: BoxShape.circle,
                                    );
                                  }
                                }),
                                Positioned(
                                  bottom: 5,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (authController.radioButton.value == AppStrings.userRole) {
                                        authController.getFileImage();
                                      } else {
                                        therapistPC.pickImageFromGallery();
                                      }
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

                          SizedBox(height: 20.h),

                          /// Role Radio
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio<String>(
                                value: AppStrings.userRole,
                                groupValue: authController.radioButton.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    authController.radioButton.value = value;
                                  }
                                },
                                activeColor: AppColors.primary,
                              ),
                              CustomText(text: "User.", fontSize: 16, fontWeight: FontWeight.w500),
                              Radio<String>(
                                value: AppStrings.therapistRole,
                                groupValue: authController.radioButton.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    authController.radioButton.value = value;
                                  }
                                },
                                activeColor: AppColors.primary,
                              ),
                              CustomText(text: "Therapist.", fontSize: 16, fontWeight: FontWeight.w500),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          /// User Form
                          if (authController.radioButton.value == AppStrings.userRole)
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: CustomFormCard(
                                          title: AppStrings.fullName,
                                          hintText: AppStrings.typeHere,
                                          controller: authController.userFirstNameController.value,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return AppStrings.typeYourFirstName;
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Flexible(
                                        child: CustomFormCard(
                                          title: AppStrings.lastName,
                                          hintText: AppStrings.typeHere,
                                          controller: authController.userLastNameController.value,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return AppStrings.typeYourLastName;
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  CustomFormCard(
                                    prefixIcon: Icon(Icons.mail_outline_outlined, color: AppColors.primary),
                                    title: AppStrings.email,
                                    hintText: AppStrings.enterYourEmail,
                                    controller: authController.userEmailController.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return AppStrings.typeYourEmail;
                                      return null;
                                    },
                                  ),

                                  CustomFormCard(
                                    keyboardType: TextInputType.phone,
                                    prefixIcon: Icon(Icons.contact_phone_outlined, color: AppColors.primary),
                                    title: AppStrings.contact,
                                    hintText: AppStrings.typeHere,
                                    controller: authController.userPhoneController.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return AppStrings.typeYourContact;
                                      return null;
                                    },
                                  ),

                                  CustomFormCard(
                                    prefixIcon: Icon(Icons.location_searching_outlined, color: AppColors.primary),
                                    title: AppStrings.location,
                                    hintText: AppStrings.typeHere,
                                    controller: authController.userLocationController.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return AppStrings.typeYourDate;
                                      return null;
                                    },
                                  ),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      text: "Gender",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      bottom: 10,
                                    ),
                                  ),
                                  Center(
                                    child: Obx(
                                          () => Container(
                                        alignment: Alignment.center,
                                        height: 60,
                                        width: MediaQuery.sizeOf(context).width,
                                        padding: EdgeInsets.only(left: 10.w),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.white, width: 0.2),
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.transparent,
                                        ),
                                        child: DropdownButton<String>(
                                          value: authController.selectedGender.value.isEmpty
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
                                          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.white),
                                          iconSize: 25,
                                          underline: const SizedBox(),
                                          isExpanded: true,
                                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.w),
                                          items: authController.genderOptions.map((String gender) {
                                            return DropdownMenuItem<String>(
                                              value: gender,
                                              child: Text(gender),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            if (newValue != null) authController.setGender(newValue);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  CustomFormCard(
                                    readOnly: true,
                                    onTap: () => authController.pickDate(context),
                                    prefixIcon: Icon(Icons.calendar_month_outlined, color: AppColors.primary),
                                    title: AppStrings.dateOfBirth,
                                    hintText: AppStrings.typeHere,
                                    controller: authController.userDateController.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return AppStrings.typeYourDate;
                                      return null;
                                    },
                                  ),

                                  CustomFormCard(
                                    title: AppStrings.password,
                                    hintText: AppStrings.enterYourPassword,
                                    isPassword: true,
                                    controller: authController.userPasswordController.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return AppStrings.typeYourDate;
                                      return null;
                                    },
                                  ),

                                  CustomFormCard(
                                    title: AppStrings.confirmPassword,
                                    hintText: AppStrings.enterYourPassword,
                                    isPassword: true,
                                    controller: authController.userConfirmPasswordController.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return AppStrings.typeYourDate;
                                      if (value != authController.userPasswordController.value.text) {
                                        return AppStrings.passwordNotMatch;
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 20.h),

                                  authController.userRegisterLoading.value
                                      ? CustomLoader()
                                      : CustomButton(
                                    title: AppStrings.submit,
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        if (authController.profileImage.value != null) {
                                          authController.userSignUp();
                                        } else {
                                          showCustomSnackBar('Please select an image', isError: true);
                                        }
                                      }
                                    },
                                  ),

                                  SizedBox(height: 20.h),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: AppStrings.alreadyHaveAccount,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.white,
                                        right: 10.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          authController.clearUserData();
                                          Get.toNamed(AppRoutes.loginScreen);
                                        },
                                        child: CustomText(
                                          text: AppStrings.login,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          /// Therapist Form
                          if (authController.radioButton.value == AppStrings.therapistRole)
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: CustomFormCard(
                                          title: AppStrings.fullName,
                                          hintText: AppStrings.typeHere,
                                          controller: therapistPC.therapistFirstNameController.value,
                                          onChanged: (value) {
                                            SharePrefsHelper.saveString('firstName', value);
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) return AppStrings.enterYourName;
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Flexible(
                                        child: CustomFormCard(
                                          title: AppStrings.lastName,
                                          hintText: AppStrings.typeHere,
                                          controller: therapistPC.therapistLastNameController.value,
                                          onChanged: (value) {
                                            SharePrefsHelper.saveString('lastName', value);
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) return AppStrings.enterYourName;
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  CustomFormCard(
                                    prefixIcon: Icon(Icons.mail_outline_outlined, color: AppColors.primary),
                                    title: AppStrings.email,
                                    hintText: AppStrings.enterYourEmail,
                                    controller: therapistPC.therapistEmailController.value,
                                    onChanged: (value) {
                                      SharePrefsHelper.saveString('email', value);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return AppStrings.enterYourEmail;
                                      if (!AppStrings.emailRegexp.hasMatch(value)) return "Enter a valid email";
                                      return null;
                                    },
                                  ),

                                  CustomFormCard(
                                    prefixIcon: Icon(Icons.contact_phone_outlined, color: AppColors.primary),
                                    title: AppStrings.contact,
                                    hintText: AppStrings.typeHere,
                                    controller: therapistPC.therapistPhoneController.value,
                                    onChanged: (value) {
                                      SharePrefsHelper.saveString('phone', value);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return AppStrings.enterYourPhone;
                                      if (value.length < 10) return "Enter a valid phone number";
                                      return null;
                                    },
                                  ),
                                  CustomFormCard(
                                    title: AppStrings.password,
                                    hintText: AppStrings.enterYourPassword,
                                    isPassword: true,
                                    controller: therapistPC.therapistPasswordController.value,
                                    onChanged: (value) {
                                      SharePrefsHelper.saveString('password', value);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return AppStrings.enterYourPassword;
                                      if (value.length < 8) return AppStrings.enterThe8Character;
                                      return null;
                                    },
                                  ),

                                  CustomFormCard(
                                    title: AppStrings.confirmPassword,
                                    hintText: AppStrings.enterYourPassword,
                                    isPassword: true,
                                    controller: therapistPC.therapistConfirmPasswordController.value,
                                    onChanged: (value) {
                                      SharePrefsHelper.saveString('confirmPassword', value);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return AppStrings.enterYourPassword;
                                      if (value != therapistPC.therapistPasswordController.value.text) {
                                        return AppStrings.passwordNotMatch;
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 20.h),

                                  /// Next Button
                                  CustomButton(
                                    title: AppStrings.next,
                                    onTap: () async {
                                      if (!formKey.currentState!.validate()) return;

                                      String email = therapistPC.therapistEmailController.value.text.trim();
                                      String phone = therapistPC.therapistPhoneController.value.text.trim();

                                      // ✅ Email check
                                      if (await SharePrefsHelper.isEmailExists(email)) {
                                        Fluttertoast.showToast(msg: "This email is already registered");
                                        return;
                                      }

                                      // ✅ Phone check
                                      if (await SharePrefsHelper.isPhoneExists(phone)) {
                                        Fluttertoast.showToast(msg: "This phone is already registered");
                                        return;
                                      }

                                      // ✅ Image check
                                      if (therapistPC.selectedImage.value == null) {
                                        Fluttertoast.showToast(msg: AppStrings.selectYourProfileImage);
                                        return;
                                      }

                                      // ✅ Save user data (list + current user)
                                      await SharePrefsHelper.saveUserLocally(email, phone);

                                      // ✅ Clear temp auth data
                                      authController.clearUserData();

                                      // ✅ Navigate next
                                      Get.toNamed(AppRoutes.specializationScreen);
                                    },
                                  ),


                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
 