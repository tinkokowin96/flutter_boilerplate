import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/misc_controller.dart';

class MiscView extends GetView<MiscController> {
  const MiscView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiscView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MiscView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
