import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/textstyle.dart';

class StarRating extends StatefulWidget {
  var rating;
  StarRating(this.rating);
  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _rating = 3;

  @override
  Widget build(BuildContext context) {
    print("jjj"+ widget.rating.toString());
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5,
                  (index) {
            return  Icon(
              index < num.parse(widget.rating.toString()) ? Icons.star : Icons.star_border,
              color:index < num.parse(widget.rating.toString()) ? Colors.yellow:AppColor.textSecondaryColor,
              size: 20,

            );
          }),
        ),
        SizedBox(
          width: 5,
        ),
        Text(widget.rating.toString(),style: Styles.style_White(fontsize: 12,fontWeight: FontWeight.w700),)
      ],
    );
  }
}