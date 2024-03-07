import 'package:flutter/material.dart';


class Sizes {
  final BuildContext context;
  Sizes(this.context);
  Size get size => MediaQuery.of(context).size;

  //Icon Sizes
  double get responsiveIconSize18 => size.width < size.height
      ? size.width * 0.05 // Adjust the factor as needed
      : size.height * 0.05;
  double get responsiveIconSize30 => size.width < size.height                   //size = 29.9
      ? size.width * 0.083
      : size.height * 0.083;
  double get responsiveIconSize54 => size.width < size.height
      ? size.width * 0.15 // Adjust the factor as needed
      : size.height * 0.15;


  //font Sizes
  double get responsiveFontSize16 => size.width < size.height
      ? size.width * 0.0444
      : size.height * 0.0444;
  double get responsiveFontSize17 => size.width < size.height
      ? size.width * 0.0472
      : size.height * 0.0472;
  double get responsiveFontSize18 => size.width < size.height
      ? size.width * 0.05
      : size.height * 0.05;
  double get responsiveFontSize20 => size.width < size.height                  //size = 20.2
      ? size.width * 0.056
      : size.height * 0.056;
  double get responsiveFontSize40 => size.width < size.height
      ? size.width * 0.111
      : size.height * 0.111;


  //Border Radius
  double get responsiveBorderRadius66 => size.width < size.height
      ? size.width * 0.1833 // Adjust the factor as needed
      : size.height * 0.1833;
  double get responsiveBorderRadius40 => size.width < size.height
      ? size.width * 0.111 // Adjust the factor as needed
      : size.height * 0.111;
  double get responsiveBorderRadius30 => size.width < size.height
      ? size.width * 0.0834
      : size.height * 0.0834;
  double get responsiveBorderRadius20 => size.width < size.height
      ? size.width * 0.0555
      : size.height * 0.0555;
  double get responsiveBorderRadius15 => size.width < size.height
      ? size.width * 0.0418 // Adjust the factor as needed
      : size.height * 0.0418;
  double get responsiveBorderRadius10 => size.width < size.height
      ? size.width * 0.0278 // Adjust the factor as needed
      : size.height * 0.0278;
  double get responsiveBorderRadius6 => size.width < size.height                //radius = 6.5
      ? size.width * 0.018
      : size.height * 0.018;


  //Images Radius
  double get responsiveImageRadius65 => size.width < size.height                //radius = 65.2
      ? size.width * 0.181
      : size.height * 0.181;
  double get responsiveImageRadius35 => size.width < size.height
      ? size.width * 0.0972
      : size.height * 0.0972;
  double get responsiveImageRadius30 => size.width < size.height
      ? size.width * 0.0834
      : size.height * 0.0834;
  double get responsiveImageRadius23 => size.width < size.height
      ? size.width * 0.064
      : size.height * 0.064;


  //Top, Bottom, Height, vertical
  double get height5 => size.height / 154;
  double get height7 => size.height / 98;                    //height = 7.7
  double get height10 => size.height / 77;
  double get height12 => size.height / 64.5;
  double get height15 => size.height / 51.5;
  double get height20 => size.height / 38.6;
  double get height26 => size.height / 29.7;
  double get height30 => size.height / 25;                   //height = 30.9
  double get height37 => size.height / 20.8;                 //height = 37.1
  double get height48 => size.height / 16;                   //height = 48.3
  double get height55 => size.height / 13.99;                //height = 55.2
  double get height90 => size.height / 8.57;                 //height = 90.1
  double get height100 => size.height / 7.72;
  double get height110 => size.height / 7;                   //height = 110.3
  double get height220 => size.height / 3.5;                 //height = 220.6
  double get height300 => size.height / 2.573;
  double get height510 => size.height / 1.513;               //height = 510.2
  double get height588 => size.height / 1.312;               //height = 588.4
  double get height677 => size.height / 1.139;               //height = 677.7


  //Left, Right, width, Horizontal
  double get width5 => size.width / 72;
  double get width8 => size.width / 45;
  double get width9 => size.width / 40;                     //width = 9
  double get width10 => size.width / 35.9;
  double get width12 => size.width / 30;
  double get width13 => size.width / 27.7;
  double get width20 => size.width / 18;
  double get width24 => size.width / 15;
  double get width100 => size.width / 3.6;
  double get width124 => size.width / 2.9;                  //width = 124.1
  double get width144 => size.width / 2.5;                  //width = 144
  double get width320 => size.width / 1.125;
}
