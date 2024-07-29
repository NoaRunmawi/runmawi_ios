import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/Data/ApiUrl.dart';
import 'package:runmawi/Data/network/BaseApiService.dart';
import 'package:runmawi/Data/network/NetworkApiService.dart';
import 'package:runmawi/OtpVerification.dart';

import '../Data/ApiResponse.dart';

class AuthRepository {

  final BaseApiServices _apiServices = NetworkApiService();
  Future registerApi(dynamic data, BuildContext context )async{
    try{
      MethodUtils.showLoader(context);
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.baseUrl, data);
      if(response['status']==true)
      {
        MethodUtils.showToast("OTP kan lo thawn che, i message check rawh...");
        Navigator.pop(context);
       // MethodUtils.hideLoader(context);
  Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification(
    countryCode: data['country_code'],
    userId: data['type']=="login"?data['userid']:
    data['phone'],
  )));
      }
      else{
        MethodUtils.hideLoader(context);
        MethodUtils.showToast(response['message']);
      }
    }catch(e){
      MethodUtils.hideLoader(context);
      MethodUtils.showToast(e.toString());
      throw e ;
    }
  }

  // Otp Verification
  Future<ApiResponse> verifyOtpApi(dynamic data,)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.baseUrl, data);
       return ApiResponse(response);
    }catch(e){
      rethrow ;
    }
  }
}