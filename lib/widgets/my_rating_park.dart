import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:parkline/utils/colors.dart';

class MyRatingPark extends StatefulWidget {
  final String rating;

  const MyRatingPark({Key key, this.rating}) : super(key: key);

  @override
  _MyRatingParkState createState() => _MyRatingParkState();
}

class _MyRatingParkState extends State<MyRatingPark> {
  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
        allowHalfRating: true,
        onRated: (v) {},
        starCount: 5,
        rating: double.parse(widget.rating),
        size: 20.0,
        isReadOnly: true,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_half,
        color: CustomColor.primaryColor,
        borderColor: CustomColor.secondaryColor,
        spacing: 0.0);
  }
}
