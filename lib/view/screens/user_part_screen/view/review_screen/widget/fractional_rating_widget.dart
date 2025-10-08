import 'package:flutter/material.dart';
import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';

class FractionalStarRating extends StatelessWidget {
  final double rating; // current rating
  final double starSize;
  final ValueChanged<dynamic> onRatingChanged; // callback when user changes rating

  const FractionalStarRating({
    Key? key,
    required this.rating,
    required this.onRatingChanged,
    this.starSize = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) => _updateRating(context, details.globalPosition.dx),
      onTapDown: (details) => _updateRating(context, details.globalPosition.dx),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          double starFill = 0;
          if (rating >= index + 1) {
            starFill = 1;
          } else if (rating > index && rating < index + 1) {
            starFill = rating - index;
          }
          return Stack(
            children: [
              Icon(Icons.star_border, size: starSize, color: Colors.white30),
              ClipRect(
                clipper: _StarClipper(starFill),
                child: Icon(Icons.star, size: starSize, color: AppColors.primary),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _updateRating(BuildContext context, double globalDx) {
    RenderBox box = context.findRenderObject() as RenderBox;
    var localDx = globalDx - box.localToGlobal(Offset.zero).dx;
    var newRating = (localDx / (starSize * 5)) * 5;
    if (newRating < 0) newRating = 0;
    if (newRating > 5) newRating = 5;
    onRatingChanged(double.parse(newRating.toStringAsFixed(1)));
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double fillPercent; // 0.0 - 1.0
  _StarClipper(this.fillPercent);

  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, size.width * fillPercent, size.height);

  @override
  bool shouldReclip(covariant _StarClipper oldClipper) => oldClipper.fillPercent != fillPercent;
}
