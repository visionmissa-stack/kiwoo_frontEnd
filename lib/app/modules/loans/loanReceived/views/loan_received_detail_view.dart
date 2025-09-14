import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoanReceivedDetailView extends GetView {
  const LoanReceivedDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoanReceivedDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LoanReceivedDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
