import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomInboxList extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? title;
  final String? time;
  final Function()? onTap;
  const CustomInboxList({super.key, this.imageUrl, this.name, this.title, this.time, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.navbarClr,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: imageUrl ?? "",
                    height: 40.w,
                    width: 40.w,
                    boxShape: BoxShape.circle,
                  ),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: name ?? "", fontSize: 16.sp, fontWeight: FontWeight.w500,bottom: 2.h,),
                      CustomText(text: (title!.length > 5) ? title ?? "" : "${title!.substring(0,1)}..." , fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ],
                  ),
                ],
              ),
              //SizedBox(width: 0.1.w,),
              CustomText(text: time ?? "", fontSize: 12.sp, fontWeight: FontWeight.w300),
            ],
          ),
        ),
      ),
    );
  }
}
