import 'package:flutter/material.dart';

//  get phone screen height
double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//  get phone screen width

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//  get phone screen aspectRatio

double getScreenAspectRatio(BuildContext context) {
  return MediaQuery.of(context).size.aspectRatio;
}
