import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/view/components/custom_button/custom_button.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomInvoiceList extends StatelessWidget {
  final String? invoiceId;
  final String? firstName;
  final String? lastName;
  final String? amount;
  final String? date;
  final Function()? onTap;
const CustomInvoiceList({super.key, this.invoiceId, this.amount, this.date, this.onTap, this.firstName, this.lastName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: AppColors.black_05,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: invoiceId ?? "",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    bottom: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_month,color: AppColors.primary,size: 15),
                      CustomText(
                        left: 6.h,
                        text: date ?? "",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        //bottom: 8.h,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  CustomText(
                    text: firstName ?? "",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    right: 8.w,
                  ),
                  CustomText(
                    text: lastName ?? "",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Amount Paid:",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    bottom: 8.h,
                  ),
                  CustomText(
                    text: amount ?? "",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    bottom: 8.h,
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              CustomButton(
                onTap: () {},
                title: "Completeted",
                height: 30.h,
                width: 110.w,
                fontSize: 14.sp,
                fillColor: AppColors.green,
                textColor: AppColors.white,
                borderRadius: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
