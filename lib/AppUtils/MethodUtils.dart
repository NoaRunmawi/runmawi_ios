import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:runmawi/AppUtils/Colors.dart';

class MethodUtils{
  static Gradient gradients() => LinearGradient(colors: [
    AppColor.buttonColor.withOpacity(0.9),
    AppColor.gradientButtonColor.withOpacity(0.9)
  ],
  begin: const Alignment(0.7, -4.5),
  );

  static ShaderMask shaderMask(String text,{TextStyle? style}) => ShaderMask(shaderCallback: (Rect bounds) {
    return gradients().createShader(bounds);
  }, child: Text(text,style: style,),
  );

  static void showLoader(BuildContext context){
    showDialog(barrierDismissible:false,context: context, barrierColor:Colors.transparent,builder: (BuildContext context){
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new Center(
          child: new Container(
            padding: const EdgeInsets.all(8.0),
            child: !Platform.isIOS
                ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircularProgressIndicator(color:AppColor.buttonColor,),
            )
                : CupertinoActivityIndicator(
              radius: 20,
            ),
          ),
        ),
      );
    }
    );
  }

  static Future<void> hideLoader(BuildContext context)async {
      Navigator.pop(context);
      // Execute a task after the current frame is drawn
  }

  static Widget adaptiveLoader() {
    return Platform.isIOS
        ? CupertinoActivityIndicator()
        : CircularProgressIndicator();
  }

  static showToast(String message){
  return  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP, // Change this to ToastGravity.TOP or ToastGravity.CENTER if needed
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );

  }
}