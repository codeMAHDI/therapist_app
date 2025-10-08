import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddWallet extends StatelessWidget {
  final String? image;
  final String? name;
  final String? title;
  final Function()? onTap;
  const CustomAddWallet({super.key, this.image, this.name, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: AppColors.navbarClr,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: image ?? "",
                  height: 65,
                  width: 65,
                  boxShape: BoxShape.circle,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  children: [
                    CustomText(
                      text: name ?? "",
                      fontSize: 20.w,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: title ?? "",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
                onPressed: onTap,
                icon: Icon(
                  Icons.delete,
                  size: 22,
                  color: AppColors.white,
                ))
          ],
        ),
      ),
    );
  }
}
