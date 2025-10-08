import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';

class CustomAvailabilityTimeSet extends StatelessWidget {
  final String? dayNames;
  final String? startTimeShow;
  final String? endTimeShow;
  final bool value;
  final TextEditingController? perDay;
  final void Function(bool)? onChanged;
  final Function()? startTimeButton;
  final Function()? endTimeButton;

  const CustomAvailabilityTimeSet(
      {super.key,
      this.dayNames,
      required this.value,
      this.startTimeShow,
      this.endTimeShow,
      this.perDay,
      this.onChanged, this.startTimeButton, this.endTimeButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: [
          // Availability Row for a Day (e.g. "Sun")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: dayNames ?? "",
                  fontSize: 18.w,
                  color: AppColors.white,
                  right: 8),
              // Start Time Container
              GestureDetector(
                onTap: startTimeButton,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  //width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.navbarClr,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                          text: "Start Time",
                          fontSize: 12.w,
                          color: AppColors.white,
                          bottom: 4),
                      CustomText(
                        text: startTimeShow ?? "", // Display selected time
                        fontSize: 18.w,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
              //SizedBox(width: 8.w,),
              // End Time Container
              GestureDetector(
                onTap: endTimeButton,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                 // width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.navbarClr,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                          text: "End Time",
                          fontSize: 12.w,
                          color: AppColors.white,
                          bottom: 4),
                      CustomText(
                        text: endTimeShow ?? "",
                        fontSize: 18.w,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeThumbColor: AppColors.primary,
              ),
            ],
          ),
          SizedBox(height: 8),
          // Max Appointment per day TextField
          Padding(
            padding: EdgeInsets.only(left: 44, right: 65),
            child: SizedBox(
              height: 55.h,
              child: CustomTextField(
                cursorColor: AppColors.white,
                fillColor: AppColors.navbarClr,
                fieldBorderRadius: 10,
                inputTextStyle: TextStyle(color: AppColors.white),
                hintText: "Max appointment per day",
                textEditingController: perDay,
                hintStyle: TextStyle(color: AppColors.white, fontSize: 15.w),
              ),
            ),
          )
        ],
      ),
    );
  }
}
