import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/DefaultButton.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/Repositery/Homepage.dart';

class ShareRating extends StatefulWidget {
  String? vedioId;
   VoidCallback callback;
   ShareRating({Key? key,required this.vedioId,required this.callback}) : super(key: key);

  @override
  State<ShareRating> createState() => _ShareRatingState();
}

class _ShareRatingState extends State<ShareRating> {
  var rating = 0.0;
  bool isLoading  = false ;

  @override
  Widget build(BuildContext context) {
     BuildContext _crr = context;
    var height = MediaQuery.of(context).size.height;
    var widht = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: widht,
        padding: const EdgeInsets.only(top: 60,left: 16,right: 16),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.commonBackgroundPath),fit: BoxFit.fill)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBarRow(),
            Container(
              height: 143,
              width: MediaQuery.of(context).size.height/1.5,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/Images/RatingsTv.png"),)
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text("Rating",style: Styles.style_White(
                  fontsize: 16,fontWeight: FontWeight.w600
                ),),
                const SizedBox(
                  height: 10,
                ),
                Text("How would you rate your experience?",
                  style: Styles.job_medium_secondary(
                  fontsize: 14,fontWeight: FontWeight.w400
                ),),
                const SizedBox(
                  height: 10,
                ),
                CustomRatingBar(
                  allowHalfRatings: false,
                  filledIconColor: const Color(0xffFFBC00),
                  iconSize: 25,
                  initialRating: 0,
                  unfilledIconColor: const Color(0xffC1C1C1),

                  onRatingUpdate: (double ) {
                    rating = double;
               print("double$double");
                },),
                const SizedBox(
                  height: 10,
                ),
                Text("Please click on stars to select your desired rating.",style: Styles.job_medium_secondary(
                  fontsize: 14,fontWeight: FontWeight.w400
                ),),
                isLoading?const Center(child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(
                    color: AppColor.gradientButtonColor,
                  ),
                )):    DefaultButton(
                  text: "Send Feedback",
        onpress: ()async{
                    isLoading = true;
                    setState(() {

                    });
                    var userId=  await  AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id);
                   //MethodUtils.showLoader(_crr);
                     HomeRepository().homeApi({"type":"start_rating","user_id":userId,"ratings":rating.toString(),"video_id":widget.vedioId.toString()}).then((value) {
                       if(value.value['status']==true){

                         MethodUtils.showToast(value.value['message']);
                         widget.callback();
                       //  MethodUtils.hideLoader(_crr);
                         Navigator.pop(context);
                       }
                       else{
                         isLoading = false ;
                         setState(() {

                         });
                         MethodUtils.showToast(value.value['message']);
                       //  MethodUtils.hideLoader(context);
                       }
                     }).catchError((e){
                       isLoading = false ;
                       setState(() {

                       });
                       MethodUtils.showToast(e.toString());
                    //   MethodUtils.hideLoader(_crr);
                     });
        },
                  gradient: MethodUtils.gradients(),
                  margin: const EdgeInsets.only(top: 25,),
                  height: 60,
                  borderRadius: 16,
                  color: AppColor.secondaryBlackColor,
                  bordercolor: AppColor.secondaryBlackColor,
                  style: Styles.style_White(fontWeight: FontWeight.w400, fontsize: 16),
                )

              ],
            )
          ],
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
        const SizedBox(
          width: 15,
        ),
        Text("Share your Raiting",style: Styles.style_White(fontsize: 18,fontWeight: FontWeight.w600),)
      ],
    );
  }
}



class CustomRatingBar extends StatefulWidget {
  final int initialRating;
  final double iconSize;
  final Color filledIconColor;
  final Color unfilledIconColor;
  final bool allowHalfRatings;
  final void Function(double) onRatingUpdate;

  const CustomRatingBar({
    Key? key,
    this.initialRating = 0,
    this.iconSize = 40.0,
    this.filledIconColor = Colors.amber,
    this.unfilledIconColor = Colors.grey,
    this.allowHalfRatings = true,
    required this.onRatingUpdate,
  }) : super(key: key);

  @override
  State<CustomRatingBar> createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  double _currentRating = 0.0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        final double rating = index + 1.0;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {
                widget.onRatingUpdate(rating);
                setState(() {
                  _currentRating = rating;
                });
            },
            child: Icon(
              Icons.star,
              size: widget.iconSize,
              color: _currentRating >= rating
                  ? widget.filledIconColor
                  : widget.unfilledIconColor,
            ),
          ),
        );
      }),
    );
  }
}