import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/service/api_url.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_nav_bar/therapist_navbar.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_tab_selected/custom_tab_bar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/components/general_error.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/controller/chat_controller.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/widget/custom_today_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../helper/images_handle/image_handle.dart';
import '../../controller/therapist_home_controller.dart';
import '../../controller/therapist_register_controller.dart';

class TherapistHomeScreen extends StatefulWidget {
  const TherapistHomeScreen({super.key});

  @override
  State<TherapistHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<TherapistHomeScreen> {
  final TherapistHomeController homeController =
      Get.find<TherapistHomeController>();
  final therapistRegisterController = Get.find<TherapistRegisterController>();

  final TherapistChatController chatController =
      Get.find<TherapistChatController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height / 5.7,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    colors: [Color(0xffD4AF37), Color(0xffFFD700)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                color: AppColors.primary),
            child: Padding(
              padding: EdgeInsets.only(top: 80.h, left: 15.h, right: 15.h),
              child: Obx(
                () {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///======= welcome text =========
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text:
                                "Welcome  🤗 ",
                                fontSize: 24.h,
                                fontWeight: FontWeight.w700,
                              ),
                              //======= Therapist Name =========
                              CustomText(
                                text:
                                "${therapistRegisterController.therapistFirstName.value.text} ${therapistRegisterController.therapistLastName.value.text}",
                                fontSize: 24.h,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ///======= notification =========
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.userNotificationScreen);
                                  },
                                  icon: CustomImage(
                                    imageSrc: AppIcons.notification12,
                                    height: 35.h,
                                    width: 35.w,
                                    imageColor: AppColors.black,
                                  )),
                              CustomNetworkImage(
                                imageUrl: ImageHandler.imagesHandle(
                                    therapistRegisterController.therapistProfileImage.value),

                                //  imageUrl: "${ApiUrl.imageUrl}${therapistRegisterController.therapistProfileImage.value}",
                                height: 40.h,
                                width: 40.w,
                                boxShape: BoxShape.circle,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),

          ///=========== CARD============
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.sizeOf(context).width / 2.3,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      CustomImage(imageSrc: AppIcons.cardImage1),
                      //MANAGE AVAILABILITY
                      CustomButton(
                        onTap: () {
                          Get.toNamed(AppRoutes.manageAvailavilityScreen);
                        },
                        title: "MANAGE AVAILABILITY",
                        fontSize: 12,
                        height: 30.h,
                        borderRadius: 5,
                      )
                    ],
                  ),
                ),
                //APPOINTMENT HISTORY
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.sizeOf(context).width / 2.3,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      CustomImage(imageSrc: AppIcons.cardImage2),
                      CustomButton(
                        onTap: () {
                          Get.toNamed(AppRoutes.appointmentHistoryScreen);
                        },
                        title: "APPOINTMENT HISTORY",
                        fontSize: 12,
                        height: 30.h,
                        borderRadius: 5,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomText(
            text: AppStrings.appointments,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            top: 20.h,
            bottom: 10.h,
          ),
          //========================================= TAB BAR ================================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: CustomTabBar(
                tabs: homeController.nameList,
                selectedIndex: homeController.currentIndex.value,
                onTabSelected: (value) {
                  homeController.currentIndex.value = value;
                  setState(() {});
                  homeController.getAccpedAndToadyAppointment();
                  homeController.update();
                },
                selectedColor: AppColors.primary,
                unselectedColor: AppColors.white),
          ),
          SizedBox(
            height: 20.h,
          ),

          Expanded(
            child: Obx(() {
              switch (homeController.homeSatatus.value) {
                case Status.loading:
                  return Center(child: CustomLoader());
                case Status.error:
                  return GeneralErrorScreen(
                    onTap: () {
                      homeController.getAccpedAndToadyAppointment();
                      homeController.update();
                    },
                  );
                case Status.internetError:
                  return GeneralErrorScreen(
                    onTap: () {
                      homeController.getAccpedAndToadyAppointment();
                      homeController.update();
                    },
                  );
                case Status.completed:
                  return ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      ///================ Today =================
                      if (homeController.currentIndex.value == 0)
                        homeController.homeList.isNotEmpty
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: homeController.homeList.length,
                                itemBuilder: (context, index) {
                                  final data = homeController.homeList[index];
                                  return CustomTodayContainer(
                                    drName:
                                        "${data.patient?.firstName ?? ''} ${data.patient?.lastName ?? ''}",
                                    image: ImageHandler.imagesHandle(data.patient?.profile.image ?? ''),
                                    //image: '${ApiUrl.imageUrl}${data.patient?.profile.image ?? ''}',
                                    time: data.slot,
                                    title: data.reason,
                                    showButton: true,
                                    onTapChat: () {
                                      chatController.checkCreateConversation(
                                          appointmentID: data.id ?? '');
                                    },
                                    onTapCancel: () {},
                                  );
                                },
                              )
                            : Center(
                                child: CustomText(
                                  top: 150.h,
                                  text: 'You have no appointment today',
                                  fontSize: 18.w,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                      // Column(
                      //     children: List.generate(10, (index) {
                      //   return CustomTodayContainer(
                      //     onTapCancel: () {
                      //       //Get.toNamed(AppRoutes.cancelationRequestScreen);
                      //     },
                      //     onTapChat: () {
                      //       Get.toNamed(AppRoutes.messageScreen);
                      //     },
                      //     showButton: true,
                      //     image: AppConstants.profileImage,
                      //     drName: "Dr. Sarwar",
                      //     title: "Cardiologist",
                      //     time: "05:00Am - 05:30Am",
                      //     //day: "15 June",
                      //     status: "The request hasn't accepted yet",
                      //   );
                      // })),

                      ///================ Upcomming =================
                      if (homeController.currentIndex.value == 1)
                        homeController.homeList.isNotEmpty
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: homeController.homeList.length,
                                itemBuilder: (context, index) {
                                  final data = homeController.homeList[index];
                                  return CustomTodayContainer(
                                    drName: "${data.patient?.firstName ?? ''} ${data.patient?.lastName ?? ''}",
                                   image: ImageHandler.imagesHandle(data.patient?.profile.image ?? ''),
                                    //image: '${ApiUrl.imageUrl}${data.patient?.profile.image ?? ''}',
                                    time: data.slot,
                                    title: data.reason,
                                    showButton: true,
                                    onTapChat: () {
                                      chatController.checkCreateConversation(
                                          appointmentID: data.id ?? '');
                                    },
                                    onTapCancel: () {},
                                  );
                                },
                              )
                            : Center(
                                child: CustomText(
                                  top: 150.h,
                                  text: 'You have no upcomming appointment',
                                  fontSize: 18.w,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      // Column(
                      //     children: List.generate(2, (index) {
                      //   return CustomTodayContainer(
                      //     onTapCancel: () {
                      //       //Get.toNamed(AppRoutes.cancelationRequestScreen);
                      //     },
                      //     onTapChat: () {
                      //       Get.toNamed(AppRoutes.messageScreen);
                      //     },
                      //     showButton: true,
                      //     image: AppConstants.profileImage,
                      //     drName: "Dr. Sarwar",
                      //     title: "Cardiologist",
                      //     time: "05:00Am - 05:30Am",
                      //     showIcon: true,
                      //     day: "15 June",
                      //     status: "The request hasn't accepted yet",
                      //   );
                      // })),
                    ],
                  );
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: TherapistNavbar(currentIndex: 0),
    );
  }
}
