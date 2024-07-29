import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/textstyle.dart';

class EmailTextField extends StatelessWidget {
  EmailTextField({super.key, required this.controller,required this.validator, required this.hinttext, this.borderRadius,this.suffixIcon,this.readOnly,this.onPressed,this.onChanged});
  final TextEditingController controller;
  final double? borderRadius;
  bool? readOnly;
  bool? suffixIcon;
  void Function()? onPressed;
  final String? Function(String?)? validator;
   String? Function(CountryCode? countryCode)? onChanged;
  String? hinttext;
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onTertiary;
    final hintText = hinttext??"";

    return TextFormField(
      controller: controller,
      keyboardType:
      hinttext=="Mobile Number"?TextInputType.number:
      TextInputType.emailAddress,
      inputFormatters:
      hinttext=="Mobile Number"?
      <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ]:[], // Only numbers
      validator: validator,

      readOnly: readOnly??false,

      //     (val) => Validators.validateEmail(
      //   val!,
      //       "Please Enter Vaild Email",
      //   ""
      // ),
      style: Styles.style_White(fontWeight: FontWeight.w400,fontsize: 14),
      decoration: InputDecoration(
        fillColor:AppColor.secondaryBlackColor,
        filled: true,
        enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                borderRadius??
                16),
            borderSide: BorderSide(
                color:  Colors.white.withOpacity(0.2),
                width: 1
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                borderRadius??
                16),
            borderSide: BorderSide(
                color: Colors.white.withOpacity(0.2),
                width: 1
            )
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                borderRadius??
                16),
            borderSide: BorderSide(
                color:  Colors.white.withOpacity(0.2),
                width: 1
            )
        ),
          prefixIcon: hintText=="Mobile Number"?  GestureDetector(
            child: CountryListPick(
              appBar: AppBar(
                backgroundColor: AppColor.gradientButtonColor,
                title: const Text('Pick your country'),
              ),
              // if you need custom picker use this
              pickerBuilder: (context, CountryCode? countryCode) {
                return SizedBox(

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                        ),
                        child: Image.asset(
                          countryCode!.flagUri.toString(),
                          package: 'country_list_pick',
                          height: 10,
                        ),
                      ),

                      Text( countryCode.dialCode.toString(),style: TextStyle(
                          color: textColor
                      ),),
                      /* Text(countryCode!.dialCode.toString()),*/
                    ],
                  ),
                );
              },
              initialSelection: '+91',
              // or
              // initialSelection: 'US'
              onChanged: onChanged,
            ),
          ):null,
          suffixIcon:
          (suffixIcon??false)?

          IconButton(onPressed:onPressed, icon:   Icon(Icons.search_outlined,color: Colors.white,))
        :null,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}