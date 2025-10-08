import 'dart:math';

import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/helper/time_converter/time_converter.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_nav_bar/navbar.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:counta_flutter_app/view/components/general_error.dart';
import 'package:counta_flutter_app/view/screens/chat_screen/view/widget/custom_inbox_list.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/user_chat_screen/controller/user_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserInboxScreen extends StatelessWidget {
  UserInboxScreen({super.key});

  final UserChatController controller = Get.find<UserChatController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomRoyelAppbar(
          // leftIcon: true,
          titleName: "Inbox",
        ),
        body: Obx(
          () {
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
                List sortedConversations =
                    List.from(controller.conversationList);
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      CustomTextField(
                        prefixIcon: Icon(Icons.search_rounded),
                        hintText: "Search for doctors",hintStyle: TextStyle(color: const Color.fromARGB(52, 0, 0, 0),fontSize: 17),
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        onChanged: (value) {
                          controller.filterConversations(value);
                        },
                      ),
                      SizedBox(height: 20.h),

                      ///====================== Inbox list =======================
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.filteredConversations.length,
                          itemBuilder: (context, index) {
                            final data =
                                controller.filteredConversations[index];

                            debugPrint(
                                "Conversation ${data.id}: LastMessage at ${data.lastMessage?.id?.updatedAt}");

                            return CustomInboxList(
                              onTap: () {
                                Get.toNamed(AppRoutes.userMeessageScreen,
                                    arguments: data);
                              },

                              imageUrl: ImageHandler.imagesHandle(
                                  controller.therapistImageByAppointmentId[
                                          data.appointment ?? ''] ??
                                      controller.therapistImageByUserId[
                                          data.therapist?.therapistUserId?.id ??
                                              ''] ??
                                      ''),

                              //ImageHandler.imagesHandle(data.therapist?.image ?? ""),
                              //imageUrl: ImageHandler.imagesHandle(data.therapist?.profile?.image ?? "https://via.placeholder.com/150",),
                              // "${ApiUrl.imageUrl}${data.therapist?.profile?.image ?? ""}",

                              name: data.therapist?.name ?? "Unknown",
                              // ===== with long text handle function of title =====
                              title: () {
                                final msg = data.lastMessage?.id?.content;
                                if (msg == null || msg.isEmpty)
                                  return "No messages yet";
                                return msg.length > 10
                                    ? "${msg.substring(0, min(20, msg.length))}..."
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
          },
        ),
        bottomNavigationBar: NavBar(currentIndex: 2));
  }
}
