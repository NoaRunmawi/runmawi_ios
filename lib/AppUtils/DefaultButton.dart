import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  void Function()? onpress;
  String? text ;
  Color? color ;
  double? height;
  double? width;
  EdgeInsetsGeometry? margin;
  double? borderRadius;
  double?elevation;
  Color? bordercolor ;
  TextStyle? style ;
  Gradient? gradient;
  String? image;
  double?scale;
  DefaultButton({this.color,this.text,this.onpress,this.height,this.margin,this.borderRadius,this.width,this.elevation,this.bordercolor,this.style, this.gradient,this.image,this.scale});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Card(
        margin: margin,

        elevation: elevation??0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius??0.0)),
        child: Container(
          alignment: Alignment.center,
          width:width,
          height:height,
          //  padding: padding,
          decoration: BoxDecoration(
              color: color,
              gradient:gradient,
              borderRadius: BorderRadius.circular(borderRadius??0),
              border:
              bordercolor!=null?
              Border.all(color: bordercolor!,width: 1):null
          ),
          child:
          image!=null&&text!=null?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              image.toString().isEmpty?Container():  Image.asset(image??"",scale: scale,),
                SizedBox(
                  width: 5,
                ),
                Text(text!, style:style)
              ],):
          text!=null? Text(text!, style:style):Image.asset(image??"",scale: scale,),

        ),
      ),
    );
  }
}