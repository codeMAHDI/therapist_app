class ReviewModel {
  final String patientId;
  final String therapistId;
  final double rating;
  final String comment;

  // Summary fields
  final int feedbackCount;
  final double averageRating;

  ReviewModel({
    this.patientId = '',
    this.therapistId = '',
    this.rating = 0.0,
    this.comment = '',
    this.feedbackCount = 0,
    this.averageRating = 0.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'therapistId': therapistId,
      'rating': rating,
      'comment': comment,
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      patientId: json['patientId'] ?? '',
      therapistId: json['therapistId'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? '',
    );
  }

  /// Summary parse
  factory ReviewModel.fromSummaryJson(Map<String, dynamic> json) {
    return ReviewModel(
      feedbackCount: json['data']['feedbackCount'] ?? 0,
      averageRating: (json['data']['ratings'] ?? 0).toDouble(),
    );
  }
}
