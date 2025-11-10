// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'dart:convert';

import 'package:get/get.dart';

import 'package:kiwoo/app/core/utils/enums.dart';

import '../../core/utils/datetime_utility.dart';
import 'contact_list_model.dart';
import 'transaction_model.dart';

class PaymentReceiptData extends TransactionModel {
  final ContactData contact;
  PaymentReceiptData({
    required super.id,
    required super.status,
    required super.method,
    required super.type,
    required super.amount,
    required super.created_at,
    required super.fees,
    required super.tax,
    required this.contact,
    required super.direction,
  });

  @override
  PaymentReceiptData copyWith({
    int? id,
    TransactionType? type,
    TransactionMethod? method,
    TransactionStatus? status,
    Direction? direction,
    num? amount,
    num? fees,
    num? tax,
    ContactData? contact,
    DateTime? created_at,
  }) {
    return PaymentReceiptData(
      id: id ?? this.id,
      status: status ?? this.status,
      method: method ?? this.method,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      fees: fees ?? this.fees,
      direction: direction ?? this.direction,
      tax: tax ?? this.tax,
      contact: contact ?? this.contact,
      created_at: created_at ?? this.created_at,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'fees': fees,
      'tax': tax,
      'status': status.toMap(),
      'method': method.toMap(),
      'type': type.toMap(),
      'direction': direction.toMap(),
      'contact': contact.toMap(),
      'created_at': created_at.toIso8601String(),
    };
  }

  factory PaymentReceiptData.fromMap(Map<String, dynamic> map) {
    var direction = Direction.fromName(map['direction']);
    var contactKey = direction == Direction.inbound ? 'sender' : 'receiver';

    return PaymentReceiptData(
      id: map['id'] as int,
      type: TransactionType.fromMap(map['type']),
      direction: direction,
      method: TransactionMethod.fromMap(map['method']),
      status: TransactionStatus.fromMap(map['status']),
      amount: double.tryParse("${map['amount']}") ?? 0,
      fees: double.tryParse("${map['fees']}") ?? 0,
      tax: double.tryParse("${map['tax']}") ?? 0,
      contact: map[contactKey] == null
          ? ContactData()
          : ContactData.fromMap(map[contactKey] as Map<String, dynamic>),

      created_at: DateTimeUtility.convertDateFromString(map['created_at']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory PaymentReceiptData.fromJson(String source) =>
      PaymentReceiptData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentReceiptData(id: $id, status: $status, method: $method, direction: $direction, type: $type, amount: $amount, fees: $fees, tax: $tax, contact: $contact,  created_at: $created_at)';
  }

  @override
  bool operator ==(covariant PaymentReceiptData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.status == status &&
        other.method == method &&
        other.type == type &&
        other.direction == direction &&
        other.amount == amount &&
        other.fees == fees &&
        other.tax == tax &&
        other.contact == contact &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        method.hashCode ^
        type.hashCode ^
        direction.hashCode ^
        type.hashCode ^
        amount.hashCode ^
        fees.hashCode ^
        tax.hashCode ^
        contact.hashCode ^
        created_at.hashCode;
  }
}
