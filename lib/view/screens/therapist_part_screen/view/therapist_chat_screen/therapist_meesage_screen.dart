import 'package:counta_flutter_app/helper/images_handle/image_handle.dart';
import 'package:counta_flutter_app/helper/time_converter/time_converter.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:counta_flutter_app/view/components/general_error.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/controller/chat_controller.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/model/conversation_model.dart';
import 'package:counta_flutter_app/view/screens/therapist_part_screen/view/therapist_chat_screen/show_image_screen.dart/show_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TherapistMeesageScreen extends StatefulWidget {
  const TherapistMeesageScreen({super.key});

  @override
  State<TherapistMeesageScreen> createState() => _TherapistMeesageScreenState();
}

class _TherapistMeesageScreenState extends State<TherapistMeesageScreen> {
  final ConvarsationModel chat = Get.arguments;

  final TherapistChatController controller =
      Get.find<TherapistChatController>();

  @override
  void initState() {
    super.initState();
    controller.getAllMessage(conversationId: chat.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.messageStatusLoading.value) {
        case Status.loading:
          return Scaffold(
            backgroundColor: AppColors.black,
            body: Center(
              child: CustomLoader(),
            ),
          );
        case Status.internetError:
          return GeneralErrorScreen(
              onTap: () =>
                  controller.getAllMessage(conversationId: chat.id ?? ''));
        case Status.error:
          return GeneralErrorScreen(
              onTap: () =>
                  controller.getAllMessage(conversationId: chat.id ?? ''));
        case Status.completed:
          return Scaffold(
            backgroundColor: AppColors.black_02,
            appBar: AppBar(
              elevation: 0,
              surfaceTintColor: AppColors.black,
              backgroundColor: AppColors.black,
              leading: IconButton(
                icon: BackButton(color: AppColors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CustomNetworkImage(
                            imageUrl: ImageHandler.imagesHandle(controller
                                        .patientImageByAppointmentId[
                                    chat.appointment ?? ''] ??
                                controller.patientImageByUserId[
                                    chat.patient?.patientUserId?.id ?? ''] ??
                                chat.patient?.profileImage ??
                                ''),
                            height: 45.h,
                            width: 45.w,
                            boxShape: BoxShape.circle,
                          ),
                          Positioned(
                            bottom: 3.h,
                            right: 3.w,
                            child: Container(
                              height: 12.h,
                              width: 12.w,
                              decoration: BoxDecoration(
                                color: Colors
                                    .green, // Replace with dynamic online status
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            //   text: chat.patient?.name ?? 'User',
                            text: chat.patient?.name ?? 'User',
                            fontSize: 18.w,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            bottom: 4.h,
                          ),
                          CustomText(
                            text: 'Active now',
                            fontSize: 12.w,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.video_call,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          controller.startVideoCall(
                            conversationId: chat.id ?? '',
                            name: chat.therapist?.name ?? '',
                          );
                          // Get.to(() => CallingPage(
                          //       callID: chat.id ?? '',
                          //       userName: chat.therapist?.name ?? '',
                          //       userID:
                          //           chat.therapist?.therapistUserId?.id ?? '',
                          //     ));
                          // Get.toNamed(AppRoutes.callingPage);
                        },
                      ),
                      // IconButton(
                      //   icon: const Icon(
                      //     Icons.call,
                      //     color: AppColors.primary,
                      //   ),
                      //   onPressed: () {},
                      // ),
                    ],
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                //==================== Chat Messages List ====================
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Obx(() {
                      final avatarUrl = ImageHandler.imagesHandle(controller.patientImageByAppointmentId[chat.appointment ?? ''] ??
                              controller.patientImageByUserId[
                                  chat.patient?.patientUserId?.id ?? ''] ??
                              chat.patient?.profileImage ??
                              '');
                      return ListView.builder(
                        reverse: true,
                        itemCount: controller.messageList.length,
                        itemBuilder: (context, index) {
                          final data = controller.messageList[index];
                          return CustomInboxMessage(
                            isMe: data.sender?.id == controller.userId.value,
                            message: data.content ?? '',
                            messageTime: DateConverter.formatTimeAgo(
                                data.createdAt ?? ''),
                            type: data.type ?? '',
                            imageUrls: data.attachment ?? [],
                            avatarUrl: avatarUrl,
                          );
                        },
                      );
                    }),
                  ),
                ),

                //==================== Message Input Field ====================
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 40.h,
                    left: 10.w,
                    right: 15.w,
                    top: 10.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display selected images (if available)
                      if (controller.selectedImages.isNotEmpty)
                        SizedBox(
                          height: 110.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.selectedImages.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        controller.selectedImages[index],
                                        height: 100.h,
                                        width: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.selectedImages
                                            .removeAt(index);
                                        controller.update();
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primary,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.attach_file,
                                color: AppColors.white),
                            onPressed: () async {
                              await controller.pickImagesFromGallery();
                              controller
                                  .update(); // Refresh UI to show selected images
                            },
                          ),
                          Expanded(
                            child: CustomTextField(
                              cursorColor: AppColors.white,
                              inputTextStyle: TextStyle(color: AppColors.white),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send,
                                    color: AppColors.primary),
                                onPressed: () {
                                  if (controller.messageController.value.text
                                          .isNotEmpty ||
                                      controller.selectedImages.isNotEmpty) {
                                    controller.sendMessage(
                                      conversationId: chat.id ?? '',
                                      senderId:
                                          chat.therapist?.therapistUserId?.id ??
                                              '',
                                      // Send multiple images
                                    );
                                    // Clear images and text field after sending
                                    controller.selectedImages.clear();
                                    controller.messageController.value.clear();
                                    controller.update();
                                  }
                                },
                              ),
                              textEditingController:
                                  controller.messageController.value,
                              hintText: 'Type a message',
                              hintStyle: TextStyle(color: AppColors.white),
                              fieldBorderColor: Color(0xff3A3B3F),
                              fillColor: Color(0xff3A3B3F),
                              onChanged: (text) {
                                controller.messageController.refresh();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
      }
    });
  }
}

