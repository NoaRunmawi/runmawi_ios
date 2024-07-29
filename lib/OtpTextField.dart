import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/textstyle.dart';

class OTPTextField extends StatefulWidget {
  List<TextEditingController> controllers;
  OTPTextField(this.controllers);
  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  late List<FocusNode> _focusNodes;
   List<TextEditingController> _controllers=[];

  @override
  void initState() {
    super.initState();
_controllers = widget.controllers;
    _focusNodes = List.generate(6, (index) => FocusNode());
    _controllers = List.generate(6, (index) => TextEditingController());

    // Add listener to each controller to handle OTP input changes
    for (int i = 0; i < 6; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < 5) {
          _focusNodes[i + 1].requestFocus();
        } else if (_controllers[i].text.length == 0 && i > 0) {

          _focusNodes[i - 1].requestFocus();
        }
      });
    }
  }
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    for (var controller in _controllers) {
      controller.dispose();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
            (index) => Expanded(
              child: Container(
          margin: EdgeInsets.only(right: 8.0),
          width: 40.0,
          child: TextField(
            style: Styles.style_White(
              fontsize: 14,fontWeight: FontWeight.w400
            ),

              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: AppColor.secondaryBlackColor,
                filled: true,
                counterText: "",
                enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color:  Colors.white.withOpacity(0.2),
                        width: 1
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.2),
                        width: 1
                    )
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color:  Colors.white.withOpacity(0.2),
                        width: 1
                    )
                ),
              ),
              maxLength: 1,
              onChanged: (value) {
                // Handle the OTP input if needed
              },
          ),
        ),
            ),
      ),
    );
  }

}