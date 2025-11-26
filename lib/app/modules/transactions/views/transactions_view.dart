import 'package:kiwoo/app/core/utils/app_colors.dart';
import 'package:kiwoo/app/core/utils/app_string.dart';
import 'package:kiwoo/app/core/utils/enums.dart';
import 'package:kiwoo/app/core/utils/formatters/extension.dart';
import 'package:kiwoo/app/core/utils/formatters/format_number.dart';
import 'package:kiwoo/app/global_widgets/app_bar.dart';
import 'package:kiwoo/app/global_widgets/list_builder_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../core/utils/font_family.dart';
import '../../../data/models/transaction_model.dart';
import '../controllers/transactions_controller.dart';
import 'transaction_detail_view.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});
  @override
  Widget build(BuildContext context) {
    DateTime? lastCreate;
    return Scaffold(
      appBar: const AppBarWidgetTitle(title: AppStrings.TRANSACTIONS),
      body: ListBuilderWidget<TransactionModel>.future(
        future: controller.futureRequest,

        // separatorBuilder: (p0, p1, item) {
        //   return Text(item.createdAt.since());
        // },
        itemBuilder: (p0, item, _, [previous]) {
          var icon = Icons.arrow_downward;
          final direction = item.direction;
          if (direction == Direction.outbound) {
            icon = Icons.arrow_upward;
          }
          var dataText = item.getTitle();
          lastCreate = previous?.created_at;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (lastCreate == null ||
                  lastCreate!.difference(item.created_at).inDays.abs() > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 0),
                  child: Text(
                    item.created_at.format("dd MMM, yyyy"),
                    style: TextStyle(
                      fontSize: 18.fss,
                      color: const Color(0xFF1A1A1A),
                      fontFamily: FontPoppins.MEDIUM,
                    ),
                  ),
                ),
              Card(
                child: ListTile(
                  onTap: () => Get.to(() => TransactionDetailView(id: item.id)),
                  isThreeLine: true,
                  // dense: true,
                  leading: AspectRatio(
                    aspectRatio: 0.6,
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: AppColors.PRIMARY,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            foregroundColor: AppColors.PRIMARY,
                            child: Icon(icon),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(dataText),
                  subtitle: Text("txn: ${item.txn}"),
                  // minTileHeight: 15,
                  titleTextStyle: TextStyle(
                    fontSize: 16.fss,
                    color: const Color(0xFF1A1A1A),
                    fontFamily: FontPoppins.MEDIUM,
                  ),
                  subtitleTextStyle: TextStyle(
                    fontSize: 14.fss,
                    color: const Color(0xFF7A7A7A),
                    fontFamily: FontPoppins.REGULAR,
                  ),
                  trailing: Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          spacing: 5,
                          children: [
                            Text(
                              (item.fees + item.amount).formatNumberCompact,
                              style: TextStyle(
                                fontSize: 14.fss,
                                color: const Color(0xFF1A1A1A),
                                fontFamily: FontPoppins.BOLD,
                              ),
                            ),
                            Text(
                              toEGTHCurrency().currencySymbol,
                              style: TextStyle(
                                fontSize: 14.fss,
                                color: const Color(0xFF1A1A1A),
                                fontFamily: FontPoppins.BOLD,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: item.status.color.withAlpha(50),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            "transactionStatus_${item.status.name}".tr,
                            style: TextStyle(
                              fontSize: 12.fss,
                              color: item.status.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String data(List<TransactionModel> data, int index) {
    return index.toString();
  }
}
