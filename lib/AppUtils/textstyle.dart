import 'package:flutter/material.dart';

import 'package:runmawi/AppUtils/Colors.dart';

class Styles{
  static TextStyle job_medium_secondary({FontWeight? fontWeight,double? fontsize})  =>
       TextStyle(
        color: AppColor.textSecondaryColor,
          fontSize: fontsize,
          fontWeight: fontWeight);
  static TextStyle style_White({FontWeight? fontWeight,double? fontsize})  =>
      TextStyle(
          color: Colors.white,
          fontSize: fontsize,
          fontWeight: fontWeight);
}
