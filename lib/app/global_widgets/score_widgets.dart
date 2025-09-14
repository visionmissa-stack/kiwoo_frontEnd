import 'package:flutter/widgets.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_utility.dart';
import '../core/utils/font_family.dart';
import '../modules/home/controllers/functions.dart';
import 'progress_indicator.dart';

Widget creditDataWidget(int? score) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Text(
            "${score ?? 0}",
            style: TextStyle(
              fontSize: 24.fss,
              fontFamily: FontPoppins.SEMIBOLD,
            ),
          ),
          verticalSpaceTiny,
          Container(
            padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
            decoration: BoxDecoration(
              color: AppColors.PRIMARY_BG,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              categorizeCreditScore(score ?? 0),
              style: TextStyle(
                fontSize: 11.fss,
                fontFamily: FontPoppins.SEMIBOLD,
                color: FontColors.PRIMARY1,
              ),
            ),
          )
        ],
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 4, left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Credit Score",
                style: TextStyle(
                  color: FontColors.GREY,
                  fontSize: 15.fss,
                ),
              ),

              LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: CreditScoreProgressBar(
                      creditScore: score ?? 0,
                      containerWidth: constraints.maxWidth,
                    ),
                  );
                },
              ),
              // Center(
              //   child: CreditScoreProgressBar(creditScore: 720 ),
              // ),
            ],
          ),
        ),
      ),
    ],
  );
}
