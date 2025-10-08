import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_icons/app_icons.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomPaymentList extends StatelessWidget {
  final String? firstName;
  final String? lastName;
  final String? time;
  final String? price;
  const CustomPaymentList({super.key, this.time, this.price, this.firstName, this.lastName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 15, right: 15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50, // Set the width of the outer circle
                height: 50, // Set the height of the outer circle
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
                   Row(
                     children: [
                       CustomText(
                         text: firstName ?? "",
                         fontSize: 16,
                         maxLines: 2,
                         textAlign: TextAlign.start,
                         fontWeight: FontWeight.w300,
                         right: 10.w,
                       ),
                       CustomText(
                         text: lastName ?? "",
                         fontSize: 16,
                         maxLines: 2,
                         textAlign: TextAlign.start,
                         fontWeight: FontWeight.w300,
                       ),
                     ],
                   ),
                    SizedBox(height: 10.w,),
                    CustomText(
                      text: time ?? "",
                      fontSize: 13,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w300,
                      bottom: 15.h,
                    ),
                    Container(
                      height: 1,
                      color: AppColors.black_05,
                      width: MediaQuery.sizeOf(context).width,
                    )
                  ],
                ),
              ),
             // CustomText(text: price ?? "", fontSize: 14, fontWeight: FontWeight.w400,bottom: 10,color: AppColors.red,),
              CustomText(
                text: price ?? "",
                fontSize: 16.w,
                fontWeight: FontWeight.w400,
                bottom: 10,
                color: (price != null && double.tryParse(price!) != null && double.tryParse(price!)! > 0)
                    ? Colors.green // Positive price: Green color
                    : Colors.red,  // Negative price: Red color
              )
            ],
          )
        ],
      ),
    );
  }
}
