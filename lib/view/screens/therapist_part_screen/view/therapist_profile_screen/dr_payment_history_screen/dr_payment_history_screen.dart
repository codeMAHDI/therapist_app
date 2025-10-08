import 'package:counta_flutter_app/helper/time_converter/time_converter.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_payment_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/general_error.dart';
import '../../subscription_screen/controller/subscription_controller.dart';

class DrPaymentHistoryScreen extends StatelessWidget {
  DrPaymentHistoryScreen({super.key});
  final subscriptionController = Get.find<SubscriptionController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        // leftIcon: true,
        titleName: AppStrings.paymentHistory,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            switch (subscriptionController.paymentHistoryLoader.value) {
              case Status.loading:
                return Center(child: CustomLoader());
              case Status.internetError:
                return GeneralErrorScreen(
                    onTap: () => subscriptionController.getPaymentHistory());
              case Status.error:
                return GeneralErrorScreen(
                    onTap: () => subscriptionController.getPaymentHistory());
              case Status.completed:
                if (subscriptionController.paymentHistoryList.isEmpty) {
                  return Center(
                      child: CustomText(
                    text: "No Payment History",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ));
                } else {
                  return Column(
                      children: List.generate(
                          subscriptionController.paymentHistoryList.length,
                          (index) {
                    var payment =
                        subscriptionController.paymentHistoryList[index];
                    return CustomPaymentList(
                      firstName: payment.user?.firstName ?? "",
                      lastName: payment.user?.lastName ?? "",
                      time: DateConverter.formatServerTime(
                          payment.createdAt?.toString() ?? ""),
                      price: payment.amount?.toStringAsFixed(2) ??
                          "0.00", // Handle amount formatting
                    );
                  }));
                }
            }
          },
        ),
      ),
    );
  }
}
