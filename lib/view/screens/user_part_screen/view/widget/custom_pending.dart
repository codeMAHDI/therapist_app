import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPending extends StatelessWidget {
  final String? image;
  final String? drFirstName;
  final String? drLastName;
  final String? title;
  final String? time;
  final String? day;
  final String? status;
  final bool? showButton;
  final bool? showStatus;
  final Function()? onTapCancel;
  final Function()? onTapChat;
  final Color? colors;
  const CustomPending(
      {super.key,
      this.drFirstName,
      this.drLastName,
      this.title,
      this.time,
      this.day,
      this.status,
      this.image, this.showButton=false, this.showStatus=false, this.onTapCancel, this.onTapChat, this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0, left: 10.w, right: 10.w),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.navbarClr,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  imageUrl: image ?? "",
                  height: 65.h,
                  width: 65.w,
                  boxShape: BoxShape.circle,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: drFirstName ?? "",
                          fontSize: 20.w,
                          fontWeight: FontWeight.w600,
                          bottom: 8.h,
                          right: 6.w,
                        ),
                        CustomText(
                          text: drLastName ?? "",
                          fontSize: 20.w,
                          fontWeight: FontWeight.w600,
                          bottom: 8.h,
                        ),
                      ],
                    ),
                    CustomText(
                      text: title ?? "",
                      fontSize: 15.w,
                      fontWeight: FontWeight.w400,
                      bottom: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Row(
                         children: [
                           Icon(
                             Icons.access_time,
                             size: 17,
                             color: AppColors.primary,
                           ),
                           CustomText(
                             text: time ?? "",
                             fontSize: 15.w,
                             fontWeight: FontWeight.w400,
                             left: 6.w,
                           ),
                         ],
                       ),
                       SizedBox(width: 10.w,),
                       Row(
                         children: [
                           Icon(
                             Icons.calendar_month,
                             size: 17,
                             color: AppColors.primary,
                           ),
                           CustomText(
                             text: day ?? "",
                             fontSize: 15.w,
                             fontWeight: FontWeight.w400,
                             left: 6.w,
                           ),
                         ],
                       )
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: AppColors.primary,
              thickness: .6,
            ),
           SizedBox(height: 6.h,),
           showStatus!? Row(
              children: [
                CustomText(
                  text: "Status :  ",
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  right: 6.w,
                ),
                CustomText(
                  text: status ?? "",
                  fontSize: 18.w,
                  color: colors?? AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ): SizedBox(),
           showButton!? Row(
              children: [
                Flexible(
                    child: CustomButton(
                  onTap: onTapCancel!,
                  title: AppStrings.cancel,
                  height: 32,
                  isBorder: true,
                      borderWidth: 1,
                  textColor: AppColors.red,
                  fillColor: AppColors.navbarClr,
                )),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                    child: CustomButton(
                  onTap: onTapChat!,
                  title: AppStrings.chat,
                  height: 32,
                )),
              ],
            ): SizedBox(),
          ],
        ),
      ),
    );
  }
}
