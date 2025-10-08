import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/app_routes/app_routes.dart';

class PaymentSummeryScreen extends StatelessWidget {
  PaymentSummeryScreen({super.key});

  // Get.arguments থেকে ডেটা রিসিভ করা
  final subscriptionDetails = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: "Payment Summery"),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppStrings.appointmentFee,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: '\$${subscriptionDetails['price'] ?? '0.00'}', // এখানে প্রেরিত ডেটা দেখানো হচ্ছে
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Additional Fee',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: '\$00.00',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Divider(height: 1, thickness: 1, color: AppColors.primary),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Total Fee',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: '\$${subscriptionDetails['price'] ?? '0.00'}', // টোটাল ফি দেখানো হচ্ছে
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.addCardScreen);
              },
              title: AppStrings.continueText,
            ),
          ],
        ),
      ),
    );
  }
}