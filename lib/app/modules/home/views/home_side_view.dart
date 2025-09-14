import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeSideView extends GetView {
  const HomeSideView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeSideView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeSideView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
