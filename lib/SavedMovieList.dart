import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/DefaultButton.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/Model/VedioDetails.dart';
import 'package:runmawi/Repositery/Homepage.dart';
import 'package:runmawi/StarRating.dart';
import 'package:runmawi/TransactionHistory.dart';

class SavedMoiveList extends StatefulWidget {
  const SavedMoiveList({Key? key}) : super(key: key);

  @override
  State<SavedMoiveList> createState() => _SavedMoiveListState();
}

class _SavedMoiveListState extends State<SavedMoiveList> {
  MovieModel? movieModel ;
  bool isLoading = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (mounted) {
      callApi(context);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<void> callApi(BuildContext context)async{
    var userId = await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id);
    HomeRepository().homeApi({"type":"show_save_video_list","user_id":userId}).then((value) {
      movieModel = MovieModel.fromJson(value.value);
      if(movieModel!=null&&movieModel!.status==true){
          isLoading = false;
          setState(() {

          });
      }
      else{
        isLoading = false;
        setState(() {

        });
        MethodUtils.showToast(movieModel!.message.toString());
      }
    }).catchError((e){
    // MethodUtils.showToast(e.toString());
      isLoading = false;
      setState(() {

      });
    });

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop){

      },
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(top: 50,left: 16,right: 16),
      decoration: BoxDecoration(
      image: DecorationImage(
      image: AssetImage(AppImages.commonBackgroundPath),
      fit: BoxFit.cover),
        ),
        child:

        Column(
          children: [
            Row(
              children: [
                // GestureDetector(
                //     onTap: (){
                //       Navigator.pop(context);
                //     },
                //     child: Image.asset(AppImages.barBackImage,scale: 2,)),
                SizedBox(
                  width: 10,
                ),
                Text("Save For Later List",style: Styles.style_White(fontWeight: FontWeight.w600,fontsize:16 ),)
              ],
            ),
            SizedBox(height: 20,
             ),

            Text(
              "\n\nComing soon..",style: Styles.style_White(fontsize: 18,fontWeight: FontWeight.w600),),

            // isLoading == true? Center(child: MethodUtils.adaptiveLoader(),):
            // movieModel?.data==null?Container():
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: movieModel!.data!.length,
            //       shrinkWrap: true,
            //       padding: EdgeInsets.zero,
            //       itemBuilder: (context,index){
            //     return    _buildMovieCard(movieModel!.data![index]);
            //   }),
            // )

          ],
        ),
        )
      ),
    );
  }
  Widget _buildMovieCard(MovieData movieData){
    return Container(
    // height: 80,
      width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
    color: AppColor.secondaryBlackColor,
    borderRadius: BorderRadius.circular(16)
    ),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      CachedNetworkImage(
        imageUrl: movieData.img.toString().toString(),
        imageBuilder: (context, imageProvider) => Container(
        height: 150,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(image: imageProvider,fit: BoxFit.cover),
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
              image: DecorationImage(image: AssetImage(AppImages.demoMovieImage))
          ),
        ),
      ),
    SizedBox(
    width: 15,
    ),
    Expanded(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
      SizedBox(
      height: 8,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(movieData.title.toString(),style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w600),)),
          GestureDetector(
              onTap: () async {
                var userId = await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id);
                MethodUtils.showLoader(context);
                HomeRepository().homeApi({"type":"save_video","user_id":userId.toString(),"video_id":movieData.videoId.toString(),"status" : "0"}).then((value) {
                  if(value.value['status']==true){

                    //  saveMovie.value = "1";
                   movieModel!.data!.removeWhere((element) => element.videoId==movieData.videoId);
                   MethodUtils.hideLoader(context);
                   setState(() {

                   });
                 //   MethodUtils.showToast(value.value['message']);
                  }
                  else{
                    MethodUtils.hideLoader(context);
                    MethodUtils.showToast(value.value['message']);
                  }
                }).catchError((e){
                  MethodUtils.hideLoader(context);
                  MethodUtils.showToast(e.toString());
                });
              },
              child: Image.asset(AppImages.icDrawerDarkSavedMooiveIcon,scale: 3,)),
        ],
      )
      ,
        movieData.average_rating.toString()!="0"?   SizedBox(
      height: 8,
      ):SizedBox(),
  movieData.average_rating.toString()=="0"?
  Container():
  StarRating(movieData.average_rating),
      SizedBox(
      height: 10,
      ),
      Text("${movieData.releaseYear.toString()} |${movieData.length.toString()}",style: Styles.job_medium_secondary(fontsize: 13,fontWeight: FontWeight.w300),),
      DefaultButton(
      text: "Watch Now",
      width:MediaQuery.of(context).size.width/2.5,
      image: AppImages.icPlayImage,
      onpress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionHistory())),
      gradient: MethodUtils.gradients(),
      margin: const EdgeInsets.only(top: 10),
      height: 40,
      scale: 2.8,
      borderRadius: 10,
      color: AppColor.secondaryBlackColor,
      bordercolor: AppColor.secondaryBlackColor,
      style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 14),
      ),
      ],
      ),
    )
    ],
    ),
    );
  }
}
