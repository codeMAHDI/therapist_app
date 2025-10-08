import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomInvoiceRowList extends StatelessWidget {
  final String? menuName;
  final String? name;
  final double fontSize;
  final double rightFontSize;
  const CustomInvoiceRowList({super.key, this.menuName, this.name,  this.fontSize = 18, this.rightFontSize=18,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: menuName?? "",fontSize: fontSize.w,fontWeight: FontWeight.w600,),
          CustomText(text: name?? "",fontSize: rightFontSize.w,fontWeight: FontWeight.w400,),
        ],
      ),
    );
  }
}
