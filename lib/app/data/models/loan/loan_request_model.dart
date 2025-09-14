// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:KIWOO/app/core/utils/datetime_utility.dart';

import '../../../core/utils/enums.dart' show LoanStatus;
import '../contact_list_model.dart';
import 'loan_offers_model.dart';

List<LoanRequestModel> listLoanRequestModelFromMap(List data) {
  return data.map((el) => LoanRequestModel.fromMap(el)).toList();
}

class LoanRequestModel {
  int? id;
  double? amount;
  double? interest;
  int? tenure;
  String? lender;
  LoanStatus? status;
  DateTime? nextDue;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  final ContactData? user;
  final List<LoanOfferModel>? contacts;

  LoanOfferModel? get offer => contacts?.firstOrNull;

  bool isSelected = false;
  LoanRequestModel({
    this.id,
    this.amount,
    this.interest,
    this.tenure,
    this.lender,
    this.status,
    this.nextDue,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.contacts,
    required this.isSelected,
  });

  LoanRequestModel copyWith({
    int? id,
    double? amount,
    double? interest,
    int? tenure,
    String? lender,
    LoanStatus? status,
    DateTime? nextDue,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSelected,
    ContactData? user,
    List<LoanOfferModel>? contacts,
  }) {
    return LoanRequestModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      interest: interest ?? this.interest,
      tenure: tenure ?? this.tenure,
      lender: lender ?? this.lender,
      status: status ?? this.status,
      nextDue: nextDue ?? this.nextDue,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      contacts: contacts ?? this.contacts,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory LoanRequestModel.fromMap(Map<String, dynamic> map) {
    return LoanRequestModel(
      id: map['id'] != null ? map['id'] as int : null,
      amount:
          map['amount'] != null ? double.tryParse("${map['amount']}") : null,
      interest: map['interest'] != null
          ? double.tryParse("${map['interest']}")
          : null,
      tenure: map['tenure'] != null ? map['tenure'] as int : null,
      lender: map['lender'] != null ? map['lender'] as String : null,
      status: map['status'] != null ? LoanStatus.fromMap(map['status']) : null,
      nextDue: map['next_due'] != null
          ? DateTimeUtility.convertDateFromString(map['next_due'])
          : null,
      userId: map['user_id'] != null ? map['user_id'] as int : null,
      createdAt: map['created_at'] != null
          ? DateTimeUtility.convertDateFromString(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTimeUtility.convertDateFromString(map['updated_at'])
          : null,
      user: map['user'] != null ? ContactData.fromMap((map['user'])) : null,
      contacts: map['contacts'] != null
          ? listOfferFromListMap(map['contacts'])
          : null,
      isSelected: false,
    );
  }

  factory LoanRequestModel.fromJson(String source) =>
      LoanRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoanRequestModel(id: $id, amount: $amount, interest: $interest, tenure: $tenure, lender: $lender, status: $status, nextDue: $nextDue, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, isSelected: $isSelected, user: $user, contacts: $contacts)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'interest': interest,
      'tenure': tenure,
      'lender': lender,
      'status': status?.name,
      'next_due': nextDue?.millisecondsSinceEpoch,
      'user_id': userId,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'user': user?.toMap(),
      'contacts': contacts?.map((el) => el.toMap()),
      'isSelected': isSelected,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(covariant LoanRequestModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.interest == interest &&
        other.tenure == tenure &&
        other.lender == lender &&
        other.status == status &&
        other.nextDue == nextDue &&
        other.userId == userId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.user == user &&
        listEquals(other.contacts, contacts) &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        interest.hashCode ^
        tenure.hashCode ^
        lender.hashCode ^
        status.hashCode ^
        nextDue.hashCode ^
        userId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        user.hashCode ^
        contacts.hashCode ^
        isSelected.hashCode;
  }
}
