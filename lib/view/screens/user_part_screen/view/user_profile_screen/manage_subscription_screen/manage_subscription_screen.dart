import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../therapist_part_screen/view/subscription_screen/widget/custom_subscription.dart';
import 'widget/custom_current_plan.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "Manage Subscription",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: "Current Plan Details", fontSize: 22.sp, fontWeight: FontWeight.w600,bottom: 16.h,),
            Column(
              children: List.generate(1, (index) {
                return CustomCurrentPlan(
                  onTap: () {},
                  purchaseDate: "",
                  expirationDate: "",
                );
              }),
            ),
            CustomText(text: "Available Plan", fontSize: 22.sp, fontWeight: FontWeight.w600,bottom: 16.h,),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  //var subscription =
                 // subscriptionController.subscriptionList[index];
                  return SubscriptionOption(
                    title: "No Name",
                    description: "No Features",
                    price:"0.00",
                    type: "Basic",
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: CustomButton(onTap: (){}, title: "Upgrade Now",),
      ),
    );
  }
}
