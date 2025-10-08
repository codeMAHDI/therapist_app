import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTodayContainer extends StatelessWidget {
  final String? image;
  final String? drName;
  final String? title;
  final String? time;
  final String? day;
  final String? status;
  final bool? showButton;
  final bool? showStatus;
  final Function()? onTapCancel;
  final Function()? onTapChat;
  final Function()? onTapCall;
  final Color? colors;
  final bool? showIcon;
  const CustomTodayContainer({
    super.key,
    this.drName,
    this.title,
    this.time,
    this.day,
    this.status,
    this.image,
    this.showButton = false,
    this.showStatus = false,
    this.onTapCancel,
    this.onTapChat,
    this.onTapCall,
    this.colors,
    this.showIcon = false,
  });

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
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: drName ?? "",
                            fontSize: 20.w,
                            fontWeight: FontWeight.w600,
                          ),
                         /* IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert,
                                size: 15,
                                color: AppColors.primary,
                              ))*/
                        ],
                      ),
                      /*   CustomText(
                        text: title ?? "",
                        fontSize: 15.w,
                        fontWeight: FontWeight.w400,
                        bottom: 8.h,
                      ),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 17,
                            color: AppColors.primary,
                          ),
                          CustomText(
                            left: 10.w,
                            text: time ?? "",
                            fontSize: 15.w,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          showIcon!
                              ? Icon(
                                  Icons.calendar_month,
                                  size: 17,
                                  color: AppColors.primary,
                                )
                              : SizedBox(),
                          CustomText(
                            text: day ?? "",
                            fontSize: 15.w,
                            fontWeight: FontWeight.w400,
                            left: 10.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            /* Divider(
              color: AppColors.primary,
              thickness: .6,
            ),*/
            SizedBox(
              height: 6.h,
            ),
            showStatus!
                ? Row(
                    children: [
                      CustomText(
                        text: "Status :  ",
                        fontSize: 18.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                      CustomText(
                        text: status ?? "",
                        fontSize: 18.w,
                        color: colors ?? AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )
                : SizedBox(),
            showButton!
                ? Row(
                    children: [
                      Flexible(
                          child: CustomButton(
                        onTap:onTapChat!,
                        title: AppStrings.chat,
                        height: 32,
                        isBorder: true,
                        borderWidth: 1,
                        textColor: AppColors.primary,
                        fillColor: AppColors.navbarClr,
                      )),
                      SizedBox(
                        width: 10.w,
                      ),
                     /* Flexible(
                          child: CustomButton(
                        onTap: onTapCancel!,
                        title: AppStrings.joinCall,
                        height: 32,
                      )),*/
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
