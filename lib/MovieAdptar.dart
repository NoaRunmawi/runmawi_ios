import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/BuildMovieAdpatar.dart';
import 'package:runmawi/CategoryMovie.dart';
import 'package:runmawi/Model/HomeModel.dart';
import 'package:runmawi/Repositery/Homepage.dart';

class MovieAdptar extends StatefulWidget {
  String? categoryName ;
  List<ShowList>? datalist ;
  String? comefrom ;
  MovieAdptar({Key? key,this.categoryName,this.datalist,this.comefrom}) : super(key: key);

  @override
  State<MovieAdptar> createState() => _MovieAdptarState();
}

class _MovieAdptarState extends State<MovieAdptar> {

  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop:widget.comefrom.toString()=="See"?true: false,
        onPopInvoked: (bool didPop) {

        },
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(top: 60,left: 16,right: 16),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.commonBackgroundPath),fit: BoxFit.fill)
          ),
          child: Column(
            children: [
              _buildAppBarRow(),

              widget.datalist==null   ?Padding(
                  padding: EdgeInsets.only(top: height/2.5),
                  child: MethodUtils.adaptiveLoader()):    Expanded(
                  child: SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 16/12,
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 16.0, // Spacing between columns
                        mainAxisSpacing: 16.0, // Spacing between rows
                      ),
                      itemCount:widget.datalist!.length,

                      //_datalist.length, // Number of items in the grid
                      itemBuilder: (context, index) {
                        return MovieAdapter(
                          width: MediaQuery.of(context).size.width,
                          image: widget.datalist![index].img.toString(),
                            url:widget.datalist![index].url.toString(),id:widget.datalist![index].id.toString()
                        );
                      },
                    ),
                  ),
                ),
              SizedBox(
                height: 60,
              ),
              // CategoryWiseMovie(categoryName: "Premium Movies",),
              // CategoryWiseMovie(categoryName: "Blockbuster Sci-Fi & Fantasy",),
              // CategoryWiseMovie(categoryName: "Premium Movies",),
              // CategoryWiseMovie(categoryName: "Blockbuster Sci-Fi & Fantasy",),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildAppBarRow()
  {
    return Row(
      children: [
        widget.categoryName!=null?
        GestureDetector(
        onTap: (){
      Navigator.pop(context);

    },
    child: Image.asset(AppImages.barBackImage,scale: 2,)):Container(),
   widget.categoryName!=null ?    SizedBox(width: 30,):SizedBox(),
        Text(
          widget.categoryName??
          "Movies",style: Styles.style_White(fontsize: 18,fontWeight: FontWeight.w600),)
      ],
    );
  }
}
