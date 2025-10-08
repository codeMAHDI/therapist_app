import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:counta_flutter_app/utils/app_const/app_const.dart';
import 'package:counta_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:counta_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/controller/user_my_booking_controller.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/Model/review_model.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/controller/review_controller.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/widget/fractional_rating_widget.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/widget/review_input_widget.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/widget/submit_button_widget.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/therapist_view_profile_screen/therapist_view_profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SubmitReviewScreen extends StatefulWidget {
  final String patientId;
  final String therapistId;

  const SubmitReviewScreen({
    super.key,
    required this.patientId,
    required this.therapistId,
  });

  @override
  State<SubmitReviewScreen> createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  double selectedRating = 0;
  final TextEditingController _commentController = TextEditingController();
  ReviewController reviewController = Get.put(ReviewController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Review"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ==== Star Icon ====
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: CircleAvatar(
                  radius: 70.r,
                  backgroundColor : AppColors.primary,
                  child: Icon(Icons.star_rounded,color:Colors.white,size: 120.r,)
                  ),
              ),
            ),

            /// ==== Rate Doctor ====
            Center(child: CustomText(text: "Rate Doctor",fontSize: 20.sp,fontWeight: FontWeight.w600,color: Colors.white)),
            SizedBox(height: 10.h),
            
            /// ==== User Rating Stars (Fractional) ====
            Center(
              child: FractionalStarRating(
                rating: selectedRating,
                onRatingChanged: (value) => setState(() => selectedRating = value),
              ),
            ),
            SizedBox(height: 40.h),
            Center(child: Text("Please Share Your Opinion About The Doctor",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
            SizedBox(height: 10.h ),
            /// ==== Review Input ====
            ReviewInput(controller: _commentController),
            SizedBox(height: 30.h),

            /// ==== Submit Button ====
            SubmitButton(
              onPressed: () {
                final review = ReviewModel(
                  patientId: widget.patientId,
                  therapistId: widget.therapistId,
                  rating: selectedRating??1.0,
                  comment: _commentController.text.trim(),
                );
                reviewController.submitReviewWithModel(review);
              Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ==== Rating Bars Widget ====
  Widget _buildRatingRow(String label, Color color, double progress) {
    return Row(
      children: [
        SizedBox(
          width: 28,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
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
      ],
    );
  }
}
