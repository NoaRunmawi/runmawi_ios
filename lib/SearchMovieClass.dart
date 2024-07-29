import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/BuildMovieAdpatar.dart';
import 'package:runmawi/EmailTextField.dart';
import 'package:runmawi/Model/SearchModel.dart';
import 'package:runmawi/Repositery/Homepage.dart';
import 'package:runmawi/validators.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  bool isLoading = false ;
  SearchResponse? searchMovie ;
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void callApi(String text){
    isLoading = true;
    setState(() {

    });
    HomeRepository().homeApi({"type":"search","searchkey":text.toString()}).then((value) {
      searchMovie = SearchResponse.fromJson(value.value);
      if(searchMovie !=null&&searchMovie!.status==true){
        isLoading = false;
        print("search"+ searchMovie.toString());
        setState(() {

        });
      }
      else{
        isLoading = false;
        setState(() {
        });
      }
    }).catchError((e){
      isLoading = false;
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(top: 10, left: 16, right: 16),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.commonBackgroundPath),
                  fit: BoxFit.cover)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBarRow(),
              // SizedBox(height: 20,),
              // _suggesionList(context),
              SizedBox(
                height: 20,
              ),
              Text("Search Result  (${searchMovie==null||searchMovie!.data!.length<0?"0":searchMovie!.data!.length.toString()})",style: Styles.style_White(fontWeight: FontWeight.w600,fontsize: 16),),
              SizedBox(
                height: 10,
              ),
              isLoading==true?
                  Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5),
                      child: Center(child: MethodUtils.adaptiveLoader())):
              _buildGrids(context)
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildGrids(BuildContext context)
  {
    return
      searchMovie==null||searchMovie!.data!.isEmpty?
           Center(child: Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/2.5 ),
              child: const Text("No Data Found")),): Expanded(
      child: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 16/18,
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 16.0, // Spacing between columns
            mainAxisSpacing: 16.0, // Spacing between rows
          ),
          itemCount: searchMovie!.data!.length, // Number of items in the grid
          itemBuilder: (context, index) {
            return MovieAdapter(
            width:
            MediaQuery.of(context).size.width,
              image: searchMovie!.data![index].img.toString(),
              id: searchMovie!.data![index].id.toString(),
              height: 100,
            );
          },
        ),
      ),
    );
  }
  Widget _buildAppBarRow()
  {
    return Row(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset(
            AppImages.barBackImage,
            scale: 2,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: EmailTextField(
              controller: _searchController,
              borderRadius: 25,
              suffixIcon: true,
              onPressed: (){
                FocusScope.of(context).unfocus();
                callApi(_searchController.text.toString());

              },
              validator: null,
              hinttext: "Number"),
        ),
      ],
    );
  }
  Widget _suggesionList(BuildContext context)
  {
    return Container(
      height: 40,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context,index){
        return _buildContainer(text:index==0? "Fast":"Fast and Furious");
      }),
    );
  }
  Widget _buildContainer({String? text})
  {
    return Container(
      height: 34,
      padding: EdgeInsets.symmetric(horizontal: 18),
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.search_outlined,color: Colors.white,size: 18,),
          SizedBox(
            width:5,
          ),
          Text(text??'',style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w400),)
        ],
      ),
    );
  }
}
