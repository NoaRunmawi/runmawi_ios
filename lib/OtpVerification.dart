import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/AppUtils/DefaultButton.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/Home.dart';
import 'package:runmawi/Register.dart';
import 'package:runmawi/Repositery/Auth.dart';
import 'AppUtils/AppImages.dart';
import 'AppUtils/Colors.dart';

class OtpVerification extends StatefulWidget {
  String userId="" ;
  String countryCode = "";
   OtpVerification({Key? key,required this.userId,required this.countryCode}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
   List<TextEditingController> controllers= [] ;
   var tap = 0;
   var tap1 = 0;
   var tap2 = 0;
   var tap3 = 0;
   late StreamController<int> _timerController;
   late Stream<int> _timerStream;
   late int _seconds;

    FocusNode pin1FocusNode= FocusNode();
    FocusNode pin2FocusNode= FocusNode();
    FocusNode pin3FocusNode= FocusNode();
    FocusNode pin4FocusNode= FocusNode();
   TextEditingController first = new TextEditingController();
   TextEditingController second = new TextEditingController();
   TextEditingController third = new TextEditingController();
   TextEditingController fourth = new TextEditingController();
   String? otp;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timerController = StreamController<int>();
    _timerStream = _timerController.stream;
    _seconds = 30;
    startTimer();
  }
   void resetTimer() {
     _seconds = 30;
     _timerController.add(_seconds);
     startTimer();
   }

   void startTimer() {
     Timer.periodic(Duration(seconds: 1), (timer) {
       if (_seconds > 0) {
         _seconds--;
         if(!_timerController.isClosed)
           {
             _timerController.add(_seconds);
           }
       } else {
         timer.cancel();
       }
     });
   }

