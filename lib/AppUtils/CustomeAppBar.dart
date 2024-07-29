import 'package:flutter/material.dart';
import 'package:runmawi/NotificationScreen.dart';
import 'package:runmawi/RentalMovies.dart';
import 'package:runmawi/SearchMovieClass.dart';

class CustomAppBar extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   CustomAppBar({Key? key,required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: ()
                {
                  if (scaffoldKey.currentState!.isDrawerOpen) {
                    scaffoldKey.currentState?.closeDrawer();
                  } else {
                    scaffoldKey.currentState?.openDrawer();
                  }
                },
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      //   color: Colors.white.withOpacity(0.8),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                        shape: BoxShape.circle
                    ),
                    child: Image.asset("assets/Images/Ic_drawerListIcon.png",scale: 28,color: Colors.white,))),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Image.asset("assets/Images/AppLogo.png",scale: 12,)),
          ],
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchMovie()));
                },
                child: Image.asset("assets/Images/Ic_search.png",scale: 1.2,)),
            SizedBox(width: 10,),
          GestureDetector(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
              },
              child: Image.asset("assets/Images/Ic_notifiction.png",scale: 2.3,)),
        ],),
      ],
    );
  }
}
