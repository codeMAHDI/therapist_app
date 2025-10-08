import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomProfileList extends StatelessWidget {
  final String imageSrc;
  final String text;
  final Function()? onTap;
  const CustomProfileList({super.key, required this.imageSrc, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                CustomImage(imageSrc: imageSrc, height: 24.w, width: 24.w,),
                CustomText(
                  text: text,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  left: 10.w,
                ),

              ],
            ),
            SizedBox(height: 15.h,),
            Padding(
              padding: const EdgeInsets.only(left: 30,),
              child: Container(
                height: 1,
                width: MediaQuery.sizeOf(context).width,
                color: AppColors.black_05,
              ),
            )
          ],
        ),
      ),
    );
  }
}
