import 'package:flutter/material.dart';
import 'package:KIWOO/app/core/utils/font_family.dart';
import 'package:sizing/sizing.dart';

import '../../../core/utils/app_colors.dart';

class ConnectionLost extends StatelessWidget {
  const ConnectionLost({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.network_locked,
            size: 230.ss,
          ),
          SizedBox(height: 15.ss),
          Text(
            "Internet\n Connection Lost",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28.ss,
                fontFamily: FontPoppins.LIGHT,
                color: FontColors.GREY),
          )
        ],
      ),
    );
  }
}
