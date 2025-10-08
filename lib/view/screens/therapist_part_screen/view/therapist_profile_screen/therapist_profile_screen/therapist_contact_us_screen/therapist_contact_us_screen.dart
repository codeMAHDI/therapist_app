import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_strings/app_strings.dart';
import '../../../../../../components/custom_button/custom_button.dart';
import '../../../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../authentication/controller/auth_controller.dart';
import '../../../subscription_screen/controller/subscription_controller.dart';

class TherapistContactUsScreen extends StatelessWidget {
  TherapistContactUsScreen({super.key});
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
        padding: const EdgeInsets.all(19.8),
        child: Form(
          key: formKey,
          child: Obx(() {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
           //   physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  SizedBox(height: 50.h),
                  subscriptionController.contactUsLoader.value
                      ? CustomLoader()
                      : CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        subscriptionController.contactUsLoader();
                      }
                    },
                    title: AppStrings.send,
                  ),
                ],
              ),
            );
          }),
        ),
      ),

    );
  }
}
