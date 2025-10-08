import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/components/custom_nav_bar/navbar.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:counta_flutter_app/view/screens/chat_screen/view/widget/custom_inbox_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomRoyelAppbar(
         // leftIcon: true,
          titleName: "Inbox",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              CustomTextField(
                prefixIcon: Icon(Icons.search),
                hintText: "Search for doctors",
                fillColor: AppColors.white,
              ),
              SizedBox(
                height: 20.h,
              ),

              ///====================== Inbox list =======================
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: List.generate(6, (index){
                    return CustomInboxList(
                      onTap: (){
                        Get.toNamed(AppRoutes.messageScreen);
                      },
                      imageUrl: AppConstants.profileImage,
                      name: "Dr. Jane Doe",
                      title: "Hi, How are you?",
                      time: "2 min ago",
                    );})
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: NavBar(currentIndex: 2));
  }
}
