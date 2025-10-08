import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes/app_routes.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(imageSrc: AppIcons.success),
            CustomText(
              top: 10.h,
              bottom: 20.h,
              text: "Success",
              fontSize: 18.w,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
            CustomText(
              text: "Your payment was successful",
              fontSize: 14.w,
              fontWeight: FontWeight.w400,
              color: AppColors.lightWhite,
              bottom: 30.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: CustomButton(onTap: (){
                Get.toNamed(AppRoutes.therapistHomeScreen);
              }, title: "Go to Home",),
            )
          ],
        ),
      ),
    );
  }
}
