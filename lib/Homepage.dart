import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/CustomeAppBar.dart';
import 'package:runmawi/AppUtils/DefaultButton.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/CategoryMovie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:runmawi/Model/HomeModel.dart';
import 'package:runmawi/Model/Homeprovider.dart';
import 'package:runmawi/Repositery/Homepage.dart';
import 'package:runmawi/TvShows.dart';
import 'package:runmawi/WatchMovies.dart';
import 'package:runmawi/Webview.dart';
import 'package:runmawi/test.dart';
import 'package:runmawi/vdoPlayBack.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

import 'BetterPlayer.dart';

class HomePage extends StatefulWidget {
  HomeProvider? homeProvider ;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   HomePage({Key? key,required this.scaffoldKey,this.homeProvider}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
"assets/Images/Ic_demo2.png","assets/Images/Ic_demo2.png","assets/Images/Ic_demo2.png","assets/Images/Ic_demo2.png"
  ];
  List <Data> _dataList = [];
  bool isLoading = true;
  @override
  void initState() {
    _saveAssetSubtitleToFile();
    // TODO: implement initState
    super.initState();
   //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
   // //   callApi();
   //  });

  }



  Future _saveAssetSubtitleToFile() async {
    String content =
    await rootBundle.loadString("assets/example_subtitles.srt");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/example_subtitles.srt");
    file.writeAsString(content);
  }

  Future<void> callApi()async {
    isLoading = true;
    setState(() {

    });
    HomeRepository().homeApi({"type":"homePage"}).then((value){
       HomeModel homeModel = HomeModel.fromJson(value.value);
       if(homeModel.status==true)
         {
           isLoading = false;
           _dataList.addAll(homeModel.data!);
           setState(() {

           });
         }
       else
         {
           MethodUtils.showToast(homeModel.data.toString());
         }
    }).catchError((e){
     // MethodUtils.showToast(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(top: 50,left: 16,right: 16),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.commonBackgroundPath),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(scaffoldKey: widget.scaffoldKey,),
              // isLoading?Padding(
              //     padding: EdgeInsets.only(top: height/2.6),
              //     child: MethodUtils.adaptiveLoader()):
              ChangeNotifierProvider.value(
              //  create:  (BuildContext context) => widget.homeProvider!,
                value: widget.homeProvider!,
                child: Consumer<HomeProvider>(
                builder: (context, homePage, _) {
                  return
                    homePage.prefsList.status==Status.LOADING?
                        MethodUtils.adaptiveLoader():
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBanner(homePage.prefsList.data![0]),
                     for(int i =1;i<homePage.prefsList.data!.length;i++)
                      CategoryWiseMovie(categoryName:homePage.prefsList.data![i].categoryName.toString(),data:homePage.prefsList.data![i],),
      
                      SizedBox(
                        height: 70,
                      )
                    ],
                  );
                }
              ))
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildBanner(Data homeData)
  {
    return CarouselSlider(
        items: homeData.showList!.map((imagePath) {
          return Container(
            height: MediaQuery.of(context).size.height/2.2,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child:
            CachedNetworkImage(
              imageUrl: imagePath.img.toString(),
              imageBuilder: (context, imageProvider) => GestureDetector(
                onTap: (){
                  print("imagePath.url.toString()"+ imagePath.url.toString());
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>Test()));
                  if(imagePath.url.toString().contains("tvshow")){

                    // print("yha se ja rha h");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TVShows(
                      VedioId: imagePath.id.toString(),
                    )));
                  }
                  else{
                    // print("yha se ja rha h=====");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DrmPage(imagePath.img.toString(), vedioId: imagePath.id.toString(),)));
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height/3.2,
                  margin: EdgeInsets.only(top: 20),
               //   padding: EdgeInsets.only(bottom: 20,left: 20,right: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                        ),
                  ),
                  child:   Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //   Text(imagePath.title.toString(),
                      // maxLines: 1,
                      //     textAlign: TextAlign.center,
                      //     style: Styles.style_White(fontsize: 24,fontWeight: FontWeight.bold),),
                      //   SizedBox(
                      //     height: 5,
                      //   ),
                      //   Text("Action 6 Episodes Fantasy",
                      //     textAlign: TextAlign.end,
                      //     style: Styles.style_White(fontsize: 12,fontWeight: FontWeight.w400),),
                      // DefaultButton(
                      //   text: "Watch Now",
                      //   width:MediaQuery.of(context).size.width/2,
                      //   image: AppImages.icPlayImage,
                      //   onpress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>WatchMovie())),
                      //   gradient: MethodUtils.gradients(),
                      //   margin: const EdgeInsets.only(top: 20),
                      //   height: 50,
                      //   scale: 1.4,
                      //   borderRadius: 16,
                      //   color: AppColor.secondaryBlackColor,
                      //   bordercolor: AppColor.secondaryBlackColor,
                      //   style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 16),
                      // ),
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
                  image: DecorationImage(image: AssetImage(images.first.toString()))
                ),
              ),
            ),

          );
        }).toList(),
        options: CarouselOptions(

          height:MediaQuery.of(context).size.height/3.2, // Set the height of the carousel
         // aspectRatio: 16/9, // Adjust the aspect ratio as needed
          autoPlay: true, // Enable auto-play
          autoPlayInterval: Duration(seconds: 8), // Set auto-play interval
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            // Callback when the page changes

          },
        ),
      );

  }
}





