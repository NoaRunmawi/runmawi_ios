import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/Data/app_excaptions.dart';
import 'package:runmawi/Data/network/BaseApiService.dart';
import 'package:runmawi/Home.dart';
import 'package:runmawi/SignInScreen.dart';
import '../../main.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      String token = "";
      await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_TOKEN)
          .then((value) {
        token = value;
      });
      debugPrint("Request Path =" + url + "token=\n" + token.toString());
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      }).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    debugPrint("Response  $responseJson");
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      String token = "";
      await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_TOKEN)
          .then((value) {
        token = value;
      });
      debugPrint("Request Path ==$url\n${data}token=\n$token");
      Response response = await http.post(Uri.parse(url), body: data, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      _showRetryDialog(
          NavigationService.navigatorKey.currentContext!, url, data);
      throw "Please Try again";
    } catch (e) {
      print("error on method" + e.toString());
      throw e;
    }
    log("Response  $responseJson");
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    debugPrint("res${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        if (responseJson['status'].toString() == "404") {
          _callmethod(NavigationService.navigatorKey.currentContext!);
          throw UnauthorisedException("");
        } else {
          return responseJson;
        }
      case 400:
        throw FetchDataException("");
      case 500:
        throw FetchDataException("");
      case 404:
        throw UnauthorisedException("");

      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }

  Future<void> _callmethod(BuildContext context) async {
    print("Call");
    AppPrefrence.clearPrefrence();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (route) => false,
    );
  }

  void _showRetryDialog(BuildContext context, String url, dynamic data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Request Timed Out"),
          content: Text("The request has timed out. Do you want to retry?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Retry"),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

/* Future<void> onError()
  async{
    AppPrefrence.clearPrefrence();
    Navigator.pushAndRemoveUntil(
        AppConstants.context,
        MaterialPageRoute(
            builder: (context) => new SignInPage()
        ),
        ModalRoute.withName("/main")
    );
  }*/
}
