import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/components/custom_nav_bar/navbar.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_tab_selected/custom_tab_single_text.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_pending.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/controller/user_my_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../service/api_url.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/general_error.dart';
import '../user_chat_screen/controller/user_chat_controller.dart';

class UserMyBookingsScreen extends StatefulWidget {
  const UserMyBookingsScreen({super.key});
  @override
  State<UserMyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<UserMyBookingsScreen> {
  final UserMyBookingController myBookingController =
      Get.find<UserMyBookingController>();
  final userChatController =Get.find<UserChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        // leftIcon: true,
        titleName: "My Appointment",
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          ///=============== Tab Bar ================
          CustomTabSingleText(
              tabs: myBookingController.nameList,
              selectedIndex: myBookingController.currentIndex.value,
              onTabSelected: (value) {
                myBookingController.currentIndex.value = value;
                setState(() {});
                myBookingController.getAppointmentList();
              },
              selectedColor: AppColors.primary,
              unselectedColor: AppColors.white),
          SizedBox(
            height: 20.h,
          ),

          ///=============== Pending ================
          Expanded(child: Obx(() {
            switch (myBookingController.appointmentListLoader.value) {
              case Status.loading:
                return Center(child: CustomLoader());
              case Status.internetError:
                return GeneralErrorScreen(
                    onTap: () => myBookingController.getAppointmentList());
              case Status.error:
                return GeneralErrorScreen(
                    onTap: () => myBookingController.getAppointmentList());
              case Status.completed:
                return ListView(
                  shrinkWrap: true,
                  children: [
                    if (myBookingController.currentIndex.value == 0)
                      myBookingController.appointmentList.isNotEmpty
                          ? Column(
                              children: List.generate(
                                  myBookingController.appointmentList.length,
                                  (index) {
                              return CustomPending(
                                showStatus: true,
                                image: ImageHandler.imagesHandle(myBookingController.appointmentList[index].therapist?.profile?.image ?? ""),
                                   // "${ApiUrl.imageUrl}${myBookingController.appointmentList[index].therapist?.profile?.image ?? ""}",
                                drFirstName: myBookingController
                                    .appointmentList[index]
                                    .therapist
                                    ?.firstName,
                                drLastName: myBookingController
                                    .appointmentList[index].therapist?.lastName,
                                title: myBookingController
                                    .appointmentList[index]
                                    .therapist
                                    ?.profile
                                    ?.speciality
                                    ?.name,
                                time: myBookingController
                                    .appointmentList[index].slot,
                                day: myBookingController
                                    .appointmentList[index].date
                                    .toString()
                                    .split(" ")
                                    .first,
                                status: myBookingController
                                    .appointmentList[index].status,
                              );
                            }))
                          : CustomText(
                              top: 300.h,
                              text: "No Appointment",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),

                    ///================ Approved =================
                    if (myBookingController.currentIndex.value == 1)
                      myBookingController.appointmentList.isNotEmpty
                          ? Column(
                              children: List.generate(
                                  myBookingController.appointmentList.length,
                                  (index) {
                              return CustomPending(
                                onTapCancel: () {
                                  Get.toNamed(
                                      AppRoutes.cancelationRequestScreen,
                                      arguments: myBookingController
                                          .appointmentList[index].id);
                                },
                                onTapChat: () {
                                  userChatController.checkCreateConversation(
                                    appointmentID: myBookingController
                                        .appointmentList[index].id??"",
                                  );
                                 // Get.toNamed(AppRoutes.messageScreen);
                                },
                                showButton: true,
                                image: ImageHandler.imagesHandle(myBookingController.appointmentList[index].therapist?.profile?.image ?? ""),
                                   // "${ApiUrl.imageUrl}${myBookingController.appointmentList[index].therapist?.profile?.image ?? ""}",
                                drFirstName: myBookingController
                                    .appointmentList[index]
                                    .therapist
                                    ?.firstName,
                                drLastName: myBookingController
                                    .appointmentList[index].therapist?.lastName,
                                title: myBookingController
                                    .appointmentList[index]
                                    .therapist
                                    ?.profile
                                    ?.speciality
                                    ?.name,
                                time: myBookingController
                                    .appointmentList[index].slot,
                                day: myBookingController
                                    .appointmentList[index].date
                                    .toString()
                                    .split(" ")
                                    .first,
                                status: myBookingController
                                    .appointmentList[index].status,
                              );
                            }))
                          : CustomText(
                              top: 300.h,
                              text: "No Appointment",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                    ///================ Completed =================
                   if (myBookingController.currentIndex.value == 2)
                      myBookingController.appointmentList.isNotEmpty
                          ? Column(
                              children: List.generate(
                                  myBookingController.appointmentList.length,
                                  (index) {
                              return CustomPending(
                                showStatus: true,
                                image:
                                ImageHandler.imagesHandle(myBookingController.appointmentList[index].therapist?.profile?.image ?? ""),
                                  //  "${ApiUrl.imageUrl}${myBookingController.appointmentList[index].therapist?.profile?.image ?? ""}",
                                drFirstName: myBookingController
                                    .appointmentList[index]
                                    .therapist
                                    ?.firstName,
                                drLastName: myBookingController
                                    .appointmentList[index].therapist?.lastName,
                                title: myBookingController
                                    .appointmentList[index]
                                    .therapist
                                    ?.profile
                                    ?.speciality
                                    ?.name,
                                time: myBookingController
                                    .appointmentList[index].slot,
                                day: myBookingController
                                    .appointmentList[index].date
                                    .toString()
                                    .split(" ")
                                    .first,
                                status: myBookingController
                                    .appointmentList[index].status,
                                colors: AppColors.green,
                              );
                            }))
                          : CustomText(
                              top: 300.h,
                              text: "No Appointment",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),

                    ///================ Canceled =================
                    if (myBookingController.currentIndex.value == 3)
                      myBookingController.appointmentList.isNotEmpty
                          ? Column(
                              children: List.generate(
                                myBookingController.appointmentList.length,
                                (index) {
                                  return CustomPending(
                                    showStatus: true,
                                    image:
                                    ImageHandler.imagesHandle(myBookingController.appointmentList[index].therapist?.profile?.image ?? ""),
                                        //"${ApiUrl.imageUrl}${myBookingController.appointmentList[index].therapist?.profile?.image ?? ""}",
                                    drFirstName: myBookingController
                                        .appointmentList[index]
                                        .therapist
                                        ?.firstName,
                                    drLastName: myBookingController
                                        .appointmentList[index]
                                        .therapist
                                        ?.lastName,
                                    title: myBookingController
                                        .appointmentList[index]
                                        .therapist
                                        ?.profile
                                        ?.speciality
                                        ?.name,
                                    time: myBookingController
                                        .appointmentList[index].slot,
                                    day: myBookingController
                                        .appointmentList[index].date
                                        .toString()
                                        .split(" ")
                                        .first,
                                    status: myBookingController
                                        .appointmentList[index].status,
                                    colors: AppColors.red,
                                  );
                                },
                              ),
                            )
                          : CustomText(
                              top: 300.h,
                              text: "No Appointment",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                  ],
                );
            }
          }))
        ],
      ),
      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}
