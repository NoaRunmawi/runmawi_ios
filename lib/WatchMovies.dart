import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/DefaultButton.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/CategoryMovie.dart';

class WatchMovie extends StatefulWidget {

  const WatchMovie({Key? key}) : super(key: key);

  @override
  State<WatchMovie> createState() => _WatchMovieState();
}

class _WatchMovieState extends State<WatchMovie> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(top: 0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.commonBackgroundPath),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
          height: height/2.8,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/Images/Ic_demo2.png"),fit: BoxFit.fill)
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 40,left: 16,right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.barBackImage,
                  scale: 2,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/Images/Ic_play.png",scale: 2,))
              ],
            ),
          ),
        ),
            DefaultButton(
              text: "Rent (₹100)",
             // onpress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification())),
              gradient: MethodUtils.gradients(),
              margin: const EdgeInsets.only(top: 0,left: 16,right: 16),
              height: 60,
              borderRadius: 16,
              color: AppColor.secondaryBlackColor,
              bordercolor: AppColor.secondaryBlackColor,
              style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 16),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16,right: 16,top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dune",style: Styles.style_White(fontsize: 24,fontWeight: FontWeight.w600),),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star,color: Color(0xffF6C700),),
                      Text("4.5",style: Styles.style_White(fontsize: 16,fontWeight: FontWeight.w600),)
                    ],
                  ),

                ],
              ),

            ),

            Container(
              height: 32,
              margin: EdgeInsets.only(left: 16,top: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context,index){
                    return Container(
                      height: 32,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color:AppColor.secondaryBlackColor),
                        borderRadius:BorderRadius.circular(16)
                      ),
                      child: Text("Action",style: Styles.style_White(fontsize: 10,fontWeight: FontWeight.w400),),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16,right: 16,top: 10),
              child: Text("Birth Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam... Read More",
              style: Styles.job_medium_secondary(fontsize: 12,fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: Column(
                  children: [
                    CategoryWiseMovie(categoryName: "Premium Movies",),
                    CategoryWiseMovie(categoryName: "Blockbuster Sci-Fi & Fantasy",),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
