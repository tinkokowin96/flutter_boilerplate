import 'package:exceed_resources_frontend/app/modules/core/lang/locale.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/color.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/helper.dart';
import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  final AppColor color = AppThemeData.currentTheme.color;
  final bool isDarkTheme = AppThemeData.isDarkTheme;

  static TextStyle text({
    required BuildContext context,
    size = EText.h3,
    type = ETextType.body,
    weight = 400,
    fontFamily = 'Barlow',
  }) =>
      TextStyle(
        color: getTextColor(type, context),
        fontSize: getFontSize(size, context),
        fontFamily: AppLocale.locale.languageCode == 'my' ? 'Notosan' : fontFamily,
      );

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
  final AppColor color;

  AppThemeData({required this.color});

  static bool isDarkTheme = false;
  static AppThemeData currentTheme = lightTheme;

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