class CustomInboxMessage extends StatelessWidget {
  final bool isMe;
  final String message;
  final String? messageTime;
  final String type;
  final List<String> imageUrls;
  final String
      avatarUrl; // New parameter to fetch the avatar url of the patient

  const CustomInboxMessage({
    super.key,
    required this.isMe,
    required this.message,
    this.messageTime,
    required this.type,
    required this.imageUrls,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe)
              CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 16,
              ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (type == 'text') _buildMessageBubble(context),
                  if (type == 'attachment') _buildImageMessage(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //======================================== Build Message Bubble ========================================

  Widget _buildMessageBubble(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      decoration: BoxDecoration(
        color: isMe ? Colors.white : Colors.amber.shade50,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
          bottomLeft: isMe ? const Radius.circular(12) : Radius.zero,
          bottomRight: isMe ? Radius.zero : const Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                messageTime ?? '',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              if (isMe)
                Icon(
                  Icons.done_all,
                  size: 16,
                  color: Colors.blue, // Blue if read, grey if sent
                ),
            ],
          ),
        ],
      ),
    );
  }

  //============================================= Image Build ================================

  Widget _buildImageMessage(BuildContext context) {
    bool hasMultipleImages = imageUrls.length > 1;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? Colors.white : Colors.amber.shade50,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isMe ? const Radius.circular(12) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Single & Multiple Images Properly
            if (imageUrls.isNotEmpty)
              hasMultipleImages
                  ? SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => ShowImageScreen(
                                        imageUrl: ImageHandler.imagesHandle(
                                            imageUrls[index]),
                                        //ApiUrl.imageUrl + imageUrls[index],
                                      ));
                                },
                                child: CustomNetworkImage(
                                  imageUrl: ImageHandler.imagesHandle(
                                      imageUrls[index]),
                                  //ApiUrl.imageUrl + imageUrls[index],
                                  height: 200, // Fixed height
                                  width: 200, // Fixed width
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ShowImageScreen(
                                imageUrl:
                                    ImageHandler.imagesHandle(imageUrls.first),
                                //ApiUrl.imageUrl + imageUrls.first,
                              ));
                        },
                        child: CustomNetworkImage(
                          imageUrl: ImageHandler.imagesHandle(imageUrls.first),
                          //ApiUrl.imageUrl + imageUrls.first,
                          height: 200, // Fixed height
                          width: 200, // Fixed width
                        ),
                      ),
                    ),

            // Display text message (if available) under the image
            if (message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                  softWrap: true,
                  overflow:
                      TextOverflow.visible, // Ensures text wraps correctly
                ),
              ),

            // Message Time & Read Status
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  messageTime ?? '',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                if (isMe)
                  Icon(
                    Icons.done_all,
                    size: 16,
                    color: Colors.blue, // Blue if read, grey if sent
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
