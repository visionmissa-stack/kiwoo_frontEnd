// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'dart:convert';

import 'package:get/get_utils/get_utils.dart';

import 'package:kiwoo/app/core/utils/datetime_utility.dart';
import 'package:kiwoo/app/core/utils/enums.dart';

class TransactionModel {
  final int id;
  final TransactionType type;
  final TransactionMethod method;
  final TransactionStatus status;
  final Direction direction;
  final num amount;
  final num fees;
  final num tax;
  final DateTime created_at;
  String get txn => id.toString().padLeft(10, '0');
  num get totalAmount => amount + fees + tax;

  TransactionModel({
    required this.id,
    required this.type,
    required this.method,
    required this.status,
    required this.direction,
    required this.amount,
    required this.fees,
    required this.tax,
    required this.created_at,
  });

  static List<TransactionModel> fromList(List data) {
    return data.map((el) => TransactionModel.fromMap(el)).toList();
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int,
      type: TransactionType.fromMap(map['type']),
      method: TransactionMethod.fromMap(map['method']),
      status: TransactionStatus.fromMap(map['status']),
      direction: Direction.fromName(map['direction']),
      amount: map['amount'],
      fees: map['fees'] ?? 0,
      tax: map['tax'] ?? 0,
      created_at: DateTimeUtility.convertDateFromString(map['created_at']),
    );
  }

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  TransactionModel copyWith({
    int? id,
    TransactionType? type,
    TransactionMethod? method,
    TransactionStatus? status,
    Direction? direction,
    num? amount,
    num? fees,
    num? tax,
    DateTime? created_at,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      method: method ?? this.method,
      status: status ?? this.status,
      direction: direction ?? this.direction,
      amount: amount ?? this.amount,
      fees: fees ?? this.fees,
      tax: tax ?? this.tax,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.toMap(),
      'method': method.toMap(),
      'status': status.toMap(),
      'direction': direction.toMap(),
      'amount': amount,
      'fees': fees,
      'created_at': created_at.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  String getTitle() {
    final title = 'TRANSACTION_TITLE_${type.name}';
    var params = <String, String>{"method": method.name, "status": status.name};
    var directionText = '';
    print("the direction $id $direction");

    if (type == TransactionType.loan || type == TransactionType.transfer) {
      directionText = direction == Direction.inbound
          ? 'PASTTENSE_RECEIVED'
          : 'PASTTENSE_SENT';
    }
    params.addAll({"pasttense": directionText.tr});

    return title.trParams(params);
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, type: $type, method: $method, status: $status, direction: $direction, amount: $amount, fees: $fees, tax: $tax, created_at: $created_at)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.method == method &&
        other.status == status &&
        other.direction == direction &&
        other.amount == amount &&
        other.fees == fees &&
        other.tax == tax &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        method.hashCode ^
        status.hashCode ^
        direction.hashCode ^
        amount.hashCode ^
        fees.hashCode ^
        tax.hashCode ^
        created_at.hashCode;
  }
}
