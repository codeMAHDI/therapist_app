// ignore_for_file: prefer_const_constructors
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/screens/chat_screen/controller/chat_controller.dart';
import 'package:counta_flutter_app/view/screens/chat_screen/view/widget/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: CustomAppbarTwo(appBarContent: AppStrings.message),
      // backgroundColor: AppColors.white.withOpacity(7),
      body: Column(
        children: [
         // _builAppBar(context),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: List.generate(
                    10,
                        (index) => CustomChatCard(
                      title: 'Rossi Mario',
                      subtitle: 'Come stai oggi?',
                      imageUrl: AppConstants.profileImage,
                      time: '2 min ago',
                      isActive: true,
                      onTap: () {
                       // Get.toNamed(AppRoutes.messageScreen);
                      },
                    ),
                  )),
            ),
          )
        ],
      ),
   // bottomNavigationBar: NavBar(currentIndex: 3,),
    );
  }
}
