import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../popular_doctor_screen/model/popular_doctor_model.dart';
import '../../widget/custom_invoice_row_list.dart';

class UserPaymentView extends StatelessWidget {
  UserPaymentView({super.key});
  final PopularDoctorsModel popularDoctorsModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Payment Details",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*    DottedBorder(
                  color: AppColors.primary,
                  padding: EdgeInsets.all(5),
                  strokeWidth: 2,
                  dashPattern: [5, 3],
                  radius: Radius.circular(10),
                  borderType: BorderType.RRect,
                  child: SizedBox(
                    height: 35.h,
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.primary,
                          size: 30,
                        ),
                        CustomText(
                          text: "Add new Card",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_05,
                        )
                      ],
                    ),
                  ),
                ),*/
                CustomText(
                  text: "Payment Details",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  bottom: 20.h,
                ),
                CustomInvoiceRowList(
                  menuName: "Appointment Fee",
                  name: "\$${popularDoctorsModel.therapist?.profile?.chargePerHour?.amount?.toDouble().toString() ?? "0.0"}",
                  fontSize: 18.w,
                ),
               /* CustomInvoiceRowList(
                  menuName: "Discount",
                  name: "\$00.00",
                  fontSize: 18.w,
                ),*/
                CustomInvoiceRowList(
                  menuName: "Additional Fee",
                  name: "\$00.0",
                  fontSize: 18.w,
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.white,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomInvoiceRowList(
                  menuName: "Total Fee",
                  name: "\$${popularDoctorsModel.therapist?.profile?.chargePerHour?.amount?.toDouble().toString() ?? "0.0"}",
                  fontSize: 24.w,
                  rightFontSize: 22.w,
                ),
              ],
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.addCardField);
              },
              title: "Continue",
            )
          ],
        ),
      ),
    );
  }
}
