import 'package:runmawi/Data/ApiResponse.dart';
import 'package:runmawi/Data/ApiUrl.dart';
import 'package:runmawi/Data/network/BaseApiService.dart';
import 'package:runmawi/Data/network/NetworkApiService.dart';

class HomeRepository{
  final BaseApiServices _apiServices = NetworkApiService();
  Future<ApiResponse> homeApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.baseUrl, data);
      return ApiResponse(response);
    }catch(e){
      rethrow ;
    }
  }
}