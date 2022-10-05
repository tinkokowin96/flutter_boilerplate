import 'package:exceed_resources_frontend/app/modules/core/layout/desktop/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/layout/mobile/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/layout/tablet/index.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/helper.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final device = getDevice(context);
    switch (device) {
      case EDevice.mobile:
        return const MobileLayout();
      case EDevice.tablet:
        return const TabletLayout();
      default:
        return const DesktopLayout();
    }
  }
}
