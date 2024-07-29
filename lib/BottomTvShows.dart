import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/BuildMovieAdpatar.dart';
import 'package:runmawi/Model/HomeModel.dart';

class BottomTvShows extends StatefulWidget {
  List<ShowList>? datalist ;
   BottomTvShows({Key? key,this.datalist}) : super(key: key);

  @override
  State<BottomTvShows> createState() => _BottomTvShowsState();
}

class _BottomTvShowsState extends State<BottomTvShows> {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {



      },
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(top: 50,left: 16,right: 16),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.commonBackgroundPath),
                fit: BoxFit.cover)),
        child:Column(
          children: [
            _buildAppBarRow(),
            widget.datalist==null   ?Padding(
                padding: EdgeInsets.only(top: height/2.5),
                child: MethodUtils.adaptiveLoader()):



              Text(
                "\n\nComing soon..",style: Styles.style_White(fontsize: 18,fontWeight: FontWeight.w600),),

            Text(
              "\n\nStream it on runmawi.in website ",style: Styles.style_White(fontsize: 18,fontWeight: FontWeight.w600),),


            // Expanded(
            //   child: SingleChildScrollView(
            //     child: GridView.builder(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         childAspectRatio: 16/12,
            //         crossAxisCount: 2, // Number of columns in the grid
            //         crossAxisSpacing: 16.0, // Spacing between columns
            //         mainAxisSpacing: 16.0, // Spacing between rows
            //       ),
            //       itemCount:widget.datalist!.length,
            //
            //       //_datalist.length, // Number of items in the grid
            //       itemBuilder: (context, index) {
            //         return MovieAdapter(
            //           width: MediaQuery.of(context).size.width,
            //           image: widget.datalist![index].img.toString(),
            //           id: widget.datalist![index].id.toString(),
            //           url: "tvshow"
            //         );
            //       },
            //     ),
            //   ),
            // ),
            //

            SizedBox(
              height: 60,
            )
          ],
        )
        ,
      ),
    );
  }
  Widget _buildAppBarRow()
  {
    return Row(
      children: [
        Text(
              "Tv Shows ",style: Styles.style_White(fontsize: 18,fontWeight: FontWeight.w600),)
      ],
    );
  }
}
