import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/app_routes/app_routes.dart';

class AddCardField extends StatelessWidget {
  const AddCardField({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Add Card",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Enter Card Details",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              bottom: 12.h,
            ),
            CustomFormCard(
                title: "Card Holder's Name",
                hintText: "type here....",
                controller: TextEditingController()),
            CustomFormCard(
                title: "Card Number",
                hintText: "type here....",
                controller: TextEditingController()),
            Row(
              children: [
                Flexible(
                  child: CustomFormCard(
                      title: "Expire Date",
                      hintText: "type here....",
                      controller: TextEditingController()),
                ),
                SizedBox(width: 10.w,),
                Flexible(
                  child: CustomFormCard(
                      title: "CVC",
                      hintText: "type here....",
                      controller: TextEditingController()),
                ),
              ],
            ),

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
        child: CustomButton(onTap: (){
          Get.toNamed(AppRoutes.bookedScreen);
        }, title: "Pay Now",),
      ),
    );
  }
}
