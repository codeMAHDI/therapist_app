import 'package:counta_flutter_app/service/api_client.dart';
import 'package:counta_flutter_app/service/api_url.dart';
import 'package:counta_flutter_app/view/screens/user_part_screen/view/review_screen/Model/review_model.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  // ====== Observables ======
  var isSubmitting = false.obs;

  // Feedback summary
  var feedbackCount = 0.obs;
  var averageRating = 0.0.obs;
  
  // ====== Submit Review ======
  Future<void> submitReview({
    required String patientId,
    required String therapistId,
    required double rating,
    required String comment,
  }) async {
    try {
      isSubmitting.value = true;

      final response = await ApiClient.submitFeedback(
        patientId: patientId,
        therapistId: therapistId,
        rating: rating,
        comment: comment,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success!", "Thanks For The Review");
        // Submit করার পর summary refresh করতে পারো
        fetchFeedbackSummary(therapistId);
      } else {
        Get.snackbar("Error", response.statusText ?? "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> submitReviewWithModel(ReviewModel review) async {
    await submitReview(
      patientId: review.patientId,
      therapistId: review.therapistId,
      rating: review.rating,
      comment: review.comment,
    );
  }

  // ====== Fetch Feedback Summary ======
  Future<void> fetchFeedbackSummary(String therapistId) async {
    try {
      final response = await ApiClient.getData(
        ApiUrl.feedbackReview(outletId: therapistId),
      );

      if (response.statusCode == 200 && response.body != null) {
        final summary = ReviewModel.fromSummaryJson(response.body);
        feedbackCount.value = summary.feedbackCount;
        averageRating.value = summary.averageRating;
      } else {
          Get.snackbar("Error", response.statusText ?? "Failed to load summary");
        }
    } catch (e) {
        Get.snackbar("Error", e.toString());
      }
  }

}
