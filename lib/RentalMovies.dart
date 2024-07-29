import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/Model/RentalMovieModel.dart';
import 'package:runmawi/Repositery/Homepage.dart';

class RentalMovies extends StatefulWidget {
  const RentalMovies({Key? key}) : super(key: key);

  @override
  State<RentalMovies> createState() => _RentalMoviesState();
}

class _RentalMoviesState extends State<RentalMovies> {
  
  bool isLoading = true;
  RentalMovieModel? rentalMovies ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi(context);
  }
  Future<void> callApi(BuildContext context)
  async{
    isLoading = true;
    AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id).then((value){
      HomeRepository().homeApi({"type":"rentalMovies","userid":value}).then((value2) {
        rentalMovies = RentalMovieModel.fromJson(value2.value);
        isLoading = false ;
        setState(() {

        });
      }).catchError((e){
        MethodUtils.showToast(e.toString());
        setState(() {
          isLoading = false;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(top: 50,left: 16,right: 16),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.commonBackgroundPath),
                fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset(AppImages.barBackImage,scale: 2,)),
                SizedBox(
                  width: 10,
                ),
                Text("Rented Shows & Movies",style: Styles.style_White(fontWeight: FontWeight.w600,fontsize:16 ),)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: _showBuildMovieCard(context)),
          ],
        ),
      ),
    );
  }
  Widget _showBuildMovieCard(BuildContext context)
  {
    return
      isLoading?Center(child: MethodUtils.adaptiveLoader()):
          rentalMovies!=null&&rentalMovies!.data!=null?
      ListView.builder(
      padding: EdgeInsets.zero,
        itemCount: rentalMovies!.data!.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,index)
    {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text("Renatl Movie",style:Styles.style_White(fontsize: 16,fontWeight: FontWeight.w600) ,),
          Container(

            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 20,),
            decoration: BoxDecoration(
              color: Color(0xff2A2929),
              borderRadius: BorderRadius.circular(16)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 32,
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
                  ),
                  child: Text("#Order : ${rentalMovies!.data!.elementAt(index).orderId.toString()}",style: Styles.style_White(fontsize: 13,fontWeight: FontWeight.w500),),
                ),
             Container(
               margin: EdgeInsets.only(top: 12,bottom: 12),
               padding: EdgeInsets.only(left: 16),
               child: Text("${rentalMovies!.data!.elementAt(index).videoTitle.toString()}",style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w600),),
             ),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12,bottom: 8),
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order Time :",style: Styles.style_White(fontsize: 12,fontWeight: FontWeight.w600),),
                      Text(rentalMovies!.data![index].createdAt.toString(),style:TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 13,fontWeight: FontWeight.w500),),
                    ],
                  )

                ),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: EdgeInsets.only(left: 16,right: 16),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Valid Till :",style: Styles.style_White(fontsize: 12,fontWeight: FontWeight.w600),),
                        Text(rentalMovies!.data![index].validTill.toString(),style:TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 13,fontWeight: FontWeight.w500),),
                      ],
                    )

                ),
              ],
            ),
          )
        ],
      );
    }):Container();
  }

  // Container(
  // //  height: 80,
  // padding: EdgeInsets.all(8),
  // margin: EdgeInsets.only(bottom: 10),
  // decoration: BoxDecoration(
  // color: AppColor.secondaryBlackColor,
  // borderRadius: BorderRadius.circular(16)
  // ),
  // child: Row(
  // crossAxisAlignment: CrossAxisAlignment.start,
  // mainAxisSize: MainAxisSize.min,
  // children: [
  // Image.asset(AppImages.demoMovieImage,scale: 1.5,),
  // SizedBox(
  // width: 15,
  // ),
  // Column(
  // crossAxisAlignment: CrossAxisAlignment.start,
  // // mainAxisAlignment: MainAxisAlignment.center,
  // children: [
  // SizedBox(
  // height: 8,
  // ),
  // Text("Boss level",style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w600),),
  // SizedBox(
  // height: 8,
  // ),
  // StarRating(),
  // SizedBox(
  // height: 10,
  // ),
  // Text("2019 |3h 17 min",style: Styles.job_medium_secondary(fontsize: 13,fontWeight: FontWeight.w300),),
  // DefaultButton(
  // text: "Watch Now",
  // width:MediaQuery.of(context).size.width/2.5,
  // image: AppImages.icPlayImage,
  // onpress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionHistory())),
  // gradient: MethodUtils.gradients(),
  // margin: const EdgeInsets.only(top: 10),
  // height: 50,
  // scale: 1.4,
  // borderRadius: 16,
  // color: AppColor.secondaryBlackColor,
  // bordercolor: AppColor.secondaryBlackColor,
  // style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 16),
  // ),
  // ],
  // )
  // ],
  // ),
  // );
}
