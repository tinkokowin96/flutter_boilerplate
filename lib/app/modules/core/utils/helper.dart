import 'package:exceed_resources_frontend/app/modules/core/theme/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:flutter/material.dart';

EDevice getDevice(BuildContext context) => MediaQuery.of(context).size.width <= 576
    ? EDevice.mobile
    : MediaQuery.of(context).size.width <= 768
        ? EDevice.tablet
        : EDevice.desktop;

Color getTextColor(ETextType type, BuildContext context) {
  switch (type) {
    case ETextType.error:
      return AppTheme.of(context).color.error;

    case ETextType.primary:
      return AppTheme.of(context).color.primary;

    case ETextType.white:
      return Colors.white;

    case ETextType.subtitle:
      return AppTheme.of(context).color.subtitle;

    default:
      //   return Colors.black;
      return AppTheme.of(context).isDarkTheme ? Colors.white : Colors.black;
  }
}

double getFontSize(EText size, BuildContext context) {
  final device = getDevice(context);

  switch (size) {
    case EText.h1:
      return device == EDevice.mobile
          ? 18
          : device == EDevice.tablet
              ? 20
              : 22;
    case EText.h2:
      return device == EDevice.mobile
          ? 16
          : device == EDevice.tablet
              ? 18
              : 20;
    case EText.h3:
      return device == EDevice.mobile
          ? 14
          : device == EDevice.tablet
              ? 16
              : 18;
    case EText.h5:
      return device == EDevice.mobile
          ? 12
          : device == EDevice.tablet
              ? 14
              : 16;
    default:
      return device == EDevice.mobile
          ? 10
          : device == EDevice.tablet
              ? 12
              : 14;
  }
}

class App {
  static width(BuildContext context) => MediaQuery.of(context).size.width;
  static height(BuildContext context) => MediaQuery.of(context).size.height;
}