   @override
  void dispose() {
     _timerController.close();
    // resetTimer();
    // TODO: implement dispose
    super.dispose();
   pin1FocusNode.dispose();
   pin2FocusNode.dispose();
   pin3FocusNode.dispose();
   pin4FocusNode.dispose();

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
        child: Column(crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            _backButton(),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Enter OTP",
              style: Styles.job_medium_secondary(
                  fontsize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: TextFormField(
                      style: Styles.style_White(
                          fontsize: 14,fontWeight: FontWeight.w400
                      ),
                      controller: first,
                      focusNode: pin1FocusNode,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: AppColor.secondaryBlackColor,
                        filled: true,
                        counterText: "",
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color:  Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color:  Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                      ),
                      maxLength: 1,
                      onChanged: (value) {
                        nextField(value, pin2FocusNode);
                        // Handle the OTP input if needed
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: TextFormField(
                      style: Styles.style_White(
                          fontsize: 14,fontWeight: FontWeight.w400
                      ),

                      controller:second,
                      focusNode: pin2FocusNode,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: AppColor.secondaryBlackColor,
                        filled: true,
                        counterText: "",
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color:  Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color:  Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                      ),
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.toString().length == 0 &&
                            tap2 == 0) {
                          print("Print1");

                          tap2 = 1;
                        }
                        if (value.toString().length > 0) {
                          print("Print2");
                          FocusScope.of(context)
                              .requestFocus(pin3FocusNode);
                        }
                        if (value.toString().length == 0 &&
                            tap2 == 1) {
                          print("Print3");
                          FocusScope.of(context)
                              .requestFocus(pin1FocusNode);
                        }
                        // Handle the OTP input if needed
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: TextFormField(
                      style: Styles.style_White(
                          fontsize: 14,fontWeight: FontWeight.w400
                      ),

                      controller: third,
                      focusNode: pin3FocusNode,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: AppColor.secondaryBlackColor,
                        filled: true,
                        counterText: "",
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color:  Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color:  Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                      ),
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.toString().length == 0 &&
                            tap3 == 0) {
                          tap3 = 1;
                        }
                        if (value.toString().length > 0) {
                          FocusScope.of(context)
                              .requestFocus(pin4FocusNode);
                        }
                        if (value.toString().length == 0 &&
                            tap3 == 1) {
                          FocusScope.of(context)
                              .requestFocus(pin2FocusNode);
                        }
                        // Handle the OTP input if needed
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: TextFormField(
                      style: Styles.style_White(
                          fontsize: 14,fontWeight: FontWeight.w400
                      ),

                      controller: fourth,
                      focusNode: pin4FocusNode,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: AppColor.secondaryBlackColor,
                        filled: true,
                        counterText: "",
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color:  Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color:  Colors.white.withOpacity(0.2),
                                width: 1
                            )
                        ),
                      ),
                      maxLength: 1,
                      onChanged: (value) {
                        if (value.toString().length == 0 &&
                            tap3 == 0) {
                          tap3 = 1;
                        }
                        if (value.toString().length > 0) {
                          FocusScope.of(context).unfocus();
                        }
                        if (value.toString().length == 0 &&
                            tap3 == 1) {
                          FocusScope.of(context)
                              .requestFocus(pin3FocusNode);
                        }
                        // Handle the OTP input if needed
                      },
                    ),
                  ),
                ),
              ],
            ),
            _buildrow(),
            DefaultButton(
              text: "Submit",
              onpress: ()=> onPress(context),
              gradient: MethodUtils.gradients(),
              margin: const EdgeInsets.only(top: 30),
              height: 60,
              borderRadius: 16,
              color: AppColor.secondaryBlackColor,
              bordercolor: AppColor.secondaryBlackColor,
              style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 16),
            ),
          //  showGoSignup(),
          ],
        ),
      ),
    );
  }
  void onPress(BuildContext context){
 String   otp = first.text.toString().trim() +
        second.text.toString().trim() +
        third.text.toString().trim() +
        fourth.text.toString().trim();
    if(first.text.toString().trim().isNotEmpty&&second.text.toString().trim().isNotEmpty&&third.text.toString().trim().isNotEmpty&&fourth.text.toString().trim().isNotEmpty) {
      Map<String, String> _verifyParams={
      "userid":widget.userId.toString(),
      "password":otp.toString(),
      "type":"verifyOtp",
    };

      MethodUtils.showLoader(context);
      AuthRepository().verifyOtpApi(_verifyParams).then((value) {
        if(value.value['status'])
          {
            AppPrefrence.putString(AppConstants.SHARED_PREFERENCE_USER_Id,value.value['data']['userid'].toString() );
            AppPrefrence.putString(AppConstants.SHARED_PREFERENCE_USER_TOKEN,value.value['data']['access_token'].toString() );
            AppPrefrence.putString(AppConstants.SHARED_PREFERENCE_USER_name,value.value['data']['username'].toString() );
            AppPrefrence.putString(AppConstants.SHARED_PREFERENCE_USER_Email,value.value['data']['email'].toString() );
            AppPrefrence.putString(AppConstants.SHARED_PREFERENCE_USERMOBILE,widget.userId.toString() );
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route) => false);
            MethodUtils.showToast(value.value['data']['username'].toString()+" kan lo lawm a che..");
          }
        else{
          MethodUtils.hideLoader(context);
          MethodUtils.showToast(value.value['message']);
        }
      }).catchError((e){
        MethodUtils.hideLoader(context);
        MethodUtils.showToast(e.toString());
      });
    }
    else
      {
        MethodUtils.showToast("Please Enter Otp");
      }
  }
  Widget showGoSignup() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
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
  Widget _backButton(){
    return Row(
      children: [
        InkWell(
          onTap: Navigator.of(context).pop,
          child: Image.asset("assets/Images/Ic_back.png",scale: 1.5,)
        ),
        const SizedBox(width: 15,),
        Text(
          "OTP Verification",
          style: Styles.style_White(fontWeight: FontWeight.w600, fontsize: 26),
        ),
      ],
    );
  }
  Widget _buildrow(){
    return
      StreamBuilder<int>(
          stream: _timerStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data! > 0){
                   return Padding(
                       padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("Did not receive OTP ?",style: Styles.job_medium_secondary(fontWeight: FontWeight.w400,fontsize: 14),),
            const SizedBox(width: 5,),
            Text("Resend OTP in ${snapshot.data} seconds",style: Styles.style_White(),)
            ],
            ));
            }
            else {
          return    Row(

                children: [
                  Text("Did not receive OTP ?",style: Styles.job_medium_secondary(fontWeight: FontWeight.w400,fontsize: 14),),
                 // const SizedBox(width: 5,),
                  TextButton(
                      onPressed: ()
                      {
                        Map<String, dynamic> data ={
                          "type":"resendOtp",
                          "userid":widget.userId.toString(),
                          "country_code":widget.countryCode.toString(),
                          "sendtype":"1",
                          "enabled":"true"
                        };
                        AuthRepository().verifyOtpApi(data).then((value) {
                          if(value.value['status'])
                            {
                              resetTimer();
                            }
                          else{
                            MethodUtils.showToast("Error Occured");
                          }
                        }).catchError((e){
                          MethodUtils.showToast(e.toString());
                        });
                      },
                      child: Text("Send Again",style: Styles.style_White(),))
                ],
              );
            }
          });


  }

   void nextField(String value, FocusNode focusNode) {
     if (value.length == 1) {
       focusNode.requestFocus();
     }
   }

   void previousField(String value, FocusNode focusNode) {
     if (value.length == 0) {
       focusNode.requestFocus();
     }
   }
}
