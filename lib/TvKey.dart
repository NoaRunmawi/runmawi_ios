import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/Model/TvKeyModel.dart';
import 'package:html_character_entities/html_character_entities.dart';


class TvKeyBuilder extends StatefulWidget {
  TvKey? data ;
   TvKeyBuilder({Key? key,this.data}) : super(key: key);

  @override
  State<TvKeyBuilder> createState() => _TvKeyBuilderState();
}

class _TvKeyBuilderState extends State<TvKeyBuilder> {
  @override
  Widget build(BuildContext context) {
    String decodedString = HtmlCharacterEntities.decode(widget.data?.htmlContent.toString()??"");
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop){

      },
      child: Scaffold(
        body:SingleChildScrollView(
          child: Container(
            height:height ,
            width: width,
            padding: EdgeInsets.only(top: 60,left: 16,right: 16),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.commonBackgroundPath),fit: BoxFit.fill)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBarRow(),
                Container(
                  height:height/3.2,
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(AppImages.icTvImage),fit: BoxFit.fill)
                  ),
                ),
                widget.data==null?Container(): _keyList(widget.data!.tvKey.toString().split("")),

                Align(
                    alignment: Alignment.center,
                    child: Text("Coming Soon.. ",style: Styles.style_White(fontsize: 20,fontWeight: FontWeight.w600),)),
                SizedBox(
                  height: 20,
                ),
                Text("Runmawi TV App is available for download at runmawi.com. \n\nKan website runmawi.com ah Runmawi TV App download theih in a awm e.",style: Styles.style_White(
                  fontsize: 12,fontWeight: FontWeight.w400
                ),),
                SizedBox(
                  height: 10,
                )
              // Text("Steps to watch in Android TV",style: Styles.style_White(fontsize: 16,fontWeight: FontWeight.w600),),
                //Html( data: decodedString,

              ],
            ),
          ),
        ) ,
      ),
    );
  }
  Widget _keyList(List<String> keys){
    return Container(
      height: 48,
      margin: EdgeInsets.only(top: 20,bottom: 12),
      alignment: Alignment.center,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: keys.length,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
        return Container(
          height: 48,
          width: 43,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: AppColor.secondaryBlackColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2),width: 1)
          ),
          child: Text(keys.elementAt(index),style: Styles.style_White(fontsize: 34,fontWeight: FontWeight.w700),),
        );
      }),
    );
  }
  Widget _buildAppBarRow()
  {
    return Row(
      children: [
        // Image.asset(
        //   AppImages.barBackImage,
        //   scale: 2,
        // ),
        // SizedBox(
        //   width: 10,
        // ),
        Text("Tv Key",style: Styles.style_White(fontsize: 18,fontWeight: FontWeight.w600),)
      ],
    );
  }
}
