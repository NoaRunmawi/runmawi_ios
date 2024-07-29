import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/DefaultButton.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/EmailTextField.dart';
import 'package:runmawi/Repositery/Auth.dart';
import 'package:runmawi/Repositery/Homepage.dart';
import 'package:runmawi/SearchMovieClass.dart';
import 'package:runmawi/validators.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }
  Future<void> callApi()async{
  AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id).then((value) {
    HomeRepository().homeApi({"type":"userProfile","userid":value.toString()}).then((value2) {
      if(value2.value['status']==true){

        _fullnameController.text = value2.value['data']['username'];
        _emailController.text = value2.value['data']['email'];
        _mobileController.text = value2.value['data']['phone'];
      }

    }).catchError((e){
      print("eroorr"+ e.toString());
    });
  });

  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(top: 10,left: 16,right: 16),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.commonBackgroundPath),
                  fit: BoxFit.cover)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBarRow(),
              _buildForm(context)
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildAppBarRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset(
            AppImages.barBackImage,
            scale: 2,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "My Profile",
          style: Styles.style_White(fontWeight: FontWeight.w600, fontsize: 16),
        )
      ],
    );
  }
  Widget _buildForm(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Full Name *",
          style: Styles.job_medium_secondary(
              fontsize: 14, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 5,),
        EmailTextField(
            controller: _fullnameController,
            validator: (val) => Validators.isValidName(_fullnameController.text,),
            hinttext: "Full Name"),
        SizedBox(
          height: 10,
        ),
        Text(
          "Phone",
          style: Styles.job_medium_secondary(
              fontsize: 14, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 5,
        ),
        EmailTextField(
            controller: _mobileController,
            readOnly: true,
            validator: (val) => Validators.isCorrectMobileNumber(_mobileController.text,),
            hinttext: "Mobile Number"),
        SizedBox(
          height: 10,
        ),
        Text(
          "Email",
          style: Styles.job_medium_secondary(
              fontsize: 14, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 5,
        ),
        EmailTextField(
            controller: _emailController,
            readOnly:  true,
            validator: (val) => Validators.validateEmail(_emailController.text,
                "Please Enter Email", "Please Enter Vaild Email"),
            hinttext: "Your Email"),
        DefaultButton(
          text: "Save",
          onpress: ()=>onPress(context),
          gradient: MethodUtils.gradients(),
          margin: const EdgeInsets.only(top: 20),
          height: 60,
          borderRadius: 16,
          color: AppColor.secondaryBlackColor,
          bordercolor: AppColor.secondaryBlackColor,
          style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 16),
        ),
      ],
    );
  }
  void onPress(BuildContext context){
  FocusScope.of(context).unfocus();
MethodUtils.showLoader(context);
  Map<String , String> data ={
    "type":"updateProfile",
    "username":_fullnameController.text.toString(),
  };
  AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id).then((value) {
    data.addAll({"userid":value.toString()});
    AuthRepository().verifyOtpApi(data).then((value2) {
      if(value2.value['status']==true)
        {
          Navigator.pop(context);
          MethodUtils.showToast(value2.value['message'].toString());
        }
      else{
        Navigator.pop(context);
      }
    }).catchError((e){
    Navigator.pop(context);
    });
  });
  }
}
