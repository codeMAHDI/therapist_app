import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../controller/subscription_controller.dart';

class SubscriptionOption extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String type;
  final int index;

  const SubscriptionOption({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.index, required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final subscriptionController = Get.find<SubscriptionController>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          if (subscriptionController.selectedIndex.value == index) {
            subscriptionController.selectedIndex.value = -1; // আনসিলেক্ট
          } else {
            subscriptionController.selectedIndex.value = index; // সিলেক্ট
          }
        },
        child: Obx(() {
          return Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: AppColors.navbarClr,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: subscriptionController.selectedIndex.value == index
                    ? AppColors.primary
                    : AppColors.navbarClr,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: AppColors.primary,
                  value: subscriptionController.selectedIndex.value == index,
                  onChanged: (value) {
                    if (value == true) {
                      subscriptionController.selectedIndex.value = index;
                    } else {
                      subscriptionController.selectedIndex.value = -1; // আনসিলেক্ট
                    }
                  },
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600,
                      bottom: 8.w,
                    ),
                    CustomText(
                      text: description,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w400,
                      bottom: 8.w,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: price,
                          fontSize: 18.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          right: 6.w,
                        ),
                        CustomText(
                          text: "/$type",
                          fontSize: 14.w,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}