import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SuccessView extends GetView {
  const SuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SuccessView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SuccessView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
