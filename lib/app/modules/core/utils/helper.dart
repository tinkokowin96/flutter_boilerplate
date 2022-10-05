import 'package:exceed_resources_frontend/app/modules/core/theme/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:flutter/material.dart';

EDevice getDevice(BuildContext context) => MediaQuery.of(context).size.width <= 576
    ? EDevice.mobile
    : MediaQuery.of(context).size.width <= 768
        ? EDevice.tablet
        : EDevice.desktop;

Color getTextColor(EText type, BuildContext context) {
  switch (type) {
    case EText.error:
      return AppTheme.of(context).color.error;

    case EText.primary:
      return AppTheme.of(context).color.primary;

    case EText.white:
      return Colors.white;

    case EText.subtitle:
      return AppTheme.of(context).color.subtitle;

    default:
      return Colors.black;
  }
}

class App {
  static width(BuildContext context) => MediaQuery.of(context).size.width;
  static height(BuildContext context) => MediaQuery.of(context).size.height;
}
