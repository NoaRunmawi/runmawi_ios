import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/Model/NotificationModel.dart';
import 'package:runmawi/Repositery/Homepage.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationModel? notificationModel ;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }
  Future<void> callApi()async{
    isLoading = true;
    AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id).then((value) {
      HomeRepository().homeApi({"type":"notification","userid":value.toString()}).then((value2) {
        notificationModel = NotificationModel.fromJson(value2.value);
        if(notificationModel!.status==true){
          isLoading= false;
          setState(() {

          });
        }
        else{
          isLoading = false ;
          setState(() {

          });
        }
      }).catchError((e){
        isLoading = false;
        setState(() {

        });
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
          height:height ,
          width: width,
          padding: EdgeInsets.only(left: 16,right: 16),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.commonBackgroundPath),fit: BoxFit.fill)
          ),
          child: Column(
            children: [
              _buildAppBarRow(),
          SizedBox(
            height: 20,
          ),
              isLoading?Padding(
                  padding: EdgeInsets.only(top: height/2.7),
                  child: MethodUtils.adaptiveLoader()):
              notificationModel?.data==null?
                  Container():
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: notificationModel!.data!.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index)
                {
                  return Container(
                    //  height: 80,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: AppColor.secondaryBlackColor,
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CachedNetworkImage(
                          imageUrl: notificationModel!.data![index].image.toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            height: 70,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                    //    Image.asset(AppImages.demoMovieImage,scale: 3,),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(notificationModel!.data![index].title.toString(),style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w600),),
                            Text(notificationModel!.data![index].message.toString(),style: Styles.job_medium_secondary(fontsize: 13,fontWeight: FontWeight.w300),),
                            Text(DateFormat('dd/MM/yyyy').format(DateTime.parse(notificationModel!.data![index].createdAt.toString())),style: Styles.job_medium_secondary(fontsize: 13,fontWeight: FontWeight.w300),),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          )
            ],
          ),
        )
      ),
    );
  }
  Widget _buildAppBarRow()
  {
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
    Text("Notification",style: Styles.style_White(fontsize: 18,fontWeight: FontWeight.w600),)
      ],
    );
  }
}
