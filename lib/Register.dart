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
import 'package:runmawi/Repositery/Auth.dart';
import 'package:runmawi/SignInScreen.dart';
import 'package:runmawi/validators.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   TextEditingController _fullNameController = TextEditingController();
   TextEditingController _mobileController = TextEditingController();
   String country_code = "+91";
   TextEditingController _emailController = TextEditingController();
   bool checkedValue=false;
   final _formKey = GlobalKey<FormState>();
   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:Container(
        height: height,
        padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.commonBackgroundPath),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: _showForm(context),
        ),
      ) ,
    );
  }

  Widget _showForm(BuildContext context)
  {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Register",
            style: Styles.style_White(fontWeight: FontWeight.w600, fontsize: 28),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Full Name *",
            style: Styles.job_medium_secondary(
                fontsize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5,),
          EmailTextField(
              controller: _fullNameController,
              validator: (val) => Validators.isValidName(_fullNameController.text,),
              hinttext: "Full Name"),
          SizedBox(
            height: 15,
          ),
          Text(
            "Mobile Number *",
            style: Styles.job_medium_secondary(
                fontsize: 14, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          EmailTextField(
              controller: _mobileController,


              validator: (val) => Validators.isCorrectMobileNumber(_mobileController.text,),
              hinttext: "Mobile Number",onChanged: (CountryCode? countrycode){
                country_code= countrycode.toString();
                setState(() {

                });
          },),
          SizedBox(
            height: 15,
          ),
          Text(
            "Email *",
            style: Styles.job_medium_secondary(
                fontsize: 14, fontWeight: FontWeight.w400),
          ),
          EmailTextField(
              controller: _emailController,
              validator: (val) => Validators.validateEmail(_emailController.text,
                  "Please Enter Email", "Please Enter Vaild Email"),
              hinttext: "Email"),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              new Container(
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16)
                ),
               // margin: EdgeInsets.only(bottom: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Checkbox(
                    value: checkedValue,
                    activeColor: AppColor.gradientButtonColor,
                    onChanged: (value) {
                      setState(() {
                        checkedValue = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(child: Row(
                children: [
                  Text("I accept to",style: Styles.job_medium_secondary(fontsize: 14,fontWeight: FontWeight.w400),),
                  SizedBox(width: 3,),
                  Text("Terms & Conditions",style: Styles.style_White(fontWeight: FontWeight.w600,fontsize: 14),)
                ],
              )),
            ],
          ),
          DefaultButton(
            text: "Register",
            onpress: ()=>onPress(context),
            gradient: MethodUtils.gradients(),
            margin: const EdgeInsets.only(top: 20),
            height: 60,
            borderRadius: 16,
            color: AppColor.secondaryBlackColor,
            bordercolor: AppColor.secondaryBlackColor,
            style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 16),
          ),
          SizedBox(
            height: 20,
          ),
        //  loginWith(),
         // showSocialMediaIcon(),
          showGoLogin()
        ],
      ),
    );
  }

  void onPress(BuildContext context)
  {
  if(_formKey.currentState!.validate())
    {
      if(checkedValue){
   Map<String ,String> _registerParams = {
     "username":_fullNameController.text.toString(),
     "type":"register",
     "phone":_mobileController.text.toString(),
     "password":"123123123",
     "country_code":country_code.replaceAll("+", ""),
     "sendtype":"1",
     "email":_emailController.text.toString(),
   };
   FocusScope.of(context).unfocus();
   AuthRepository().registerApi(_registerParams, context);
      }
      else {
MethodUtils.showToast("Please agree Terms And Conditions");
      }
    }
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
   Widget showGoLogin() {
     return Padding(
       padding: const EdgeInsets.only(top: 5),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(
             "Already a User ?",
             style: Styles.style_White(fontWeight: FontWeight.w400,fontsize: 14),
           ),
           const SizedBox(width: 4),
           CupertinoButton(
               onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                 //Navigator.of(context).pushNamed(Routes.signUp);
               },
               padding: const EdgeInsets.all(0),
               child:MethodUtils.shaderMask("Log in",style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w400))
           ),
         ],
       ),
     );
   }
}
