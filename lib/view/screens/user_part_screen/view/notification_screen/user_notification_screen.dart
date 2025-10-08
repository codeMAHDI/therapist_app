import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../helper/time_converter/time_converter.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_show_popup/custom_show_popup.dart';
import '../../../../components/general_error.dart';
import '../widget/custom_notifay.dart';
import 'controller/notification_controller.dart';

class UserNotificationScreen extends StatelessWidget {
  UserNotificationScreen({super.key});
  final notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Notification",
        rightIcon: AppIcons.clear,
        rightOnTap: () {
          CustomPopUp.showPopUp(
              showRowButton: true,
              context: context,
              title: "Do you want to clear",
              discription: "Do you want to clear all notifications?",
              dateTime: "",
              leftTextButton: "Yes",
              rightTextButton: "No",
              leftOnTap: () {
                notificationController.clearAllNotification();
                Get.back();
              },
              rightOnTap: () {
                Get.back();
              });
        },
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            switch (notificationController.notificationListLoader.value) {
              case Status.loading:
                return Center(child: CustomLoader());
              case Status.internetError:
                return GeneralErrorScreen(
                    onTap: () => notificationController.getNotificationList());
              case Status.error:
                return GeneralErrorScreen(
                    onTap: () => notificationController.getNotificationList());
              case Status.completed:
                return notificationController.notificationList.isNotEmpty
                    ? Column(
                        children: List.generate(
                          notificationController.notificationList.length,
                          (index) {
                            final notification =
                                notificationController.notificationList[index];

                            final String notificationId = notification.id ?? "";
                            final bool isRead =
                                notification.isDismissed ?? false;

                            return GestureDetector(
                              onTap: () {
                                // Notification ke read hishebe mark koro
                                notificationController
                                    .markAsRead(notificationId);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: isRead
                                      ? AppColors.navbarClr
                                          .withValues(alpha: 0.1)
                                      : AppColors.navbarClr
                                          .withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                child: CustomNotifay(
                                  onTap: () {
                                    notificationController
                                        .dismisSingleNotification(
                                            id: notification.id ?? '');
                                    //  notificationController.markAsRead(notificationId);
                                    CustomPopUp.showPopUp(
                                        showRowButton: false,
                                        context: context,
                                        title: notificationController
                                                .notificationList[index]
                                                .content
                                                ?.title ??
                                            "",
                                        discription: notificationController
                                                .notificationList[index]
                                                .content
                                                ?.message ??
                                            "",
                                        dateTime:
                                            DateConverter.formatServerTime(
                                          notificationController
                                              .notificationList[index].createdAt
                                              .toString(),
                                        ),
                                        leftTextButton: "Yes",
                                        rightTextButton: "No",
                                        leftOnTap: () {},
                                        rightOnTap: () {});
                                  },
                                  isRead: isRead,
                                  text: notificationController
                                          .notificationList[index]
                                          .content
                                          ?.message ??
                                      "",
                                  time: DateConverter.formatServerTime(
                                    notificationController
                                        .notificationList[index].createdAt
                                        .toString(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: CustomText(
                          top: 300.h,
                          text: "Notification not found",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      );
            }
          },
        ),
      ),
    );
  }
}
