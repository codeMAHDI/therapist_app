import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/shared_prefe/shared_prefe.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_nav_bar/therapist_navbar.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/controller/therapist_home_controller.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_bookings_screen/therapist_reschedule_screen.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/widget/custom_appoint_row.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_profile_screen/Invoice_list_sceen/model/invoice_by_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../helper/images_handle/image_handle.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/general_error.dart';
import '../therapist_chat_screen/controller/chat_controller.dart';

class TherapistBookingsScreen extends StatefulWidget {
  const TherapistBookingsScreen({super.key});
  @override
  State<TherapistBookingsScreen> createState() => _MyBookingsScreenState();
}

final userId = SharePrefsHelper.getString(AppConstants.userId);

class _MyBookingsScreenState extends State<TherapistBookingsScreen> {
  final TherapistHomeController therapistHomeController =
      Get.find<TherapistHomeController>();
  final therapistChatController = Get.find<TherapistChatController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: false,
        titleName: AppStrings.myBookings,
      ),
      body: Column(
        children: [
          Obx(() {
            return CustomTabSingleText(
                tabs: therapistHomeController.appointmentTypeList,
                selectedIndex: therapistHomeController.currentIndex.value,
                onTabSelected: (value) {
                  therapistHomeController.currentIndex.value = value;
                  // setState(() {});
                  therapistHomeController.getAppointmentList();
                },
                selectedColor: AppColors.primary,
                unselectedColor: AppColors.white);
          }),
          SizedBox(
            height: 20.h,
          ),

          ///=============== Pending ================
          Expanded(child: Obx(() {
            switch (therapistHomeController.appointmentListLoader.value) {
              case Status.loading:
                return Center(child: CustomLoader());
              case Status.internetError:
                return GeneralErrorScreen(
                    onTap: () => therapistHomeController.getAppointmentList());
              case Status.error:
                return GeneralErrorScreen(
                    onTap: () => therapistHomeController.getAppointmentList());
              case Status.completed:
                return ListView(
                  shrinkWrap: true,
                  children: [
                    if (therapistHomeController.currentIndex.value == 0)
                      therapistHomeController.appointmentList.isNotEmpty
                          ? Column(
                              children: List.generate(
                                  therapistHomeController
                                      .appointmentList.length, (index) {
                              final data = therapistHomeController
                                  .appointmentList[index];
                              return CustomAppointRow(
                                image: ImageHandler.imagesHandle(
                                    data.patient?.profile.image ?? ""),
                                //image: "${ApiUrl.imageUrl}${data.patient?.profile.image ?? ""}",
                                firstName: data.patient?.firstName,
                                lastName: data.patient?.lastName,
                                time: data.slot,
                                day: data.date.toString().split(" ").first,
                                showThreeButton: true,
                                threeButtonOneText: 'Cancel',
                                threeButtonTwoText: 'Chat',
                                threeButtonThreeText: 'Accept',

                                onTapTwoButtonOne: () {
                                  therapistHomeController
                                      .acceptedAppointment(data.id ?? '');
                                  Get.toNamed(AppRoutes.patientDetailsScreen);
                                },
                                onTapTwoButtonTwo: () {
                                  Get.toNamed(AppRoutes.patientDetailsScreen,
                                      arguments: data);
                                },
                                onTapThreeButtonOne: () {
                                  Get.dialog(
                                    AlertDialog(
                                      backgroundColor: AppColors.white,
                                      title: SizedBox(
                                        width: double.infinity,
                                        child: CustomText(
                                          color: Colors.black,
                                          text: 'Confirm Cancellation',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      content: SizedBox(
                                        width: double.infinity,
                                        child: CustomText(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          text:
                                              'Are you sure you want to cancel?',
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: CustomText(
                                            color: Colors.black,
                                            text: 'No',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                            therapistHomeController
                                                .cancelAppointmentByTherapist(
                                                    data.id ?? "");
                                          },
                                          child: CustomText(
                                            text: 'Yes',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                  );
                                },
                                onTapThreeButtonTwo: () {
                                  Get.snackbar("Warning",
                                      "You must approve the appointment before you can chat.");
                                  /* therapistChatController.checkCreateConversation(
    appointmentID: therapistHomeController.appointmentList[index].id??"",
  );*/
                                },
                                onTapThreeButtonThree: () {
                                  therapistHomeController
                                      .acceptedAppointment(data.id ?? '');
                                  Get.snackbar("Success",
                                      'Appointment accepted successfully');
                                  // Get.toNamed(AppRoutes.patientDetailsScreen);
                                },
                              );
                            }))
                          : Center(
                              child: CustomText(
                                top: 300.h,
                                text: "No appointment found",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.orange,
                              ),
                            ),

                    ///================ Complete =================
                    if (therapistHomeController.currentIndex.value == 1)
                      therapistHomeController.appointmentList.isNotEmpty
                          ? Column(
                              children: List.generate(
                                therapistHomeController.appointmentList.length,
                                (index) {
                                  return CustomAppointRow(
                                    image: ImageHandler.imagesHandle(
                                        therapistHomeController
                                                .appointmentList[index]
                                                .patient
                                                ?.profile
                                                .image ??
                                            ""),
                                    //image: "${ApiUrl.imageUrl}${therapistHomeController.appointmentList[index].patient?.profile.image ?? ""}",
                                    firstName: therapistHomeController
                                        .appointmentList[index]
                                        .patient
                                        ?.firstName,
                                    lastName: therapistHomeController
                                        .appointmentList[index]
                                        .patient
                                        ?.lastName,
                                    time: therapistHomeController
                                        .appointmentList[index].slot,
                                    day: therapistHomeController
                                        .appointmentList[index].date
                                        .toString()
                                        .split(" ")
                                        .first,
                                    showChatButton: true,
                                    onTapChatButton: () {
                                      Get.toNamed(AppRoutes.messageScreen);
                                    },
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: CustomText(
                                top: 300.h,
                                text: "No appointment found",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.orange,
                              ),
                            ),

                    ///================ Cancelled Tab bar =================
                    if (therapistHomeController.currentIndex.value == 2)
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                            child: Container(
                              height: 40.h,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    therapistHomeController.tabNamelist.length,
                                    (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          therapistHomeController
                                              .appointmentTypeindex
                                              .value = index;
                                          therapistHomeController.update();
                                          therapistHomeController
                                              .getAppointmentList();
                                          // userHomeController.getLeaderBoardData();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40.h,
                                          width: screenWidth / 2.5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: therapistHomeController
                                                        .appointmentTypeindex
                                                        .value ==
                                                    index
                                                ? AppColors.primary
                                                : AppColors.white
                                                    .withValues(alpha: 0),
                                          ),
                                          child: CustomText(
                                            text: therapistHomeController
                                                .tabNamelist[index],
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          if (therapistHomeController
                                  .appointmentTypeindex.value ==
                              0)
                            therapistHomeController.appointmentList.isNotEmpty
                                ? Column(
                                    children: List.generate(
                                      therapistHomeController
                                          .appointmentList.length,
                                      (index) {
                                        final data = therapistHomeController
                                            .appointmentList[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(AppRoutes
                                                .patientsCompleteScreen);
                                          },
                                          child: CustomAppointRow(
                                            image: ImageHandler.imagesHandle(
                                                therapistHomeController
                                                        .appointmentList[index]
                                                        .patient
                                                        ?.profile
                                                        .image ??
                                                    ""),
                                            // image: "${ApiUrl.imageUrl}${data.patient?.profile.image ?? ""}",
                                            firstName:
                                                data.patient?.firstName ?? '',
                                            lastName:
                                                data.patient?.lastName ?? '',
                                            time: data.slot ?? '',
                                            day: data.date
                                                .toString()
                                                .split(" ")
                                                .first,
                                            divider: false,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : CustomText(
                                    top: 300.h,
                                    text: 'No appointment found',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                          if (therapistHomeController
                                  .appointmentTypeindex.value ==
                              1)
                            therapistHomeController.appointmentList.isNotEmpty
                                ? Column(
                                    children: List.generate(
                                        therapistHomeController
                                            .appointmentList.length, (index) {
                                    final data = therapistHomeController
                                        .appointmentList[index];
                                    return CustomAppointRow(
                                      image: ImageHandler.imagesHandle(
                                          therapistHomeController
                                                  .appointmentList[index]
                                                  .patient
                                                  ?.profile
                                                  .image ??
                                              ""),
                                      firstName: data.patient?.firstName ?? '',
                                      lastName: data.patient?.lastName ?? '',
                                      time: data.slot ?? '',
                                      day:
                                          data.date.toString().split(" ").first,
                                      showApproveButton: true,
                                      onTapApproveButton: () {
                                        Get.toNamed(
                                            AppRoutes.patientsCancelationReson,
                                            arguments: data);
                                      },
                                    );
                                  }))
                                : CustomText(
                                    top: 300.h,
                                    text: 'No appointment found',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                        ],
                      ),

                    ///================ Missed =================
                    if (therapistHomeController.currentIndex.value == 3)
                      therapistHomeController.appointmentList.isNotEmpty
                          ? Column(
                              children: List.generate(
                                  therapistHomeController
                                      .appointmentList.length, (index) {
                              var appointment = therapistHomeController
                                  .appointmentList[index];
                              var patient = appointment.patient;
                              debugPrint("✅" +
                                  "${appointment.id} listview builder a print hocce");
                              return CustomAppointRow(
                                image: ImageHandler.imagesHandle(
                                    therapistHomeController
                                            .appointmentList[index]
                                            .patient
                                            ?.profile
                                            .image ??
                                        ""), // Provide a fallback if the image is null
                                firstName: patient?.firstName ?? "Unknown",
                                lastName: patient?.lastName ?? "Patient",
                                time: appointment.slot ?? "Not available",
                                day: appointment.date
                                        ?.toString()
                                        .split(" ")
                                        .first ??
                                    "N/A",
                                showThreeButton: true,
                                threeButtonOneText: 'Cancel',
                                threeButtonTwoText: 'Chat',
                                threeButtonThreeText: 'Reschedule',
                                onTapThreeButtonOne: () {
                                  Get.dialog(
                                    AlertDialog(
                                      backgroundColor: AppColors.white,
                                      title: SizedBox(
                                        width: double.infinity,
                                        child: CustomText(
                                          color: Colors.black,
                                          text: 'Confirm Cancellation',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      content: SizedBox(
                                        width: double.infinity,
                                        child: CustomText(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          text:
                                              'Are you sure you want to cancel?',
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: CustomText(
                                            color: Colors.black,
                                            text: 'No',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                            therapistHomeController
                                                .cancelAppointmentByTherapist(
                                                    appointment.id ?? "");
                                          },
                                          child: CustomText(
                                            text: 'Yes',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                  );
                                },
                                onTapThreeButtonTwo: () {
                                  therapistChatController
                                      .checkCreateConversation(
                                          appointmentID: appointment.id ?? "");
                                },
                                onTapThreeButtonThree: () async {
                                  //Get.toNamed(AppRoutes.patientsCompleteScreen);
                                  debugPrint("✅" +
                                      "${appointment.id} Jacche reschdule a ✅");
                                  final result =
                                      await Get.dialog(RescheduleDialog(
                                    bookingId: appointment.id ?? "",
                                  ));
                                  if (result != null) {
                                    print("User confirmed => $result");
                                    // Now you can call your PATCH API with result
                                  }
                                },
                              );
                            }))
                          : Center(
                              child: CustomText(
                                top: 300.h,
                                text: "No appointment found",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.orange,
                              ),
                            ),
                  ],
                );
            }
          }))
        ],
      ),
      bottomNavigationBar: TherapistNavbar(currentIndex: 1),
    );
  }
}
