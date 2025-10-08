import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNotifay extends StatelessWidget {
  final String? text;
  final String? time;
  final bool isRead;
  final Function()? onTap;
  const CustomNotifay({super.key, this.text, this.time, required this.isRead, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 10, right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45.w, // Set the width of the outer circle
                  height: 45.h, // Set the height of the outer circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary, // Border color
                      width: 1, // Border width
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(AppIcons.logo),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: text ?? "",
                        fontSize: 16,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w300,
                        color: isRead ? Colors.white : AppColors.red,
                      ),
                      CustomText(
                        text: time ?? "",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        bottom: 10,
                        color: isRead ? Colors.grey : AppColors.white,
                      ),
                      Container(
                        height: 1,
                        color: AppColors.black_05,
                        width: MediaQuery.sizeOf(context).width,
                      )
                    ],
                  ),
                ),
                isRead
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(
                        Icons.circle,
                        color: Colors.redAccent,
                        size: 12,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
