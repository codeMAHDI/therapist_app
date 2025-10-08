import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadProfileLogoScreen extends StatelessWidget {
  const UploadProfileLogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Upload Profile & Logo",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Step -04",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  bottom: 10.h,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: "Upload your Profile photo",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  DottedBorder(
                    child: SizedBox(
                      height: 210.h,
                      width: 150.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            color: AppColors.primary,
                            size: 30,
                          ),
                          CustomText(
                            top: 10.h,
                            text: "Upload Image",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: "Upload your Brand Logo",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  DottedBorder(
                    child: SizedBox(
                      height: 210.h,
                      width: 150.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            color: AppColors.primary,
                            size: 30,
                          ),
                          CustomText(
                            top: 10.h,
                            text: "Upload Logo",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomButton(
                onTap: () {},
                title: AppStrings.savedChanges,
              )
            ],
          ),
        ),
      ),
    );
  }
}
