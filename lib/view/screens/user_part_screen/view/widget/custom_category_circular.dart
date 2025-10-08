import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCategoryCircular extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final String text;

  const CustomCategoryCircular({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CustomNetworkImage(imageUrl: icon, height: 65.w, width: 65.w, boxShape: BoxShape.circle,),
          SizedBox(height: 8),
          CustomText(text: text, fontSize: 16.sp,fontWeight: FontWeight.w400,color: AppColors.white,)
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final String image;

  Category({required this.name, required this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
