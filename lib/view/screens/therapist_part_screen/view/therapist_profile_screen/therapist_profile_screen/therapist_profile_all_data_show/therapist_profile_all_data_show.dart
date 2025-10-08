import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_profile_screen/pdf_view_screen/pdf_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../../utils/app_strings/app_strings.dart';
import '../../../../../../components/custom_button/custom_button.dart';
import '../../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../../components/custom_text/custom_text.dart';
import '../../../../controller/therapist_register_controller.dart';

class TherapistProfileAllDataShow extends StatelessWidget {
  TherapistProfileAllDataShow({super.key});

  final therapistPC = Get.find<TherapistRegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Profile",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child:
              GetBuilder<TherapistRegisterController>(builder: (therapistPC) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //========= Personal Information ===========
                CustomText(
                  text: "Personal Information :",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 12.h,
                ),
                Row(
                  children: [
                    CustomText(
                      text:
                          "Full Name: ${therapistPC.therapistFirstName.text} ${therapistPC.therapistLastName.text}",
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500,
                      bottom: 8.h,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.email_outlined,
                        size: 16, color: AppColors.primary),
                    CustomText(
                        text: " Email: ${therapistPC.therapistEmail.text}",
                        fontSize: 16.h,
                        fontWeight: FontWeight.w500,
                        left: 10.w),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    const Icon(Icons.call, size: 16, color: AppColors.primary),
                    CustomText(
                        text:
                            " Phone: ${therapistPC.therapistPhoneNumber.text}",
                        fontSize: 16.h,
                        fontWeight: FontWeight.w500,
                        left: 10.w),
                  ],
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.therapistEditProfileScreen,
                            arguments:
                                therapistPC.therapistRegisterModel.value);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                const Divider(
                    color: AppColors.primary, thickness: 0.5, height: 24),

                //========= Medical Specialty Information ===========
                CustomText(
                  text: "Medical Specialty :",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 8.h,
                ),
                CustomText(
                  text: "Specialty: ${therapistPC.specializationName}",
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                  bottom: 8.h,
                ),
                CustomText(
                  text:
                      "Sub specialty: ${therapistPC.therapistSubSpecialization.text}",
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 8.h),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.editSpecializationScreen,
                            arguments:
                                therapistPC.therapistRegisterModel.value);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                const Divider(
                    color: AppColors.primary, thickness: 0.5, height: 24),

