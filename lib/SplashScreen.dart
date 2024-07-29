import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/DefaultButton.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/Register.dart';
import 'package:runmawi/SignInScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.commonBackgroundPath),fit: BoxFit.cover)),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/1.6,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.splashImagePath),fit: BoxFit.cover),
              ),
            ),
            Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Image.asset(AppImages.appIconImage,scale: 2.5,),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,bottom: 30),
                      child: Text("Watch  unlimited movies, series & TV shows anytime, anywhere & anyway",
                      textAlign: TextAlign.center,
                      style: Styles.job_medium_secondary(fontsize: 12,fontWeight: FontWeight.w400),
                      ),
                    ),
                    DefaultButton(
                      text: "Log in",
                      gradient: MethodUtils.gradients(),
                      onpress: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                      },
                      height: 60,
                      borderRadius: 16,
                      color: AppColor.secondaryBlackColor,
                      bordercolor: AppColor.secondaryBlackColor,
                      style: Styles.style_White(fontWeight:FontWeight.w400,fontsize: 16),
                    ),
                    DefaultButton(
                      text: "Register to Runmawi",
                      margin: EdgeInsets.only(top: 10),
                      onpress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Register())),
                      height: 60,
                      borderRadius: 16,
                      color: AppColor.secondaryBlackColor,
                      bordercolor: AppColor.secondaryBlackColor,
                      style: Styles.job_medium_secondary(fontWeight:FontWeight.w400,fontsize: 16),
                    ),

                  ],
                ))
          ],
        ),
      ),
    );
  }
}
