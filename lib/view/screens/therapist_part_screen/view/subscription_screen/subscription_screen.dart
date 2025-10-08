// ignore_for_file: use_key_in_widget_constructors

import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/general_error.dart';
import 'controller/subscription_controller.dart';
import 'widget/custom_subscription.dart';

class SubscriptionScreen extends StatelessWidget {
  final subscriptionController = Get.find<SubscriptionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "Subscription",
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 60.h, top: 10.h),
        child: Obx(() {
          switch (subscriptionController.subscriptionLoader.value) {
            case Status.loading:
              return Center(child: CustomLoader());
            case Status.internetError:
            case Status.error:
              return GeneralErrorScreen(
                onTap: () => subscriptionController.getSubscriptionList(),
              );
            case Status.completed:
              if (subscriptionController.subscriptionList.isEmpty) {
                return Center(
                  child: Text(
                    "No subscriptions available.",
                    style: TextStyle(fontSize: 16.sp, color: AppColors.white),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: subscriptionController.subscriptionList.length,
                      itemBuilder: (context, index) {
                        var subscription =
                            subscriptionController.subscriptionList[index];
                        return SubscriptionOption(
                          title: subscription.name ?? "No Name",
                          description:
                              subscription.features?[0] ?? "No Features",
                          price:
                              subscription.price?.amount?.toString() ?? "0.00",
                          type: subscription.validity?.type ?? "",
                          index: index,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    onTap: () {
                      if (subscriptionController.selectedIndex.value == -1) {
                        Get.snackbar(
                          "No Subscription Selected",
                          "Please select a subscription to continue.",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.black.withValues(alpha: .6),
                          colorText: AppColors.primary,
                        );
                      } else {
                        // যদি সাবস্ক্রিপশন সিলেক্ট করা হয়
                        Get.toNamed(
                          AppRoutes.paymentSummeryScreen,
                          arguments: {
                            'price': subscriptionController
                                .subscriptionList[
                                    subscriptionController.selectedIndex.value]
                                .price
                                ?.amount
                                .toString(),
                          },
                        );
                      }
                    },
                    title: AppStrings.buyNow,
                  ),
                ],
              );
            }
        }),
      ),
    );
  }
}
