

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/BetterPlayer.dart';
import 'package:runmawi/BuildMovieAdpatar.dart';
import 'package:runmawi/Model/HomeModel.dart';
import 'package:runmawi/Model/Homeprovider.dart';
import 'package:runmawi/MovieAdptar.dart';

class CategoryWiseMovie extends StatefulWidget {
  String? categoryName;
  Data? data ;
   CategoryWiseMovie({Key? key,this.categoryName,this.data}) : super(key: key);

  @override
  State<CategoryWiseMovie> createState() => _CategoryWiseMovieState();
}

class _CategoryWiseMovieState extends State<CategoryWiseMovie> {
  @override
  Widget build(BuildContext context) {
    if(widget.categoryName.toString()=="Free shows"){
      print("object"+ widget.data!.showList![0].id.toString());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.data?.showList==null?Container():    SizedBox(
          height: 20,
        ),
        widget.data?.showList==null?Container():   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.categoryName??"",style: const TextStyle(
                fontWeight: FontWeight.w600,fontSize: 16, color: Colors.white
            ),),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>MovieAdptar(
                categoryName: widget.categoryName,
                datalist: widget.categoryName.toString()=="Movies"?
                context.read<HomeProvider>().movieList.data:
                widget.data!.showList!,
                comefrom: "See",
              )));
            }, child:  const Text("See all",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400, color: Colors.white),))

          ],
        ),
        widget.data==null?Container():
        widget.data!.showList==null?Container():  Container(
          height: 150,
          margin: EdgeInsets.only(top: 10),
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: widget.data!.showList!.length < 5 ? widget.data!.showList!.length : 5,
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context,index){
            return Padding(
                padding: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: (){
                    print("callit=====");
                    if(widget.data!.showList![index].url.toString().contains("tvshow")){

                    }
                    else{
                      print("object===="+ widget.data!.showList![index].id.toString());

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DrmPage(widget.data!.showList![index].img.toString(),vedioId: widget.data!.showList![index].id.toString(),)));
                    }

                  },
                  child: MovieAdapter(
                    image: widget.data!.showList![index].img.toString(),
                    height: 180,width: 120,
                    url:widget.data!.showList![index].url.toString(),
                    id:widget.data!.showList![index].id.toString() , ),
                ));
          }),
        )
      ],
    );
  }
}
