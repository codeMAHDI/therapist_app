import 'dart:math';

import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/time_converter/time_converter.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_nav_bar/therapist_navbar.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:counta_flutter_app/view/components/general_error.dart';
import 'package:counta_flutter_app/view/screens/chat_screen/view/widget/custom_inbox_list.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../helper/images_handle/image_handle.dart';

class TherapistInboxScreen extends StatelessWidget {
  TherapistInboxScreen({super.key});

  final TherapistChatController controller =
      Get.find<TherapistChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: "Inbox"),
      body: Obx(() {
        switch (controller.getConversationStatus.value) {
          case Status.loading:
            return CustomLoader();
          case Status.internetError:
            return Center(child: CustomLoader());
          case Status.error:
            return GeneralErrorScreen(
                onTap: () => controller.getConversation());
          case Status.completed:
            if (controller.conversationList.isEmpty) {
              return Center(child: Text("No conversations available"));
            }

            // Sort conversation list by lastMessage.updatedAt (latest first)
            List sortedConversations = List.from(controller.filteredConversations);
            sortedConversations.sort((a, b) {
              DateTime dateA = a.lastMessage?.id?.updatedAt != null
                  ? DateTime.tryParse(a.lastMessage!.id!.updatedAt!) ??
                      DateTime(0)
                  : DateTime(0);

              DateTime dateB = b.lastMessage?.id?.updatedAt != null
                  ? DateTime.tryParse(b.lastMessage!.id!.updatedAt!) ??
                      DateTime(0)
                  : DateTime(0);

              return dateB.compareTo(dateA); // Sort descending
            });

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  CustomTextField(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search for patients",
                    hintStyle: TextStyle(color: AppColors.black_03),
                    fillColor: AppColors.white,
                    onChanged: (value) {
                      controller.filterConversations(value);
                    },
                  ),
                  SizedBox(height: 20.h),

                  ///====================== Inbox list =======================
                  Expanded(
                    child: ListView.builder(
                      itemCount: sortedConversations.length,
                      itemBuilder: (context, index) {
                        final data = sortedConversations[index];

                        debugPrint(
                            "Conversation ${data.id}: LastMessage at ${data.lastMessage?.id?.updatedAt}");

                        return CustomInboxList(
                          onTap: () {
                            Get.toNamed(AppRoutes.therapistMeesageScreen,
                                arguments: data);
                          },
                          imageUrl: ImageHandler.imagesHandle(
                              controller.patientImageByAppointmentId[
                                      data.appointment ?? ''] ??
                                  controller.patientImageByUserId[
                                      data.patient?.patientUserId?.id ?? ''] ??
                                  data.patient?.profileImage ??
                                  ''),
                          name: data.patient?.name ?? "Unknown",
                          title: () {
                            final msg = data.lastMessage?.id?.content;
                            if (msg == null || msg.isEmpty)
                              return "No messages yet";
                            return msg.length > 10
                                ? "${msg.substring(0, min<int>(30, msg.length))}..."
                                : msg;
                          }(),
                          time: data.lastMessage?.id?.updatedAt != null
                              ? DateConverter.formatTimeAgo(
                                  data.lastMessage!.id!.updatedAt!)
                              : "No messages",
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
        }
      }),
      bottomNavigationBar: TherapistNavbar(currentIndex: 2),
    );
  }
}
