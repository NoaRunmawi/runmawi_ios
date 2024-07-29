
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/MyProfile.dart';
import 'package:runmawi/Repositery/Homepage.dart';
import 'package:runmawi/TranscationModel.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List<String> _daysList = [
    "Today","Yesterday"
  ];
  List<TranscationModel> _transcationList = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi(context);
   // _transcationList.add(TranscationModel(image: AppImages.icTransactionImage, title: "Boss level", subTitle: "Jan-02-2024, 21:00", trailing: "₹250", trailingSubTitle: "GT Bank"));
  }
  Future<void> callApi(BuildContext context)async{
    isLoading = true;
    await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id).then((value) {
      HomeRepository().homeApi({"type":"transaction","userid":value}).then((value2) {
        if(value2.value['status']==true)
          {
          for(int i =0; i<value2.value['data'].length;i++){
            _transcationList.add(TranscationModel(image: AppImages.icTransactionImage, title: value2.value['data'][i]['title'], subTitle: value2.value['data'][i]['created_at'], trailing: value2.value['data'][i]['amount_paid'] , trailingSubTitle: ""));
          }
          isLoading = false;
          setState(() {

          });
          }
        else{
isLoading = false;
setState(() {

});
        }
      }).catchError((e){print("error"+ e.toString());});
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(left: 16, right: 16, top: 50),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.commonBackgroundPath),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            _buildAppBarRow(),
            _buildList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: ()
          {
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
        Text(
          "Transaction History",
          style: Styles.style_White(fontWeight: FontWeight.w600, fontsize: 16),
        )
      ],
    );
  }
  Widget _buildList(BuildContext context){
    return
      isLoading?Padding(
        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5),
        child: MethodUtils.adaptiveLoader(),
      ):
      Expanded(
        child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(_transcationList[index].image,scale: 2,),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_transcationList[index].title.toString(),style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w400),),
                            Text(_transcationList[index].subTitle.toString(),style: Styles.job_medium_secondary(fontsize: 12,fontWeight: FontWeight.w400),)
                          ],
                        ),
                        Column(
                          children: [
                            Text(_transcationList[index].trailing.toString(),style: Styles.style_White(fontsize: 14,fontWeight: FontWeight.w400),),
                            Text(_transcationList[index].trailingSubTitle.toString(),style: Styles.job_medium_secondary(fontsize: 12,fontWeight: FontWeight.w400),)
                          ],
                        )
                      ],
                    ),
                  )
        
        
                ],
              );
            }, separatorBuilder: (context ,index)
        {
          return Divider(
            color: AppColor.secondaryBlackColor,
            thickness: 1,
          );
        }, itemCount: _transcationList.length),
      );
  }
}
