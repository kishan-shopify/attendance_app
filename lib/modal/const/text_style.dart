import 'package:flutter/material.dart';
import 'const_color.dart';

String fontFamily = 'Poppins';

TextStyle textStyleRegular(double size,Color color){
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: size,
      color: color
  );
}

TextStyle textStyleW400(double size,Color color){
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: size,
      color: color
  );
}

TextStyle textStyleW400TO(double size, TextOverflow textOverflow){
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: size,
      color: ConstColor.blackText,
      overflow: textOverflow
  );
}

TextStyle textStyleW500(double size,Color color){
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: size,
      color: color
  );
}

TextStyle textStyleW500TO(double size, TextOverflow textOverflow){
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: size,
      color: ConstColor.blackText,
      overflow: textOverflow
  );
}

TextStyle textStyleW600(double size,Color color){
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: size,
      color: color
  );
}

TextStyle textStyleW600L(Color color,double size){
  return TextStyle(
      letterSpacing: 1.5,
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: color
  );
}

TextStyle textStyleW600U(double size, Color color){
  return TextStyle(
      fontFamily: fontFamily,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.w600,
      fontSize: size,
      color: color
  );
}

TextStyle textStyleW600TO(double size, TextOverflow textOverflow){
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: size,
      color: ConstColor.blackText,
      overflow: textOverflow
  );
}

TextStyle textStyleW700(double size,Color color){
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,

      fontSize: size,
      color: color
  );
}

TextStyle customFontWeight(double size,FontWeight fontWeight,double opacity){
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: size,
      color: ConstColor.blackText.withOpacity(opacity)
  );
}