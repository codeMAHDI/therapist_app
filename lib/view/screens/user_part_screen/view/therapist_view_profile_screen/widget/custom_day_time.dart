import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomDayTime extends StatelessWidget {
  final String? dayName;
  final String? startTime;
  final String? endTime;
  const CustomDayTime({super.key, this.dayName, this.startTime, this.endTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: dayName ?? "Monday",
              //  text: popularDoctorsModel.therapist?.profile?.availabilities?[0].dayName ?? "",
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
              Row(
                children: [
                  CustomText(
                    text: startTime ??"05:00 AM -",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    right: 20.w,
                  ),
                  CustomText(
                    text: endTime ?? " 09:00 PM",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
