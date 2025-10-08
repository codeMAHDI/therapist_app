import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppointRow extends StatelessWidget {
  final String? image;
  final String? firstName;
  final String? lastName;
  final String? time;
  final String? day;
  final String? price;
  //========== show Three Button ===========
  final bool? showThreeButton;
  final String? threeButtonOneText;
  final String? threeButtonTwoText;
  final String? threeButtonThreeText;
  final Function()? onTapThreeButtonOne;
  final Function()? onTapThreeButtonTwo;
  final Function()? onTapThreeButtonThree;
  //========== show Chat Button ===========
  final bool? showChatButton;
  final bool? showApproveButton;
  final Function()? onTapChatButton;
  //========== show Two Button ===========
  final bool? showTwoButton;
  final Function()? onTapTwoButtonOne;
  final Function()? onTapApproveButton;
  final Function()? onTapTwoButtonTwo;
  final bool? divider;

  const CustomAppointRow({
    super.key,
    this.image,
    this.firstName,
    this.lastName,
    this.time,
    this.day,
    this.price,
    this.showThreeButton = false,
    this.showChatButton = false,
    this.showTwoButton = false,
    this.divider = true,
    this.threeButtonOneText,
    this.threeButtonTwoText,
    this.threeButtonThreeText,
    this.onTapThreeButtonOne,
    this.onTapThreeButtonTwo,
    this.onTapThreeButtonThree,
    this.onTapChatButton,
    this.onTapTwoButtonOne,
    this.onTapTwoButtonTwo,
    this.showApproveButton,
    this.onTapApproveButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: AppColors.navbarClr,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomNetworkImage(
                      imageUrl: image ?? "",
                      height: 65.w,
                      width: 65.w,
                      boxShape: BoxShape.circle,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: firstName ?? "",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              bottom: 4.h,
                              right: 6.w,
                            ),
                            CustomText(
                              text: lastName ?? "",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              bottom: 4.h,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: AppColors.primary,
                              size: 15,
                            ),
                            CustomText(
                              text: time ?? "",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              left: 8.w,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: price ?? "",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      bottom: 4.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: AppColors.primary,
                          size: 15,
                        ),
                        CustomText(
                          text: day ?? "",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          left: 8.w,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            divider!
                ? Divider(
              color: AppColors.primary,
              thickness: .3,
            )
                : SizedBox(),
            if (showThreeButton ?? false)
              Row(
                children: [
                  Flexible(
                    child: CustomButton(
                      onTap: onTapThreeButtonOne ?? () {},
                      title: threeButtonOneText ?? "Button 1",
                      height: 32.h,
                      isBorder: true,
                      textColor: AppColors.red,
                      borderWidth: .5,
                      fontSize: 14.sp,
                      fillColor: AppColors.navbarClr,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Flexible(
                    child: CustomButton(
                      onTap: onTapThreeButtonTwo ?? () {},
                      title: threeButtonTwoText ?? "Button 2",
                      height: 32.h,
                      isBorder: true,
                      textColor: AppColors.primary,
                      borderWidth: .5,
                      fontSize: 14.sp,
                      fillColor: AppColors.navbarClr,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Flexible(
                    child: CustomButton(
                      onTap: onTapThreeButtonThree ?? () {},
                      title: threeButtonThreeText ?? "Button 3",
                      height: 32.h,
                    ),
                  ),
                ],
              ),
            if (showChatButton ?? false)
              CustomButton(
                onTap: onTapChatButton ?? () {},
                title: AppStrings.chat,
                height: 32.h,
              ),
            if (showTwoButton ?? false)
              Row(
                children: [
                  Flexible(
                    child: CustomButton(
                      onTap: onTapTwoButtonOne ?? () {},
                      title: "Cancel",
                      height: 32.h,
                      isBorder: true,
                      textColor: AppColors.red,
                      borderWidth: .5,
                      fontSize: 14.sp,
                      fillColor: AppColors.navbarClr,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Flexible(
                    child: CustomButton(
                      onTap: onTapTwoButtonTwo ?? () {},
                      title: "Approve",
                      height: 32.h,
                    ),
                  ),
                ],
              ),
            if (showApproveButton ?? false)
              CustomButton(
                onTap: onTapApproveButton ?? () {},
                title: "Approve",
                height: 32.h,
                fontSize: 14.sp,
                fillColor: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}