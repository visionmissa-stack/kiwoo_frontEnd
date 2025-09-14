// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../../core/utils/datetime_utility.dart';
import 'contact_list_model.dart';

class PaymentReceiptData {
  final int id;
  final double amount;
  final double fees;
  final double tax;
  final ContactData senderInfo;
  final ContactData receiverInfo;
  final DateTime createdAt;
  PaymentReceiptData({
    required this.id,
    required this.amount,
    required this.fees,
    required this.tax,
    required this.senderInfo,
    required this.receiverInfo,
    required this.createdAt,
  });

  PaymentReceiptData copyWith({
    int? id,
    double? amount,
    double? fees,
    double? tax,
    ContactData? senderInfo,
    ContactData? receiverInfo,
    DateTime? createdAt,
  }) {
    return PaymentReceiptData(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        fees: fees ?? this.fees,
        tax: tax ?? this.tax,
        senderInfo: senderInfo ?? this.senderInfo,
        receiverInfo: receiverInfo ?? this.receiverInfo,
        createdAt: createdAt ?? this.createdAt);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'fees': fees,
      'tax': tax,
      'senderInfo': senderInfo.toMap(),
      'receiverInfo': receiverInfo.toMap(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory PaymentReceiptData.fromMap(Map<String, dynamic> map) {
    return PaymentReceiptData(
      id: map['id'] as int,
      amount: double.tryParse("${map['amount']}") ?? 0,
      fees: double.tryParse("${map['fees']}") ?? 0,
      tax: double.tryParse("${map['tax']}") ?? 0,
      senderInfo:
          ContactData.fromMap(map['senderInfo'] as Map<String, dynamic>),
      receiverInfo:
          ContactData.fromMap(map['receiverInfo'] as Map<String, dynamic>),
      createdAt: DateTimeUtility.convertDateFromString(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentReceiptData.fromJson(String source) =>
      PaymentReceiptData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentReceiptData(id: $id, amount: $amount, fees: $fees, tax: $tax, senderInfo: $senderInfo, receiverInfo: $receiverInfo, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant PaymentReceiptData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.fees == fees &&
        other.tax == tax &&
        other.senderInfo == senderInfo &&
        other.receiverInfo == receiverInfo &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        fees.hashCode ^
        tax.hashCode ^
        senderInfo.hashCode ^
        receiverInfo.hashCode ^
        createdAt.hashCode;
  }
}
