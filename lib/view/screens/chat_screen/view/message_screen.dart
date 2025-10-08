// ignore_for_file: prefer_const_constructors
import 'package:counta_flutter_app/view/components/custom_image_add_send/custom_image_add_send.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../../utils/app_strings/app_strings.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../helper/time_converter/time_converter.dart';
import '../../../components/custom_image_add_send/custom_image_add_send_controller.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/general_error.dart';
import '../controller/chat_controller.dart';
import 'widget/custom_inbox_massage.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final customImageAddSendController = Get.find<CustomImageAddSendController>();
  final chatController = Get.find<ChatController>();

  final List<bool> align = [
    true,
    false,
    true,
    false,
    true,
    true,
    false,
    true,
    false,
    false,
    false
  ];

  String? userId;

  @override
  void initState() {
    getUserId();
    chatController.getMessage();
    super.initState();
  }

  Future<void> getUserId() async {
    userId = await SharePrefsHelper.getString(AppConstants.userId);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        surfaceTintColor: AppColors.black,
        elevation: 5,
        shadowColor: AppColors.black,
        centerTitle: false,
        backgroundColor: AppColors.black_80,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.profileImage,
                  height: 54.w,
                  width: 54.w,
                  boxShape: BoxShape.circle,
                ),
                Positioned(
                  bottom: 5.w,
                  right: 0,
                  child: Container(
                    height: 12.h,
                    width: 12.w,
                    decoration: BoxDecoration(
                        color: AppColors.green, shape: BoxShape.circle),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
               CustomText(
                  text: AppStrings.profile,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white),
              CustomText(
                text: "Active Now",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ]),
          ],
        ),
           actions: [
          IconButton(
            icon: Icon(Icons.videocam_outlined,color: AppColors.primary,),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call,color: AppColors.primary,),
            onPressed: () {},
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Obx(
       () {
         switch (chatController.messageStatusLoading.value) {
           case Status.loading:
             return Center(child: CustomLoader());
           case Status.internetError:
             return Center(
                 child: GeneralErrorScreen(
                     onTap: () => chatController.getMessage()));
           case Status.error:
             return GeneralErrorScreen(
                 onTap: () => chatController.getMessage());
           case Status.completed:
             return Column(
               children: [
                 //============================= Measage Screen =============================
                 Expanded(
                   child: Padding(
                     padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                     child: ListView(
                       //addAutomaticKeepAlives: true,
                       dragStartBehavior: DragStartBehavior.down,
                       reverse: true,
                       shrinkWrap: true,
                       children: List.generate(
                           chatController.messageList.length, (index) {
                         final data = chatController.messageList[index];
                         return CustomInboxMassage(
                           alignment: data.sender == 'user' ? false : true,
                           message: data.content ?? '',
                           messageTime: DateConverter.formatServerTime(
                             data.createdAt.toString(),
                           ),
                           type: data.type ?? '',
                           imageUrls: (data.attachment ?? []).cast<String>(),
                         );
                       }),
                     ),
                   ),
                 ),

                 ///================= image seledted and send ===========
                 Padding(
                   padding: const EdgeInsets.only(
                     right: 20.0,
                     left: 20,
                     bottom: 20,
                   ),
                   child: CustomImageAddSend(
                     //===== text field Controller ====
                     textEditingController:
                     chatController.messageController.value,
                     // textEditingController: customImageAddSendController.messageController,
                     fillColor: AppColors.white,
                     textColor: AppColors.black_04,
                     imageIconColor: AppColors.black_04,
                     //====== image button Controller ==
                     imageOnTapButton: () {
                       customImageAddSendController.pickImage();
                       // setState(() {

                       // });
                     },
                     //ustomImageAddSendController.pickImage,
                     //====== send button Controller ==
                     sendOnTapButton: () {
                       if (chatController
                           .messageController.value.text.isNotEmpty ||
                           customImageAddSendController.images.isNotEmpty) {
                         chatController.sendMessage(
                           message:
                           chatController.messageController.value.text,
                         );
                       }
                       //customImageAddSendController.sendMessage();
                     },
                   ),
                 ),
               ],
             );
         }
       },
      ),
    );
  }
}

