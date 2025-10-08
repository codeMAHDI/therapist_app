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
import '../pdf_view_screen/pdf_view_screen.dart';

class ProfileViewScreen extends StatelessWidget {
  ProfileViewScreen({super.key});
  final TherapistProfileController therapistPC =
      Get.find<TherapistProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.profile,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //========= Personal Information ===========
                CustomText(
                  text: "Personal Information ",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 8.h,
                ),
               Row(
                 children: [
                   CustomText(
                     text:
                     "First Name : ${therapistPC.therapistFirstNameController.value.text}",
                     fontSize: 16.h,
                     fontWeight: FontWeight.w500,
                     bottom: 8.h,
                   ),
                   CustomText(
                     text:
                     "Last Name : ${therapistPC.therapistLastNameController.value.text}",
                     fontSize: 16.h,
                     fontWeight: FontWeight.w500,
                     bottom: 8.h,
                   ),
                 ],
               ),
                Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    CustomText(
                      text:
                          "Email : ${therapistPC.therapistEmailController.value.text}",
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500,
                      left: 10.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    CustomText(
                      text:
                          "Phone : ${therapistPC.therapistPhoneController.value.text}",
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500,
                      left: 10.w,
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.therapistEditProfileScreen);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                SizedBox(
                  height: 6.h,
                ),
                Divider(
                  color: AppColors.primary,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 12.h,
                ),
                //========= Medical Specialty Information ===========
                CustomText(
                  text: "Medical Specialty ",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 8.h,
                ),
                CustomText(
                  text:
                      "Specialty : ${therapistPC.therapistSpecializationController.value.text}",
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                  bottom: 8.h,
                ),
                CustomText(
                  text:
                      "Sub specialty : ${therapistPC.therapistSubSpecializationController.value.text}",
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.editSpecializationScreen);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                SizedBox(
                  height: 6.h,
                ),
                Divider(
                  color: AppColors.primary,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 12.h,
                ),
                //========= Experience : Information ===========
                CustomText(
                  text: "Experience ",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 8.h,
                ),
                CustomText(
                  text:
                      "Years of Practice : ${therapistPC.therapistExperienceController.value.text}",
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                  bottom: 8.h,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.editExperianceScreen);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                SizedBox(
                  height: 6.h,
                ),
                Divider(
                  color: AppColors.primary,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 12.h,
                ),
                //========= Uploaded Documents : Information ===========
                CustomText(
                  text: "View Documents ",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "CV :",
                      fontSize: 18.h,
                      fontWeight: FontWeight.w500,
                    ),
                    TextButton(
                      onPressed: () {
                        final file = therapistPC.cvFile.value;

                        if (file != null && file.path.isNotEmpty && file.path.endsWith(".pdf")) {
                          Get.to(() => PdfViewerScreen(filePath: file.path)); // পিডিএফ ভিউ স্ক্রিনে যান
                        } else {
                          Get.snackbar("Error", "Invalid file format. Please select a valid PDF file.");
                        }
                      },
                      child: CustomText(
                        text: "View PDF",
                        fontSize: 18.h,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    CustomText(
                      text: "Certifications :",
                      fontSize: 18.h,
                      fontWeight: FontWeight.w500,
                    ),
                    TextButton(
                      onPressed: () {
                        final file = therapistPC.certificateFile.value;

                        if (file != null && file.path.isNotEmpty && file.path.endsWith(".pdf")) {
                          Get.to(() => PdfViewerScreen(filePath: file.path)); // পিডিএফ ভিউ স্ক্রিনে যান
                        } else {
                          Get.snackbar("Error", "Invalid file format. Please select a valid PDF file.");
                        }
                      },
                      child: CustomText(
                        text: "View PDF",
                        fontSize: 18.h,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                // CustomText(text: "Certifications: Certification1.pdf", fontSize: 16.h, fontWeight: FontWeight.w500,bottom: 8.h,),
                // SizedBox(height: 8.h,),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.uploadDocumentsScreen);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                SizedBox(
                  height: 6.h,
                ),
                Divider(
                  color: AppColors.primary,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 12.h,
                ),
                //========= Profile Picture & Logo : ===========
                CustomText(
                  text: "Profile Picture & Logo :",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        therapistPC.selectedImage.value != null
                            ? CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(therapistPC.selectedImage.value!),
                        )
                            : CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person,
                              size: 40, color: Colors.black),
                        ),
                        CustomText(
                          text: "Profile picture view",
                          fontSize: 16.h,
                          fontWeight: FontWeight.w500,
                          top: 8.h,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: therapistPC.brandLogoFile.value != null &&
                              therapistPC.brandLogoFile.value!.path.isNotEmpty
                              ? CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(therapistPC.brandLogoFile.value!),
                          )
                              : CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, size: 40, color: Colors.black),
                          ),
                        ),
                        CustomText(
                          text: "Logo view",
                          fontSize: 16.h,
                          fontWeight: FontWeight.w500,
                          top: 8.h,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                //========= Uploaded Documents : Information ===========
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Availability :",
                      fontSize: 18.h,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.uploadProfileLogoScreen);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: AppColors.primary,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 4.h,
                ),
                CustomText(
                  text: "Schedule Day & Time",
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                  bottom: 8.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    CustomText(
                      text: "Days : Monday - Friday",
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500,
                      left: 10.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    CustomText(
                      text: "Time: 10:00 AM - 4:00 PM",
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500,
                      left: 10.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.availabilityScreen);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                SizedBox(
                  height: 6.h,
                ),
                CustomText(
                  text: "Appointment Fee (Per Hour)",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 8.h,
                ),
                CustomText(
                  text:
                      "Fee: ${therapistPC.therapistAppointmentFeeController.value.text}",
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.appointmentScreen);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: AppColors.primary,
                    ),
                    CustomText(
                      text: "I agree to the",
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                      right: 4.w,
                    ),
                    CustomText(
                      text: "Terms and Conditions.",
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.therapistHomeScreen);
                  },
                  title: AppStrings.savedChanges,
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
