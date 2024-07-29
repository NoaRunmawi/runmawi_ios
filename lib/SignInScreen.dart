import 'package:country_list_pick/support/code_country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/DefaultButton.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/EmailTextField.dart';
import 'package:runmawi/OtpVerification.dart';
import 'package:runmawi/Register.dart';
import 'package:runmawi/Repositery/Auth.dart';
import 'package:runmawi/validators.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String countryCode = "+91";
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.clear();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          height: height,
          padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
          width: width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.commonBackgroundPath),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(child: showForm(context))),
    );
  }
  void onPress(BuildContext context){
    if(_formKey.currentState!.validate()){

   Map<String , String > _loginParams = {
     "type":"login",
     "userid":_emailController.text.toString(),
     "country_code":countryCode.toString().replaceAll("+", ""),
     "sendtype":isEmail(_emailController.text.toString())?"2":"1"
   };
   AuthRepository().registerApi(_loginParams, context);
    }
  }
  bool isEmail(String input) {
    // Regular expression for a basic email validation
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(input);
  }

  bool isMobileNumber(String input) {
    // Regular expression for a basic mobile number validation
    final mobileNumberRegExp = RegExp(r'^\d{10}$');
    return mobileNumberRegExp.hasMatch(input);
  }
  Widget showForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login",
            style: Styles.style_White(fontWeight: FontWeight.w600, fontsize: 28),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Mobile Number ",
            style: Styles.job_medium_secondary(
                fontsize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 8,
          ),
          EmailTextField(
              controller: _emailController,
              validator: (val) => Validators.isCorrectMobileNumber(_emailController.text,),
              hinttext: "Mobile Number",onChanged: (CountryCode? code){
            countryCode = code.toString();
                setState(() {

                });

          },),
          DefaultButton(
            text: "Get OTP",
            onpress: ()=>onPress(context),
            gradient: MethodUtils.gradients(),
            margin: const EdgeInsets.only(top: 30),
            height: 60,
            borderRadius: 16,
            color: AppColor.secondaryBlackColor,
            bordercolor: AppColor.secondaryBlackColor,
            style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 16),
          ),
          const SizedBox(
            height: 40,
          ),
         // loginWith(),
        //  showSocialMediaIcon(),
          showGoSignup(),
        ],
      ),
    );
  }

  Widget loginWith() {
    return Center(
      child: Text("Or Log in with",
          textAlign: TextAlign.center,
          style: Styles.job_medium_secondary(
              fontsize: 14, fontWeight: FontWeight.w400)),
    );
  }
  Widget showSocialMediaIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultButton(
            color: AppColor.secondaryBlackColor,
            margin: const EdgeInsets.only(right: 16),
            height: 60,
            width: 60,
            bordercolor: Colors.white.withOpacity(0.2),
            image: AppImages.socialGoogleIcon,
            scale: 2,
            borderRadius: 30,
          ),
          DefaultButton(
            color: AppColor.secondaryBlackColor,
            margin: const EdgeInsets.only(right: 16),
            height: 60,
            width: 60,
            bordercolor: Colors.white.withOpacity(0.2),
            image: AppImages.socialAppleIcon,
            scale: 2,
            borderRadius: 30,
          ),
          DefaultButton(
            color: AppColor.secondaryBlackColor,
            height: 60,
            width: 60,
            bordercolor: Colors.white.withOpacity(0.2),
            image: AppImages.socialFacebookIcon,
            scale: 2,
            borderRadius: 30,
          )
        ],
      ),
    );
  }
  Widget showGoSignup() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don’t have an Account ?",
            style: Styles.style_White(fontWeight: FontWeight.w400,fontsize: 14),
          ),
          const SizedBox(width: 4),
          CupertinoButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
              //Navigator.of(context).pushNamed(Routes.signUp);
            },
              padding: const EdgeInsets.all(0),
            child:MethodUtils.shaderMask("Sign Up",style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w400))
          ),
        ],
      ),
    );
  }
}
