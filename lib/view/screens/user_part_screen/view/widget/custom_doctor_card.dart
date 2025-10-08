import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDoctorCard extends StatelessWidget {
  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final String? title;
  final String? price;
  final String? rating;
  final Function()? onTap;
  const CustomDoctorCard(
      {super.key,
      this.imageUrl,
      this.firstName,
      this.lastName,
      this.title,
      this.price,
      this.rating,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Container(
         // padding: EdgeInsets.all(8.w),
          width: MediaQuery.sizeOf(context).width / 2.3,
          height: MediaQuery.sizeOf(context).height / 3.8,
          decoration: BoxDecoration(
            color: AppColors.black_05,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary, width: .8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: imageUrl ?? "",
                height: 150.h,
                width: MediaQuery.sizeOf(context).width / 2.2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
             Row(
               children: [
                 Flexible(
                   child: CustomText(
                     text: firstName ?? "",
                     fontSize: 18.h,
                     fontWeight: FontWeight.w600,
                     top: 8.h,
                     left: 8.w,
                   ),
                 ),
                 Flexible(
                   child: CustomText(
                     text: lastName ?? "",
                     fontSize: 18.h,
                     fontWeight: FontWeight.w600,
                     top: 8.h,
                     left: 8.w,
                   ),
                 ),
               ],
             ),
              Flexible(
                child: CustomText(
                  text: title ?? "",
                  fontSize: 14.h,
                  fontWeight: FontWeight.w300,
                  top: 4.h,
                  left: 8.h,
                  bottom: 6.h,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Price : $price",
                        fontSize: 14.h,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primary,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.primary,
                            size: 15,
                          ),
                          CustomText(
                            text: rating ?? "",
                            fontSize: 14.h,
                            fontWeight: FontWeight.w300,
                            color: AppColors.primary,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
