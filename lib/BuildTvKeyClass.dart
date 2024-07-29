import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppImages.dart';

class BuildTvKey extends StatefulWidget {
  const BuildTvKey({Key? key}) : super(key: key);

  @override
  State<BuildTvKey> createState() => _BuildTvKeyState();
}

class _BuildTvKeyState extends State<BuildTvKey> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.commonBackgroundPath),fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}