                //========= Experience : Information ===========
                CustomText(
                  text: "Experience : ",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 8.h,
                ),
                CustomText(
                  text:
                      "Years of Practice: ${therapistPC.therapistExperience.text}",
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                  bottom: 8.h,
                ),
                SizedBox(height: 8.h),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.editExperianceScreen,
                            arguments:
                                therapistPC.therapistRegisterModel.value);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                const Divider(
                    color: AppColors.primary, thickness: 0.5, height: 24),

                //========= Uploaded Documents : Information ===========
                CustomText(
                    text: "Uploaded Documents :",
                    fontSize: 18.h,
                    fontWeight: FontWeight.w600),
                Row(
                  children: [
                    CustomText(
                        text: "CV: ",
                        fontSize: 18.h,
                        fontWeight: FontWeight.w500),
                    TextButton(
                      onPressed: () {
                        final file = therapistPC.therapistCV.value;
                        if (file.isNotEmpty) {
                          Get.to(() => PdfViewerScreen(filePath: file));
                        } else {
                          Get.snackbar("Error", "No CV file found.");
                        }
                      },
                      child: CustomText(
                          text: "View PDF",
                          fontSize: 18.h,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                        text: "Certifications:",
                        fontSize: 18.h,
                        fontWeight: FontWeight.w500),
                    TextButton(
                      onPressed: () {
                        final files = therapistPC.therapistCertificate;
                        if (files.isNotEmpty) {
                          Get.to(() => PdfViewerScreen(filePath: files.first));
                        } else {
                          Get.snackbar("Error", "No certificate files found.");
                        }
                      },
                      child: CustomText(
                          text: "View PDF",
                          fontSize: 18.h,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.editUploadDocumentsScreen,
                            arguments:
                                therapistPC.therapistRegisterModel.value);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                const Divider(
                    color: AppColors.primary, thickness: 0.5, height: 24),

                //========= Profile Picture & Logo : ===========
                CustomText(
                    text: "Profile Picture & Logo :",
                    fontSize: 18.h,
                    fontWeight: FontWeight.w600,
                    bottom: 8.h),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CustomNetworkImage(
                            imageUrl: ImageHandler.imagesHandle(
                                therapistPC.therapistProfileImage.value),
                            height: 100,
                            width: 100,
                            boxShape: BoxShape.circle,
                          ),
                          CustomText(
                              text: "Profile picture",
                              fontSize: 16.h,
                              fontWeight: FontWeight.w500,
                              top: 8.h),
                        ],
                      ),
                      Column(
                        children: [
                          CustomNetworkImage(
                            imageUrl: ImageHandler.imagesHandle(
                                therapistPC.therapistBrandLogo.value),
                            height: 100,
                            width: 100,
                            boxShape: BoxShape.circle,
                          ),
                          CustomText(
                              text: "Logo view",
                              fontSize: 16.h,
                              fontWeight: FontWeight.w500,
                              top: 8.h),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.editUploadProfileLogoScreen,
                            arguments:
                                therapistPC.therapistRegisterModel.value);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                const Divider(
                    color: AppColors.primary, thickness: 0.5, height: 24),

                //========= Availability ===========
                CustomText(
                  text: "Availability :",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 8,
                  top: 4,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text:
                      "Full Name: ${therapistPC.therapistFirstName.text} ${therapistPC.therapistLastName.text}",
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  bottom: 8.h,
                ),
                Obx(() {
                  final availabilities = therapistPC.therapistRegisterModel
                          .value.profile?.availabilities ??
                      [];
                  final openDays =
                      availabilities.where((a) => a.isClosed == false).toList();

                  if (openDays.isEmpty) {
                    return CustomText(
                      text: "Schedule not set.",
                      fontSize: 16.h,
                      fontWeight: FontWeight.w500,
                    );
                  }

                  // Use a map to group days by their time slots. This handles multiple unique schedules.
                  final Map<String, List<String>> scheduleByTime = {};
                  for (var availability in openDays) {
                    final timeSlot =
                        "${availability.startTime} - ${availability.endTime}";
                    final dayName = availability.dayName ?? 'Unknown';

                    // If the time slot doesn't exist in the map, add it with a new list of days.
                    if (!scheduleByTime.containsKey(timeSlot)) {
                      scheduleByTime[timeSlot] = [];
                    }
                    // Add the current day to the list for that time slot.
                    scheduleByTime[timeSlot]!.add(dayName);
                  }

                  // Now, build a list of widgets from the grouped schedule.
                  List<Widget> scheduleWidgets = [];
                  scheduleByTime.forEach((time, days) {
                    scheduleWidgets.add(
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row for the Days (now scrollable)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.calendar_month,
                                      size: 16, color: AppColors.primary),
                                  SizedBox(width: 10.w),
                                  CustomText(
                                    text: "Days: ${days.join(', ')}",
                                    fontSize: 16.h,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            // Row for the Time
                            Row(
                              children: [
                                const Icon(Icons.access_time,
                                    size: 16, color: AppColors.primary),
                                SizedBox(width: 10.w),
                                CustomText(
                                  text: "Time: $time",
                                  fontSize: 16.h,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                    // Add a divider between different schedules for better readability
                    if (scheduleByTime.keys.last != time) {
                      scheduleWidgets.add(const Divider(
                          color: AppColors.primary,
                          thickness: 0.2,
                          height: 16));
                    }
                  });

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: scheduleWidgets,
                  );
                }),

                SizedBox(height: 12.h),
                /* Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.availabilityEditScreen, arguments: therapistPC.therapistRegisterModel.value);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),*/
                const Divider(
                    color: AppColors.primary, thickness: 0.5, height: 24),

                //========= Appointment Fee (Per Hour) ===========
                CustomText(
                  text: "Appointment Fee (Per Hour)",
                  fontSize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 8.h,
                  top: 8,
                ),
                CustomText(
                  text: "Fee: \$${therapistPC.therapistAppointmentFee.text}",
                  fontSize: 16.h,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 8.h),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.editAppointmentScreen,
                            arguments:
                                therapistPC.therapistRegisterModel.value);
                      },
                      title: AppStrings.edit,
                      height: 32.h,
                      width: 60.w,
                    )),
                SizedBox(height: 40.h),

                CustomButton(
                  onTap: () {
                    Get.back();
                  },
                  title: AppStrings.savedChanges,
                ),
                SizedBox(height: 20.h),
              ],
            );
          }),
        ),
      ),
    );
  }
}
