import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/user_my_booking_controller.dart';

class CancelationRequestScreen extends StatelessWidget {
  CancelationRequestScreen({super.key});

  final UserMyBookingController userMyBookingController = Get.find<UserMyBookingController>();
  final id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.cancelationRequest,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomFormCard(
              title: AppStrings.reason,
              hintText: "Type here......",
              maxLine: 5,
              controller: userMyBookingController.reasonController.value,
            ),
            SizedBox(height: 30.h),
            Obx(() => CustomButton(
              onTap: userMyBookingController.isLoading.value
                  ? () {} //
                  : () => userMyBookingController.deleteAppointment(id),
              title: userMyBookingController.isLoading.value
                  ? "Loading"
                  : "Submit",
            )),
          ],
        ),
      ),
    );
  }
}