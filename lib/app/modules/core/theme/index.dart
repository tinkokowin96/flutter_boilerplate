import 'package:exceed_resources_frontend/app/modules/core/lang/locale.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/color.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/text.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/helper.dart';
import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  final AppColor color = AppThemeData.currentTheme.color;
  final AppText text = AppThemeData.currentTheme.text;

  AppTheme({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static AppTheme of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    if (theme != null) {
      return theme;
    } else {
      throw StateError('Could not find ancestor widget of type `AppTheme`');
    }
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) => true;
}

class AppThemeData extends ChangeNotifier {
  final AppText text;
  final AppColor color;

  AppThemeData({required this.text, required this.color});

  static bool isDarkTheme = true;
  static AppThemeData currentTheme = darkTheme;

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    if (isDarkTheme) {
      currentTheme = darkTheme;
    } else {
      currentTheme = lightTheme;
    }
    notifyListeners();
  }

  static AppThemeData lightTheme = AppThemeData(
    text: AppText(
      h1: ({
        required BuildContext context,
        type = EText.body,
        weight = 400,
        fontFamily = 'Barlow',
      }) =>
          TextStyle(
        color: getTextColor(type, context),
        fontSize: getDevice(context) == EDevice.mobile
            ? 18
            : getDevice(context) == EDevice.tablet
                ? 20
                : 22,
        fontFamily: AppLocale.locale.languageCode == 'my' ? 'Notosan' : fontFamily,
      ),
      h3: ({
        required BuildContext context,
        type = EText.body,
        weight = 400,
        fontFamily = 'Barlow',
      }) =>
          TextStyle(
        color: getTextColor(type, context),
        fontSize: getDevice(context) == EDevice.mobile
            ? 14
            : getDevice(context) == EDevice.tablet
                ? 16
                : 18,
        fontFamily: AppLocale.locale.languageCode == 'my' ? 'Notosan' : fontFamily,
      ),
      h4: ({
        required BuildContext context,
        type = EText.body,
        weight = 400,
        fontFamily = 'Barlow',
      }) =>
          TextStyle(
        color: getTextColor(type, context),
        fontSize: getDevice(context) == EDevice.mobile
            ? 12
            : getDevice(context) == EDevice.tablet
                ? 14
                : 16,
        fontFamily: AppLocale.locale.languageCode == 'my' ? 'Notosan' : fontFamily,
      ),
      h5: ({
        required BuildContext context,
        type = EText.body,
        weight = 400,
        fontFamily = 'Barlow',
      }) =>
          TextStyle(
        color: getTextColor(type, context),
        fontSize: getDevice(context) == EDevice.mobile
            ? 10
            : getDevice(context) == EDevice.tablet
                ? 12
                : 14,
        fontFamily: AppLocale.locale.languageCode == 'my' ? 'Notosan' : fontFamily,
      ),
    ),
    color: const AppColor(
      primary: Color(0xFFE38B29),
      subtitle: Color(0xFF565656),
      container: Color(0xFFFAFAFA),
      error: Color(0xFFD1512D),
      background: Colors.white,
      disabled: Color(0xFF898989),
    ),
  );

  static AppThemeData darkTheme = AppThemeData(
    text: AppText(
      h1: ({
        required BuildContext context,
        type = EText.body,
        weight = 400,
        fontFamily = 'Barlow',
      }) =>
          TextStyle(
        color: getTextColor(type, context),
        fontSize: getDevice(context) == EDevice.mobile
            ? 18
            : getDevice(context) == EDevice.tablet
                ? 20
                : 22,
        fontFamily: AppLocale.locale.languageCode == 'my' ? 'Notosan' : fontFamily,
      ),
      h3: ({
        required BuildContext context,
        type = EText.body,
        weight = 400,
        fontFamily = 'Barlow',
      }) =>
          TextStyle(
        color: getTextColor(type, context),
        fontSize: getDevice(context) == EDevice.mobile
            ? 14
            : getDevice(context) == EDevice.tablet
                ? 16
                : 18,
        fontFamily: AppLocale.locale.languageCode == 'my' ? 'Notosan' : fontFamily,
      ),
      h4: ({
        required BuildContext context,
        type = EText.body,
        weight = 400,
        fontFamily = 'Barlow',
      }) =>
          TextStyle(
        color: getTextColor(type, context),
        fontSize: getDevice(context) == EDevice.mobile
            ? 12
            : getDevice(context) == EDevice.tablet
                ? 14
                : 16,
        fontFamily: AppLocale.locale.languageCode == 'my' ? 'Notosan' : fontFamily,
      ),
      h5: ({
        required BuildContext context,
        type = EText.body,
        weight = 400,
        fontFamily = 'Barlow',
      }) =>
          TextStyle(
        color: getTextColor(type, context),
        fontSize: getDevice(context) == EDevice.mobile
            ? 10
            : getDevice(context) == EDevice.tablet
                ? 12
                : 14,
        fontFamily: AppLocale.locale.languageCode == 'my' ? 'Notosan' : fontFamily,
      ),
    ),
    color: const AppColor(
      primary: Color(0xFFE38B29),
      subtitle: Color(0xFF565656),
      container: Color(0xFFFAFAFA),
      error: Color(0xFFD1512D),
      background: Color(0xFF202123),
      disabled: Color(0xFF898989),
    ),
  );
}
