import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomReviewView extends StatelessWidget {
  const CustomReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
           Row(
             children: [
               CustomNetworkImage(
                 imageUrl: AppConstants.profileImage,
                 height: 60,
                 width: 60,
                 boxShape: BoxShape.circle,
               ),
               SizedBox(width: 10.w,),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   CustomText(
                     text: "Sarwar Hossen",
                     fontSize: 18,
                     fontWeight: FontWeight.w600,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: List.generate(5, (index) {
                       return Row(
                         children: [
                           Icon(
                             Icons.star,
                             size: 18,
                             color: AppColors.primary,
                           ),
                         ],
                       );
                     }),
                   ),
                 ],
               ),
             ],
           ),
              CustomText(text: "1 day ago", fontSize: 12, fontWeight: FontWeight.w400,)
            ],
          ),
          CustomText(
            top: 10.h,
            text: "Explore our diverse menu featuring a variety of service items, including freshly brewed coffees, artisanal teas, delectable pastries.",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            maxLines: 10,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
