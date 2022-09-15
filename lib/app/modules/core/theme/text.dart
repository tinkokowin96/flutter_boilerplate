import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:flutter/material.dart';

class AppText {
  final TextStyle Function({
    required BuildContext context,
    EText type,
    int weight,
    String fontFamily,
  }) h1;
  final TextStyle Function({
    required BuildContext context,
    EText type,
    int weight,
    String fontFamily,
  }) h3;
  final TextStyle Function({
    required BuildContext context,
    EText type,
    int weight,
    String fontFamily,
  }) h4;
  final TextStyle Function({
    required BuildContext context,
    EText type,
    int weight,
    String fontFamily,
  }) h5;

  const AppText({
    required this.h1,
    required this.h3,
    required this.h4,
    required this.h5,
  });
}
