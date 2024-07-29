import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/Data/ApiUrl.dart';
import 'package:runmawi/MyProfile.dart';
import 'package:runmawi/RentalMovies.dart';
import 'package:runmawi/SavedMovieList.dart';
import 'package:runmawi/SignInScreen.dart';
import 'package:runmawi/TransactionHistory.dart';
import 'package:runmawi/Webview.dart';

class DrawerScreen extends StatelessWidget {
  final VoidCallback refreshCallback;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? userName;
  String? userEmail;
   DrawerScreen({Key? key,required this.refreshCallback,required this.scaffoldKey,this.userName,this.userEmail}) : super(key: key);

  final List<DrawerListItem> _drawerListItem = [
    DrawerListItem(ValueNotifier(false),
        text: "TV Key", Icon: AppImages.icDrawerTV,),
    // DrawerListItem(ValueNotifier(false),
    //     text: "Save List",
    //     Icon: AppImages.icDrawerSavedMooiveIcon
    //     ),
    //DrawerListItem(ValueNotifier(false),
     //   text: "Rented Shows & Movies",
      //  Icon: AppImages.icDrawerRental
    //),
    DrawerListItem(ValueNotifier(false),
        text: "Transaction History",
        Icon: AppImages.icDrawerTransCation),
    DrawerListItem(ValueNotifier(false),
        text: "Zawhna / Chhanna (FAQ)", Icon:AppImages.icDrawerFaq),
    DrawerListItem(ValueNotifier(false),
        text: "About",
        Icon: AppImages.icDrawerAbout),
    DrawerListItem(ValueNotifier(false),
        text: "Contact Us",
        Icon:AppImages.icDrawerContact,),
    DrawerListItem(ValueNotifier(false),
        text: "Privacy Policy", Icon: AppImages.icDrawerPrivacy),
    DrawerListItem(ValueNotifier(false),
        text: "Terms of Use",
        Icon:AppImages.icDrawerTerms),
    DrawerListItem(ValueNotifier(false),
        text: "Payment & Refund Policies",
        Icon: AppImages.icDrawerPayments),
    DrawerListItem(ValueNotifier(false),
        text: "Logout",
        Icon: AppImages.icDrawerLogout),

  ];

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Drawer(
      backgroundColor: Color(0xff131212),
      width: MediaQuery.of(context).size.width / 1.35,
      shadowColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16,right: 16,top: 20),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.icDrawerBackground),fit: BoxFit.cover)
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/Images/Ic_Profile.png",scale: 2,),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userName.toString(),style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w600),),
                            Text(userEmail.toString(),style: Styles.job_medium_secondary(fontsize: 12,fontWeight: FontWeight.w400),)
                          ],
                        )
                      ],
                    ),
                    Image.asset(AppImages.icEditIcon,scale: 2,)
                  ],
                ),
              ),
            SizedBox(height: 10,),
              ..._drawerListItem.map((e) =>drawerListExpansion(context,e) )

            ],
          ),
        ),
      ),
    ));
  }

  Widget drawerListExpansion(BuildContext context , DrawerListItem e)
  {
    return Column(
      children: [
        if(e.text.toString()=="Zawhna / Chhanna (FAQ)"||e.text.toString()=="Logout")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 10,
                color: AppColor.secondaryBlackColor.withOpacity(0.9),
              ),
              SizedBox(
                height: 10,
              ),
              Text(e.text.toString()=="Logout"?"Other":"Zawhna / Chhanna (FAQ)",style: Styles.style_White(fontsize: 16,fontWeight: FontWeight.w600),)
            ],
          ),
        ValueListenableBuilder(
          valueListenable: e.isExpanded,
          builder: (context,value,widget) {
            return GestureDetector(
              onTap: ()
              {
                for(int i=0; i<_drawerListItem.length;i++)
                  {
                    if(e.text!=_drawerListItem[i].text)
                    {
                      _drawerListItem[i].isExpanded.value =false;
                    }
                    else{
                      _drawerListItem[i].isExpanded.value = true;

                      if(_drawerListItem[i].text.toString().replaceAll(" ", "")=="RentedShows&Movies"){
             Navigator.push(context,MaterialPageRoute(builder: (context)=>RentalMovies()));
                      }
                      else if(_drawerListItem[i].text.toString() == "Transaction History"){

        Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionHistory()));
                      }else if(_drawerListItem[i].text.toString()=="Save List"){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedMoiveList()));
                      }
                   
                      else if(_drawerListItem[i].text.toString() =="TV Key"){
refreshCallback();
scaffoldKey.currentState!.closeDrawer();
                      }
                      else if(_drawerListItem[i].text.toString()=="Logout"){
                        _showLogoutButton(context);
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(_drawerListItem[i].text.toString(), getUrl(_drawerListItem[i].text.toString()))));
                      }
                    }
                  }
              },
              child: AnimatedContainer(
                duration: Duration(microseconds: 500),
                height:44,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
                decoration: e.isExpanded.value?BoxDecoration(
                  color: Color(0xff2A2929),
                  borderRadius: BorderRadius.circular(12)
                ):null,
                child: Row(
                  children: [
                  e.isExpanded.value?  AnimatedContainer(
                    duration: Duration(microseconds: 500),
                      height: 20,
                      width: 4,
                      decoration: BoxDecoration(
                        gradient: MethodUtils.gradients(),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFf26806),
                              blurRadius: 18,
                              spreadRadius: 0,
                            ),
                          ],
                        borderRadius: BorderRadius.only(topRight: Radius.circular(4),bottomRight: Radius.circular(4))
                      ),
                    ):Container(),
                    SizedBox(width:
                    e.isExpanded.value?12:
                    16,),
                    Image.asset(e.Icon.toString(),scale: 2,),
                    SizedBox(width: 8,),
                    Expanded(child: Text(e.text.toString(),style: Styles.job_medium_secondary(fontsize: 14,fontWeight: FontWeight.w500),))
                  ],
                ),
              ),
            );
          }
        ),
      ],
    );
  }
  Future<void> _showLogoutButton(BuildContext context)async{
    showDialog(
        context: context,
        
        builder: (BuildContext context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          
          title: const Text(
            'Are you sure you want to Logout?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          titlePadding: const EdgeInsets.only(
              bottom: 40, left: 30, right: 30, top: 20),
          content: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: AppColor.textSecondaryColor,
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    height: 50,
                  ),
                ),
              ),
              const SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    width: 0.2,
                  )),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    // Navigator.pop(context);
                    AppPrefrence.clearPrefrence();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                      return const SignInScreen();
                    }), (route) => false);

                  },
                  child: Container(
                    color: AppColor.gradientButtonColor,
                    child: const Center(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
  String getUrl(String type){
    if(type=="Payment & Refund Policies"){
      return  AppUrl.refundPolicy;
    }
    else if(type.contains("Terms of Use")) {
      return AppUrl.termsCondition;
    } else if(type.contains("Privacy Policy")){
  return AppUrl.privacyPolicy;
    }
    else if(type =="Contact Us"){
return AppUrl.contactUs;
    }
    else if(type.toString()=="About"){
  return AppUrl.aboutUs;
    }else {
  return AppUrl.Faq;
    }
  }
}

class DrawerListItem {
  String text;
  ValueNotifier isExpanded = ValueNotifier(false);
  String Icon;

  DrawerListItem(this.isExpanded,
      {required this.text, required this.Icon,});
}
