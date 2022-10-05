import 'package:exceed_resources_frontend/app/modules/core/utils/helper.dart';
import 'package:flutter/material.dart';

class AppSize {
  static const xs = 6.0;
  static const sm = 12.0;
  static const md = 24.0;
  static const lg = 48.0;

  //icon
  static const icoMd = 24.0;

  //button
  static const btnWMd = 100.0;
  static const btnHMd = 60.0;

  //popup

  //field
  static fWMd(BuildContext context) => App.width(context) * 0.8;
  static const fHMd = 74.0;

  //dropdown
  static const dH = 120.0;
  static const dL = 100.0; //dropdown loading
}
