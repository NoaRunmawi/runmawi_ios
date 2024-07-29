import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/CustomeAppBar.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/DrawerScreen.dart';
import 'package:runmawi/Homepage.dart';
import 'package:runmawi/Model/Homeprovider.dart';
import 'package:runmawi/Model/TvKeyModel.dart';
import 'package:runmawi/MovieAdptar.dart';
import 'package:runmawi/RentalMovies.dart';
import 'package:runmawi/Repositery/Homepage.dart';
import 'package:runmawi/SavedMovieList.dart';
import 'package:runmawi/TvKey.dart';
import 'AppUtils/AppImages.dart';
import 'BottomTvShows.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TvKey? tvKeymodel ;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  GlobalKey<NavigatorState>  navigatorkey = GlobalKey<NavigatorState>();
  HomeProvider homeProvider = HomeProvider();
  String username = "";
  String userEmail = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeProvider.apisCall("homePage");
    homeProvider.tvShowApi("tvshow");
    callApi(context);
  }
  Future<void> callApi(BuildContext context)async{
    username =await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_name);
    userEmail =await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Email);
    AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id).then((value) {
           HomeRepository().homeApi({"type":"tvKey","userid":value}).then((value) {
             TvKey tvKeymodel = TvKey.fromJson(value.value);
             if(tvKeymodel.status==false){
             this.tvKeymodel = tvKeymodel;
               setState(() {
               });
             }
             else {
             }
           }).catchError((e){
           });
    });
  }
  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return Future.value(false);
    }
    final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentIndex].currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
    //exit(0);
    return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        _onWillPop();
      },

      child: Scaffold(
        key: scaffoldKey,
        drawer: DrawerScreen(
          scaffoldKey: scaffoldKey,
          userEmail: userEmail,
          userName: username,
          refreshCallback: (){
          onTap(4);
        },),
        body:

        Container(
          height: height,
          width: width,
          child:

          Stack(
            children: [
              [
                Offstage(
                  offstage: _currentIndex != 0,
                  child: Navigator(
                    key: _navigatorKeys[0],
                    onGenerateRoute: (routeSettings) {
                      return MaterialPageRoute(
                        builder: (context) => HomePage(scaffoldKey: scaffoldKey,homeProvider: homeProvider,),
                      );
                    },
                  ),
                ),
                Offstage(
                  offstage: _currentIndex != 1,
                  child: Navigator(
                    key: _navigatorKeys[1],
                    onGenerateRoute: (routeSettings) {
                      return MaterialPageRoute(
                        builder: (context) =>        ChangeNotifierProvider.value(value: homeProvider,child:
                        Consumer<HomeProvider>(
                          builder: (context,moviePage,_){
                            return moviePage.movieList.status==Status.LOADING?
                            Container(
                              height: height,
                              width: width,
                              padding: EdgeInsets.only(top: 60,left: 16,right: 16),
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage(AppImages.commonBackgroundPath),fit: BoxFit.fill)
                              ),
                              child: Center(child: MethodUtils.adaptiveLoader()),
                            )
                                : MovieAdptar(datalist: moviePage.movieList.data,);
                          },
                        ),),
                      );
                    },
                  ),
                ),

                Offstage(
                  offstage: _currentIndex != 2,
                  child: Navigator(
                    key: _navigatorKeys[2],
                    onGenerateRoute: (routeSettings) {
                      return MaterialPageRoute(
                        builder: (context) =>        ChangeNotifierProvider.value(value: homeProvider,child:
                        Consumer<HomeProvider>(
                          builder: (context,tvpage,_){
                            return tvpage.tvshowList.status==Status.LOADING?
                            Container(
                              height: height,
                              width: width,
                              padding: EdgeInsets.only(top: 60,left: 16,right: 16),
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage(AppImages.commonBackgroundPath),fit: BoxFit.fill)
                              ),
                              child: Center(child: MethodUtils.adaptiveLoader()),
                            )
                                : BottomTvShows(datalist: tvpage.tvshowList.data,);
                          },
                        ),),
                      );
                    },
                  ),
                ),


                SavedMoiveList(),
            TvKeyBuilder(data: tvKeymodel,),
              ].elementAt(_currentIndex),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      color: Color(0xff000000).withOpacity(1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
               Expanded(child: GestureDetector(
                   onTap: ()=>onTap(0),
                   child: homeNavItem(selectedImage: "assets/Images/Ic_home.png", color: _currentIndex==0?Colors.white:null, isSelected:_currentIndex==0? true:false))),
               Expanded(child: GestureDetector(
                   onTap: ()=>onTap(1),
                   child: homeNavItem(selectedImage: AppImages.icBottomMovie, color:_currentIndex==1?Colors.white: null, isSelected: _currentIndex==1?true:false))),
                      Expanded(child: GestureDetector(
                          onTap: ()=>onTap(2),
                          child: homeNavItem(selectedImage:  "assets/Images/Ic_bottomTvShow.png", color:_currentIndex==2?Colors.white: null, isSelected: _currentIndex==2?true:false))),


                      Expanded(child: GestureDetector(
                          onTap: ()=>onTap(3),
                          child: homeNavItem(selectedImage: AppImages.icDrawerSavedMooiveIcon, color: _currentIndex==3?Colors.white:null, isSelected:_currentIndex==3? true:false))),
                      Expanded(child: GestureDetector(
                          onTap: ()=>onTap(4),
                          child: homeNavItem(selectedImage: AppImages.icBottomTv, color:_currentIndex==4?Colors.white: null, isSelected:_currentIndex==4?true: false))),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void onTap(int index) {
    _currentIndex= index;
    setState(() {});
  }
   void _onBackPressed(bool sjj) async{
    print("call");
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: const Text("NO"),
          ),
          const SizedBox(height: 16,width: 40,),
          new GestureDetector(
            onTap: () =>  Navigator.of(context).pop(true),
            child: const Text("YES", style: TextStyle(
              color: AppColor.gradientButtonColor,
            ),),

          ),
          const SizedBox(
            width: 10,
            height: 20,
          )
        ],
      ),
    ) ;
    return Future.value(false);

  }
  Widget homeNavItem(
      {required String selectedImage,
         Color? color,
        required bool isSelected,
      }) {
    return Column(
      children: [
        Image.asset(
          selectedImage,
          scale:selectedImage=="${AppImages.imageCommonPath}/ic_save.png"?1.8: 3.5,
          color: color,
        ),
        isSelected?   Container(
          height: 4,
          margin: EdgeInsets.only(top: 8),
          width: 4,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle
          ),
        ):Container()

        //  SvgPicture.asset(selectedImage,height: height,width: width,),

      ],
    );
  }
}
