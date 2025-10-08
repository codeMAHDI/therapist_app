import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAvailableSlot extends StatelessWidget {
  final String? text;
  final bool isSelected; // New parameter to track selection

  const CustomAvailableSlot({super.key, this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      width: MediaQuery.sizeOf(context).width / 2.3,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.black, // Change color if selected
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.white, // Change border color if selected
          width: 1,
        ),
      ),
      child: Center(
        child: CustomText(
          text: text ?? "",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : AppColors.white, // Change text color if selected
        ),
      ),
    );
  }
}