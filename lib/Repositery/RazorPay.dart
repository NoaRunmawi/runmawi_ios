import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/Data/ApiUrl.dart';
import 'package:runmawi/Data/network/BaseApiService.dart';
import 'package:runmawi/Repositery/Homepage.dart';

import '../Data/network/NetworkApiService.dart';

class RazorPayPaymentIntegration{
  var _razorpay = Razorpay();
  num? amount;
  String? contactNumber;
  String? userName;
  String? userId;
  VoidCallback callback;
  String? categoryId;
  String? videoId;
  String? quality;
  String orderId = "00";
  BuildContext? context ;

  RazorPayPaymentIntegration({this.amount,this.contactNumber,this.userName,this.userId , this.context,this.videoId,this.categoryId,required this.callback, this.quality});

  Future<void> initiliazation()async{

  //  double localAmount = double.parse(amount ?? "") *  1 ;
    _razorpay = Razorpay();
    orderIdApi(userId, {
      "type":"generate_order",
      "video_id":videoId,
      "quality":quality,
      "user_id":userId,
      "category_id":categoryId,
    });
    //_startPayment(localAmount);
    // ApiServices().razorPayApi(videoId , userId!,categoryId).then((value) {
    //   print("value"+ value.toString());
    //   // if(value['body']['id'].toString().isNotEmpty){
    //   //   var options = {
    //   //     // Razorpay API Key
    //   //     'key': "rzp_live_O0kWJvRzk5Bfj8",
    //   //     // in the smallest
    //   //     // currency sub-unit.
    //   //     'amount':value['body']['amount'] ,
    //   //     'name': 'RUNMAWI',
    //   //     // Generate order_id
    //   //     // using Orders API
    //   //     'order_id': value['body']['id'],
    //   //     // Order Description to be
    //   //     // shown in razor pay page
    //   //     'description':
    //   //     'Description for order',
    //   //     // in seconds
    //   //     'timeout': 60,
    //   //     'prefill': {
    //   //       'contact': '9123456789',
    //   //       'email': 'flutterwings304@gmail.com'
    //   //     } // contact number and email id of user
    //   //   };
    //   //   _razorpay.open(options);
    //   // }
    // });
   // orderIdApi(localAmount,userId);

    try{
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    }catch(e){
      print(["exception1111",e]);
    }

  }


  orderIdApi( String? userId,Map data) async{
    final BaseApiServices _apiServices = NetworkApiService();
  dynamic response = await  _apiServices.getPostApiResponse(AppUrl.baseUrl, data);
  print("response"+ response.toString());
    orderId = response['data']['order_id'];
    amount = num.parse(response['data']['ppv_cost']);
    //print("orderis"+orderId.toString() );
    var options = {
      // Razorpay API Key
      'key': "rzp_live_CbufzFZYT0BVYe",
      // in the smallest
      // currency sub-unit.
      'amount':amount,
      'name': 'RUNMAWI',
      // Generate order_id
      // using Orders API
      'order_id': orderId,
      // Order Description to be
      // shown in razor pay page
      'description': orderId,
      // in seconds
      'prefill': {
        'contact': contactNumber,
        //    'email': 'flutterwings304@gmail.com'
      } // contact number and email id of user
    };
    _razorpay.open(options);
 // if(response['data']['order_id'].toString().isNotEmpty){
 //
 // }
  }


  void _startPayment(double? localAmount) {

    Map<String, dynamic> options = {
      'key': 'rzp_live_O0kWJvRzk5Bfj8',
      'amount': "1000", // Amount in paise or smallest currency unit
      'name': 'RUNMAWI',
      "currency": "INR",
      'order_id':orderId,
      'prefill': {'contact': '$contactNumber','email': 'flutterwings304@gmail.com'},
    };
    try {

      print(["request======>",options]);
      _razorpay.open(options);
    } catch (e) {
      print('Razorpay Error: ${e.toString()}');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(["_handlePaymentSuccess==========================",response]);

    HomeRepository().homeApi({
      "type":"payment_success",
      "video_id":videoId,
      "order_id":orderId,
      "amount":amount.toString(),
      "user_id":userId,
      "quality":quality,
      // "transaction details":response,
      "status":"success",
    }).then((value) {

      callback();

      MethodUtils.showToast("Success !! Khawngaihin a in refresh hun lo nghak rawh...");

    }).catchError((e){
      callback();
      MethodUtils.showToast(e.toString());
    });

    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    HomeRepository().homeApi({
      "type":"payment_success",
      "video_id":videoId,
      "order_id":orderId,
      "amount":amount.toString(),
      "user_id":userId,
      "quality":quality,
      // "transaction details":response,
      "status":"failure",
    }).then((value) {
callback();
      MethodUtils.showToast("failure");
    }).catchError((e){
      callback();
      MethodUtils.showToast(e.toString());
    });

    print(["_handlePaymentError==========================",response]);
   // MethodUtils.showToast(jsonEncode(response));
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    HomeRepository().homeApi({
      "type":"payment_success",
      "video_id":videoId,
      "amount":amount.toString(),
      "order_id":orderId,
      "user_id":userId,
      "quality":quality,
      // "transaction details":response,
      "status":"success",
    }).then((value) {
      callback();
MethodUtils.showToast("Success !! Khawngaihin a in refresh hun lo nghak rawh...");
    }).catchError((e){
      callback();
      MethodUtils.showToast(e.toString());
    });

    print(["_handleExternalWallet==========================",response]);
  //  MethodUtils.showToast(jsonEncode(response));
    // Do something when an external wallet is selected
  }

  evantListnerClear(){
    _razorpay.clear(); // Removes all listeners
  }

}

class ApiServices {
  // final razorPayKey = "rzp_live_O0kWJvRzk5Bfj8";
  // final razorPaySecret = "vg8nFdI0afV7l3VoASURuI5M";

  Future<dynamic> razorPayApi(String? videoId, String receiptId,String? categoryId, String? quality) async {
    // var auth =
    //     'Basic ' + base64Encode(utf8.encode('$razorPayKey:$razorPaySecret'));

    var headers = {'content-type': 'application/json',};
    var request =
    http.Request('POST', Uri.parse(AppUrl.baseUrl));
    request.body = json.encode({
     "type":"generate_order",
      "video_id":videoId,
      "user_id":receiptId,
      "quality":quality,
      "category_id":categoryId,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      return {
        "status": "success",
        "body": jsonDecode(await response.stream.bytesToString())
      };
    } else {
      return {"status": "fail", "message": (response.reasonPhrase)};
    }
  }
}