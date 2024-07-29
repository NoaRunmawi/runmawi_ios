  import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/Model/HomeModel.dart';
import 'package:runmawi/Repositery/Homepage.dart';

class HomeProvider extends ChangeNotifier{

  ApiResponse<List<Data>> prefsList = ApiResponse.loading();
  ApiResponse<List<ShowList>> movieList = ApiResponse.loading();
  ApiResponse<List<ShowList>> tvshowList = ApiResponse.loading();
  Future<void>  apisCall(String type)async{
    //homePage
    HomeRepository().homeApi({"type":type}).then((value){
      if(value.value['status']== true){
        if(type=="homePage"){
          print("yes again call");
          HomeModel homeModel = HomeModel.fromJson(value.value);
          prefsList=    ApiResponse.completed(homeModel.data);
          notifyListeners();
          apisCall("movies");
        }
        else{
       List<ShowList> _datalist=[];
         value.value['data'].forEach((v) {
            _datalist.add( ShowList.fromJson(v));
          });
         movieList = ApiResponse.completed(_datalist);
         print("jjjjj"+ movieList.data!.length.toString());
         notifyListeners();
        }
      }
      else
      {
        MethodUtils.showToast(value.value['message'].toString());
      }

    }).catchError((e){
      MethodUtils.showToast(e.toString());
    });
  }
  Future<void>  tvShowApi(String type)async{
    //homePage
    HomeRepository().homeApi({"type":"tvShows"}).then((value){
      if(value.value['status']== true){
      //  print("HHhhh"+ value.value['data']);
        List<ShowList> _datalist=[];
        value.value['data'].forEach((v) {
          _datalist.add( ShowList.fromJson(v));
        });

        tvshowList = ApiResponse.completed(_datalist);
        notifyListeners();
      }
      else
      {
        MethodUtils.showToast(value.value['message'].toString());
      }
    }).catchError((e){
      MethodUtils.showToast(e.toString());
    });
  }
}



  enum Status {LOADING, COMPLETED, ERROR}
  class ApiResponse<T> {

    Status? status ;
    T? data ;
    String? message ;

    ApiResponse(this.status , this.data, this.message);


    ApiResponse.loading() : status = Status.LOADING ;

    ApiResponse.completed(this.data) : status = Status.COMPLETED ;

    ApiResponse.error(this.message) : status = Status.ERROR ;


    @override
    String toString(){
      return "Status : $status \n Message : $message \n Data: $data" ;
    }


  }