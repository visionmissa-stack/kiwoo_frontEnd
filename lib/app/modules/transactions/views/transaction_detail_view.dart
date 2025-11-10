import 'package:kiwoo/app/core/utils/formatters/extension.dart';
import 'package:kiwoo/app/core/utils/kiwoo_icons.dart';
import 'package:kiwoo/app/global_widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwoo/app/global_widgets/input_field.dart';
import 'package:sizing/sizing_extension.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_utility.dart';
import '../../../core/utils/font_family.dart';
import '../../../core/utils/text_style.dart';
import '../../../data/models/payment_receipt_model.dart';
import '../../../global_widgets/app_button.dart';
import '../../../global_widgets/list_builder_widget.dart';
import '../../../global_widgets/mini_widgets.dart' show rowItem, columnItems;
import '../controllers/transactions_controller.dart';

class TransactionDetailView extends GetView<TransactionsController> {
  const TransactionDetailView({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final containData = false.obs;
    return Scaffold(
      appBar: AppBarWidgetTitle(title: 'Transactio Details', height: 50),
      floatingActionButton: Row(
        spacing: 5,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: "shareReceipt",
            icon: Icon(Icons.share),
            label: Text('Share'),
            onPressed: () {},
          ),
          FloatingActionButton.extended(
            heroTag: "downloadReceipt",
            icon: Icon(Icons.download),
            label: Text('Download'),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
        child: FutureDataBuilder<PaymentReceiptData>(
          isEmpty: (p0) => p0 == null,
          autoAddScroll: true,

          future: () {
            return controller.getTransactionDetail(id).then((val) {
              if (val != null) {
                containData.value = true;
              }
              return val;
            });
          },
          futureBuilder: (context, item, _) {
            return Column(
              spacing: 15,
              mainAxisSize: MainAxisSize.min,
              children: [
                //header
                verticalSpaceSmall,
                CircleAvatar(
                  radius: 0.1.sw,

                  backgroundColor: item.status.color,
                  child: Icon(item.status.icon, size: .1.sw),
                ),
                Text(item.getTitle(), style: titleDetailStyle),
                Card(
                  child: columnItems(
                    children: [
                      rowItem(
                        title: "Transaction Amount",
                        value: item.totalAmount.toEGTH,
                        valueStyle: titleDetailStyle.copyWith(
                          fontSize: 18.fss,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(color: Colors.grey),
                      rowItem(
                        title: "Txn: ${item.txn}",
                        value: item.created_at.format("HH:mm dd/MM/yyyy"),
                      ),
                    ],
                  ),
                ),

                Card(
                  child: columnItems(
                    children: [
                      Text(
                        "Transaction Details".toUpperCase(),
                        style: titleDetailStyle.copyWith(
                          fontSize: 18.fss,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      rowItem(
                        title: "directionTypeName_${item.direction.name}"
                            .trArgs(["name".tr]),
                        value: item.contact.name ?? '',
                      ),
                      rowItem(
                        title: "directionTypeName_${item.direction.name}"
                            .trArgs(["phone".tr]),
                        value: item.contact.phone ?? '',
                      ),
                      rowItem(
                        title: "Type",
                        value: item.type.name.toUpperCase(),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: columnItems(
                    children: [
                      Text(
                        "Payment Details".toUpperCase(),
                        style: titleDetailStyle.copyWith(
                          fontSize: 18.fss,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      rowItem(title: "amount", value: item.amount.toEGTH),
                      rowItem(
                        title: "fees & tax",
                        value: (item.fees + item.tax).toEGTH,
                      ),
                      rowItem(
                        title: "total Amount",
                        value: item.totalAmount.toEGTH,
                      ),
                    ],
                  ),
                ),
                Card(
                  child: columnItems(
                    children: [
                      Text(
                        "Payment Details".toUpperCase(),
                        style: titleDetailStyle.copyWith(
                          fontSize: 18.fss,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      rowItem(
                        title: item.created_at.format("dd-MMM-yyyy"),
                        value: item.status.name,
                        valueStyle: titleDetailStyle.copyWith(
                          color: item.status.color,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
              ],
            );
          },
        ),
      ),
    );
  }
}
