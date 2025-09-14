import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cashout_controller.dart';

class CashoutView extends GetView<CashoutController> {
  const CashoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CashoutView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CashoutView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
