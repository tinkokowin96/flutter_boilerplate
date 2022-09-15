import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:flutter/material.dart';

EDevice getDevice(BuildContext context) => MediaQuery.of(context).size.width <= 576
    ? EDevice.mobile
    : MediaQuery.of(context).size.width <= 768
        ? EDevice.tablet
        : EDevice.desktop;
