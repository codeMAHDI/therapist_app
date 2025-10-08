import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../components/custom_button/custom_button.dart';
import '../../../../../../components/custom_text/custom_text.dart';
class CustomCurrentPlan extends StatelessWidget {
  final Function() onTap;
  final String? title;
  final String? purchaseDate;
  final String? expirationDate;
  const CustomCurrentPlan({super.key, required this.onTap, this.title, this.purchaseDate, this.expirationDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: AppColors.navbarClr,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title ??"Basic Subscription",
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  top: 40,
                ),
                CustomButton(
                  onTap: () {},
                  title: "Active",
                  height: 35.h,
                  width: 80.w,
                  textColor: AppColors.white,
                  fontSize: 16.sp,
                  fillColor: AppColors.green,
                ),
              ],
            ),
            SizedBox(height: 12.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Purchase Date :",
                  fontSize: 18.w,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: purchaseDate?? "",
                  fontSize: 18.w,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            SizedBox(height: 12.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Expiration Date :",
                  fontSize: 18.w,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: expirationDate ??"",
                  fontSize: 18.w,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            SizedBox(height: 8.h,),
            CustomButton(
              onTap: onTap,
              title: "Cancel Plan",
              height: 35.h,
              width: 120.w,
              textColor: AppColors.white,
              fontSize: 16.sp,
              fillColor: AppColors.red,
            ),
            SizedBox(height: 8.h,),
          ],
        ),
      ),
    );
  }
}
