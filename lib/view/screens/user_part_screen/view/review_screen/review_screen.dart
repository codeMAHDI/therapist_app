import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_strings/app_strings.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/Model/review_model.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/controller/review_controller.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/widget/custom_review_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatelessWidget {
  final String therapistId;

  ReviewScreen({super.key, required this.therapistId});

  final ReviewController controller = Get.put(ReviewController());
  @override
  Widget build(BuildContext context) {
    // Fetch feedback summary when screen opens
    controller.fetchFeedbackSummary(therapistId);

    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: AppStrings.review,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Rating & reviews",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  left: 20.w,
                ),
              ),
              SizedBox(height: 20),
              
              ///============= Average Rating ==================
              Obx(() {
                double rating = controller.averageRating.value ;
                int count = controller.feedbackCount.value;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: rating.toStringAsFixed(1),
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: index < rating.round()
                                ? AppColors.primary
                                : Colors.grey,
                          );
                        }),
                      ),
                    ),
                    CustomText(
                      top: 8.h,
                      text: "Based on $count review${count != 1 ? 's' : ''}",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                );
              }),
              SizedBox(height: 20.h),

              ///============= RATING ROW ==================
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRatingRow("Excellent", Colors.green, 0.9),
                  SizedBox(height: 8),
                  _buildRatingRow("Good", Colors.lightGreen, 0.75),
                  SizedBox(height: 8),
                  _buildRatingRow("Average", Colors.orange, 0.6),
                  SizedBox(height: 8),
                  _buildRatingRow("Below Average", Colors.deepOrange, 0.4),
                  SizedBox(height: 8),
                  _buildRatingRow("Poor", Colors.red, 0.25),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                height: 1,
                width: MediaQuery.sizeOf(context).width,
                color: AppColors.primary,
              ),
              SizedBox(height: 20.h),

              ///============= RATING Profile Comments ==================
              Column(
                children:
                    List.generate(3, (index) => CustomReviewView()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildRatingRow(String label, Color color, double progress) {
  return Row(
    children: [
      SizedBox(
        width: 100,
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      Expanded(
        child: Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 8),
      Text(
        "${(progress * 100).toInt()}%",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ],
  );
}
