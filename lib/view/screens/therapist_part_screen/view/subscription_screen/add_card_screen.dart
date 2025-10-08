import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../components/custom_button/custom_button.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: 'Add Card',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Enter your card details",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              bottom: 12.h,
            ),
            CustomFormCard(
                title: "Card-holder's Name",
                hintText: "Bessie Cooper",
                controller: TextEditingController()),
            CustomFormCard(
                title: "Card Number",
                hintText: "type your card number",
                controller: TextEditingController()),
            Row(
              children: [
                Flexible(
                  child: CustomFormCard(
                      title: "Expire Date",
                      hintText: "08/2026",
                      controller: TextEditingController()),
                ),SizedBox(width: 12.w,),
                Flexible(
                  child: CustomFormCard(
                      title: "CVC",
                      hintText: "452",
                      controller: TextEditingController()),
                )
              ],
            ),
            SizedBox(height: 60.h,),
            CustomButton(onTap: (){
              Get.toNamed(AppRoutes.successScreen);
            }, title: "Pay Now",)
          ],
        ),
      ),
    );
  }
}
