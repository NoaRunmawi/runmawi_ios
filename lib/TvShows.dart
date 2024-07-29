import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/DefaultButton.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:better_player/better_player.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/Model/TvShowModel.dart';
import 'package:runmawi/Ratings.dart';
import 'package:runmawi/Repositery/Homepage.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:runmawi/Repositery/RazorPay.dart';

import 'BetterPlayer.dart';

class TVShows extends StatefulWidget {
  String? VedioId;
   TVShows({Key? key,required this.VedioId}) : super(key: key);

  @override
  State<TVShows> createState() => _TVShowsState();
}

class _TVShowsState extends State<TVShows> {
  late BetterPlayerController _widevineController;
  ValueNotifier<String> saveMovie = ValueNotifier("0");
  TVShowModel? tvShows ;
  bool isLoading = true ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }
  bool checkValidity(String? validTill) {print("till Date"+ validTill.toString());
  // If validTill is null, return false
  if (validTill == null||validTill.isEmpty) {
    return false;
  }

  // Parse the validTill date and time
  DateTime validTillDateTime;
  try {
    validTillDateTime = DateFormat('dd-MMM-yy hh:mm a').parse(validTill);
  } catch (e) {
    print("euuuuu"+e.toString());
    // If parsing fails, return false
    return false;
  }
  // Get the current date and time
  DateTime currentDateTime = DateTime.now();

  // Check if the validTill date and time is in the future
  return validTillDateTime.isAfter(currentDateTime);
  }
  Future<void> callApi()async{
    isLoading = true;
    setState(() {

    });
    var userId = await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id);
     HomeRepository().homeApi({"type":"tv_show_detail","video_id":widget.VedioId,"user_id":userId,"build_type":"1"}).then((value) {
         tvShows = TVShowModel.fromJson(value.value!);
         if(tvShows!=null&&tvShows!.status==true){
           saveMovie.value = tvShows!.data![0].userSaveMovie.toString();
           isLoading = false;
           setState(() {

           });
         }
    else{
      isLoading = false;
      setState(() {

      });
         }
     }).catchError((e){
       print("E"+ e.toString());
       isLoading = false;
       setState(() {

       });
     });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:  Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(top: 40),
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage(AppImages.commonBackgroundPath),
    fit: BoxFit.cover)), child:
      isLoading?Center(child: CircularProgressIndicator()):
          tvShows==null? Center(
            child: Text("There Have No Data"),
          ):
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: tvShows!.data![0].img.toString().toString(),
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider,fit: BoxFit.cover),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10,left: 16,right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 5,

                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            child: Icon(
                              Icons.arrow_back,color: Colors.black,
                            ),
                          ),
                        ))

                  ],
                ),
              ),
            ),
            placeholder: (context, url) => const SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Container(
              height: MediaQuery.of(context).size.height/2.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(tvShows!.data![0].img.toString().toString()))
              ),
            ),
          ),
         // tvShows!.data![0].rentOption.toString()=="2"?
      checkValidity(tvShows!.data![0].validTill.toString())?Container():
          //DefaultButton(
           // text: "Rent All Episodes (₹${tvShows!.data![0].ppvCost.toString()})",
          //  onpress: ()async{
           //   print("UUUU"+  await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USERMOBILE));
            //  String userId = await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id);
             // RazorPayPaymentIntegration razorPay = RazorPayPaymentIntegration(callback: callApi);
            //  razorPay.amount = num.parse(tvShows!.data![0].ppvCost.toString());
            //  razorPay.userName = await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_name);
             // razorPay.contactNumber = await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USERMOBILE);
             // razorPay.categoryId = tvShows!.data![0].category.toString();
            //  razorPay.videoId = widget.VedioId.toString();
            //  razorPay.userId = userId;
            //  razorPay.quality = "high";
           //   razorPay.context = context;
            //  razorPay.initiliazation();
        //    },
          //  margin: const EdgeInsets.only(top: 10,left: 16,right: 16),
          //  height: 60,
           // borderRadius: 16,
           // color: Colors.blue,
           // bordercolor: AppColor.secondaryBlackColor,
         //   style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 16),
         // ),
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
            child: Row(
              children: [
                ValueListenableBuilder(valueListenable: saveMovie, builder: (context,isSave,Widget){
                  return _buildRow(
                      isSave.toString()=="0"?
                      "assets/Images/ic_save.png":"assets/Images/ic_savedMovie.png","Save for Later",()async{
                    //       MethodUtils.showLoader(context);
                    var userId = await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id);
                    HomeRepository().homeApi({"type":"save_video","user_id":userId.toString(),"tv_show_id":widget.VedioId,"status" : isSave.toString()=="0"?"1":"0"}).then((value) {
                      if(value.value['status']==true){
                        isSave.toString()=="0"? saveMovie.value="1": saveMovie.value="0";
                        //    Navigator.pop(context);
                        //   MethodUtils.hideLoader(context);
                        //  saveMovie.value = "1";
                        MethodUtils.showToast(value.value['message']);
                      }
                      else{
                        saveMovie.value = "0";
                        //    MethodUtils.hideLoader(context);
                        MethodUtils.showToast(value.value['message']);
                      }
                    }).catchError((e){
                      //   MethodUtils.hideLoader(context);
                      MethodUtils.showToast(e.toString());
                    });
                  });
                }),
                SizedBox(
                  width: 10,
                ),
                tvShows!.data![0].userRating.toString()=="0"?         _buildRow("assets/Images/ic_like.png","Rating",(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ShareRating(vedioId: tvShows!.data![0].id.toString(),callback: callApi,)));
                }):Expanded(child: Container()),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 10,right: 10,top: 5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(child: Text(tvShows!.data![0].title.toString(),style: Styles.style_White(fontsize: 24,fontWeight: FontWeight.w600),)),
          //       tvShows!.data![0].averageRating.toString() =="0"?Container():     Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Icon(Icons.star,color: Color(0xffF6C700),),
          //           SizedBox(
          //             width: 10,
          //           ),
          //           Text(tvShows!.data![0].averageRating.toString(),style: Styles.style_White(fontsize: 16,fontWeight: FontWeight.w600),)
          //         ],
          //       ),
          //
          //     ],
          //   ),
          //
          // ),
  Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(tvShows!.data![0].title.toString(),style: Styles.style_White(fontsize: 24,fontWeight: FontWeight.w600),)),
                tvShows!.data![0].userRating.toString()=="0"?Container():      Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star,color: Color(0xffF6C700),),
                    SizedBox(
                      width: 5,
                    ),
                    Text(tvShows!.data![0].userRating.toString(),style: Styles.style_White(fontsize: 16,fontWeight: FontWeight.w600),)
                  ],
                ),
              ],
            ),
      
          ),
          Padding(
              padding: EdgeInsets.only(top: 15,left: 10,right: 10),
              child: Html(
                data:
                tvShows!.data![0].html.toString(),style: {
      
              },
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: Text("Episodes",style: Styles.style_White(fontsize: 16,fontWeight: FontWeight.w600),),
          ),
          tvShows!.data![0].episodeDetails!=null&&tvShows!.data![0].episodeDetails!.isNotEmpty?        Column(
            children: List.generate(tvShows!.data![0].episodeDetails!.length, (index) =>   Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 10,right: 10,top: 20),
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              decoration: BoxDecoration(
                  color: Color(0xff2A2929),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: tvShows!.data![0].img.toString().toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      width:70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(image: imageProvider,fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Container(
                      height: MediaQuery.of(context).size.height/2.2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(tvShows!.data![0].img.toString().toString()))
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(tvShows!.data![0].episodeDetails![index].title.toString(),style: Styles.style_White(
                                    fontsize: 14,fontWeight: FontWeight.w600
                                ),),
                              ),
                              Text("${tvShows!.data![0].episodeDetails![index].length.toString()}",style: Styles.job_medium_secondary(fontsize: 12,fontWeight: FontWeight.w300),)
                            ],
                          ),
                        ),
                        DefaultButton(
                          text:
                          tvShows!.data![0].episodeDetails![index].episodeValidTill.toString().isEmpty?"Rent(₹${tvShows!.data![0].episodeDetails![index].ppvCost.toString()})":
                          "Watch Now",
                          width: MediaQuery.of(context).size.width/2.3,
                           onpress: ()=>
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification())),
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>DrmPage(tvShows!.data![0].episodeDetails![index].videoImage.toString(), vedioId: tvShows!.data![0].episodeDetails![index].id.toString(),))),

                            //    gradient: MethodUtils.gradients(),
                          margin: const EdgeInsets.only(top: 5,left: 16,right: 16),
                          height: 40,

                          borderRadius: 10,
                          image:  tvShows!.data![0].episodeDetails![index].episodeValidTill.toString().isEmpty?"":AppImages.icPlayImage,
                          scale: 2,
                          color: Colors.blue,
                          bordercolor: AppColor.secondaryBlackColor,
                          style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 16),
                        ),
      
                      ],
                    ),
                  )
                ],
              ),
            )),
          ):Container()
        ],
      ),
    ),
  ),
          SizedBox(
            height:70,
          )


        ],
      ),
      ),
    );
  }
  Widget _buildRow(String image, String text,void Function() ontap){
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image,scale: 2,),
              SizedBox(width: 10,),
              Text(text,style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w400),)
            ],
          ),

        ),
      ),
    );
  }
}
