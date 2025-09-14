import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/custom_in_app_browser_controller.dart';

class CustomInAppBrowserView extends GetView<CustomInAppBrowserController> {
  const CustomInAppBrowserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomInAppBrowserView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CustomInAppBrowserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
