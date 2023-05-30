import 'package:flutter/material.dart';

import '../const/const_image.dart';

class CustomBackButton extends StatelessWidget {
  final Function onTap;
  final Color iconColor;
  const CustomBackButton({Key? key, required this.onTap, required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Image.asset(
        ConstImage.arrowBack,
        height: 30,
        width: 30,
        color: iconColor,
      ),


    );
  }
}
