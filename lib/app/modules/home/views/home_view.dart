import 'package:exceed_resources_frontend/app/modules/core/lang/locale.dart';
import 'package:exceed_resources_frontend/app/modules/core/theme/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'welcome'.tr,
              style: AppTheme.of(context).text.h1(context: context),
            ),
            TextButton(onPressed: () => currentTheme.toggleTheme(), child: Text('change theme')),
            TextButton(
              onPressed: () => locale.changeLocale(
                AppLocale.locale.toString() == 'my_MM' ? 'en' : 'my',
                AppLocale.locale.toString() == 'my_MM' ? 'US' : 'MM',
              ),
              child: Text('change language'),
            ),
          ],
        ),
      ),
    );
  }
}
