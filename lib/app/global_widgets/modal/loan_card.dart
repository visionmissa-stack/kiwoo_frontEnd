import 'package:flutter/material.dart';
import 'package:KIWOO/app/core/utils/formatters/extension.dart';
import 'package:get/get.dart';

import 'package:KIWOO/app/data/models/contact_list_model.dart';
import 'package:sizing/sizing_extension.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_utility.dart';
import '../../core/utils/image_name.dart';
import '../../core/utils/text_teme_helper.dart';
import '../avatar_network_image.dart';

class LoanCard extends GetView {
  const LoanCard({
    super.key,
    this.token,
    this.user,
    this.amount,
    this.interest,
    this.tenure,
    this.date,
    this.approvalStatus,
    this.onLoanStatus,
  });

  final String? token;
  final ContactData? user;
  final double? amount;
  final double? interest;
  final int? tenure;
  final DateTime? date;
  final String? approvalStatus;
  final Widget Function(String?)? onLoanStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.CARD_PRIMARY,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 5, 18.0, 18.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: user != null
                    ? AspectRatio(
                        aspectRatio: 8 / 8,
                        child: ClipOval(
                          child: avatarImage(
                            user?.avatar,
                            placeHolder: Center(
                              child: Image.asset(
                                ImgName.ELLIPSE_1,
                              ),
                            ),
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : null,
                trailing: date == null
                    ? null
                    : Text(
                        date!.since(),
                        style: TextThemeHelper.subTitleLR,
                      ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "${user?.name?.capitalize}",
                    style: TextThemeHelper.titleLR,
                  ),
                ),
                subtitle: Text.rich(
                  TextSpan(
                    text: "💰${amount ?? 0} EHTG",
                    style: TextThemeHelper.subTitleGreyLR,
                    children: <InlineSpan>[
                      TextSpan(
                        text: '\nLoan Status : ',
                        style: TextStyle(
                          fontSize: 13.fss,
                          color: FontColors.BLACK,
                        ),
                      ),
                      TextSpan(
                        text: (approvalStatus ?? "").capitalizeFirst,
                        style: TextStyle(
                          fontSize: 13.fss,
                          color: FontColors.RED,
                        ),
                      )
                    ],
                  ),
                ),
                isThreeLine: true,
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            verticalSpaceTiny,
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                children: [
                  Text("Interest", style: TextThemeHelper.subTitleGreyLR),
                  horizontalSpaceSmall,
                  Text("${interest ?? 0}%", style: TextThemeHelper.subTitleLR),
                  const Spacer(),
                  Text("Duration", style: TextThemeHelper.subTitleGreyLR),
                  horizontalSpaceSmall,
                  Text("${(tenure ?? 0)} month",
                      style: TextThemeHelper.subTitleLR),
                ],
              ),
            ),
            if (onLoanStatus != null) ...[
              verticalSpaceRegular,
              onLoanStatus!(approvalStatus)
            ]
          ],
        ),
      ),
    );
  }
}
