import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/app_info_controller.dart';

class KiwooView extends GetView<AppInfoController> {
  const KiwooView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KiwooView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KiwooView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
