// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:get/get.dart';

import 'package:kiwoo/app/core/utils/enums.dart';

import '../../core/utils/dateTime_Utility.dart';

class LedgerModel {
  final String id;
  final double amount;
  final String currency;
  final double conversionRate;
  final double fee;
  final TransactionStatus status;
  final TransactionType type;
  final TransactionMethod method;
  final DateTime createdAt;
  final DateTime updatedAt;

  LedgerModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.conversionRate,
    required this.fee,
    required this.status,
    required this.type,
    required this.method,
    required this.createdAt,
    required this.updatedAt,
  });

  LedgerModel copyWith({
    String? id,
    double? amount,
    String? currency,
    double? conversionRate,
    double? fee,
    TransactionStatus? status,
    TransactionType? type,
    TransactionMethod? method,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LedgerModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      conversionRate: conversionRate ?? this.conversionRate,
      fee: fee ?? this.fee,
      status: status ?? this.status,
      type: type ?? this.type,
      method: method ?? this.method,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'currency': currency,
      'conversionRate': conversionRate,
      'fee': fee,
      'status': status.toMap(),
      'type': type.toMap(),
      'method': method.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory LedgerModel.fromMap(Map<String, dynamic> map) {
    return LedgerModel(
      id: map['id'] as String,
      amount: double.parse('${map['amount']}'),
      currency: map['currency'] as String,
      conversionRate: double.parse('${map['conversion_rate']}'),
      fee: double.parse('${map['fee']}'),
      status: TransactionStatus.fromMap(map['status']),
      type: TransactionType.fromMap(map['type']),
      method: TransactionMethod.fromMap(map['method']),
      createdAt: DateTimeUtility.convertDateFromString(map['created_at']),
      updatedAt: DateTimeUtility.convertDateFromString(map['updated_at']),
    );
  }

  static List<LedgerModel> fromList(List data) {
    return data.map((el) => LedgerModel.fromMap(el)).toList();
  }

  Map<String, String> getTitle(Direction direction) {
    final method = this.method.name.capitalize!;
    final type = this.type.name.toUpperCase();
    final titleLockKey = 'NOTIFICATION_TITLE_$type';
    final bodyLockKey = 'NOTIFICATION_BODY_$type';
    return {
      'title': titleLockKey.trArgs([method]),
      'body': bodyLockKey.trArgs([
        "transactionStatus_.adverbe_${status.name}".tr,
        method,
      ]),
    };
  }

  String toJson() => json.encode(toMap());

  factory LedgerModel.fromJson(String source) =>
      LedgerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LedgerModel(id: $id, amount: $amount, currency: $currency, conversionRate: $conversionRate, fee: $fee, status: $status, type: $type, method: $method, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant LedgerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.currency == currency &&
        other.conversionRate == conversionRate &&
        other.fee == fee &&
        other.status == status &&
        other.type == type &&
        other.method == method &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        conversionRate.hashCode ^
        fee.hashCode ^
        status.hashCode ^
        type.hashCode ^
        method.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
