import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_loader/custom_loader.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../authentication/controller/auth_controller.dart';
import '../../../../therapist_part_screen/view/subscription_screen/controller/subscription_controller.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});
  final subscriptionController = Get.find<SubscriptionController>();
  final authController = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.contactUs,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Obx(() {
            return SingleChildScrollView(
             // scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  CustomFormCard(
                    hintText: AppStrings.writeHere,
                    title: AppStrings.submit,
                    controller: subscriptionController.subjectController.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.submit;
                      }
                      return null;
                    },
                  ),
                  CustomFormCard(
                    hintText: AppStrings.writeHere,
                    title: AppStrings.opinion,
                    maxLine: 5,
                    controller: subscriptionController.messageController.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.opinion;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  subscriptionController.contactUsLoader.value
                      ? CustomLoader()
                      : CustomButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              subscriptionController.contactUs(
                                firstName: authController
                                        .userProfileModel.value.firstName ??
                                    "",
                              );
                            }
                          },
                          title: AppStrings.send,
                        )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
