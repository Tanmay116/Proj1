// import 'package:flutter/material.dart';

// class SizeConfig {
//   double? width;

//   void init(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     double orientation = MediaQuery.of(context).size.aspectRatio;
//     double defaultSize =
//         check_orientation(orientation) ? height * 0.024 : width * 0.024;
//   }
// }

// bool check_orientation(orientation) {
//   if (orientation > 1) {
//     return true;
//   } else {
//     return false;
//   }
// }