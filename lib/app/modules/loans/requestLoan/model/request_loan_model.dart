// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:KIWOO/app/core/utils/formatters/extension.dart';

import '../../../../core/utils/enums.dart';

class RequestLoanModel {
  double amount;
  double interest;
  int tenure;
  List contacts;
  LoanLenderOptions lender;
  RequestLoanModel({
    this.amount = 0,
    this.interest = 0,
    this.tenure = 0,
    List contacts = const [],
    this.lender = LoanLenderOptions.loanMarket,
  }) : contacts = [...contacts];

  RequestLoanModel copyWith({
    double? amount,
    double? interest,
    int? tenure,
    List? contacts,
    LoanLenderOptions? lender,
  }) {
    return RequestLoanModel(
      amount: amount ?? this.amount,
      interest: interest ?? this.interest,
      tenure: tenure ?? this.tenure,
      contacts: contacts ?? this.contacts,
      lender: lender ?? this.lender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'interest': interest,
      'tenure': tenure,
      'contacts': contacts,
      'lender': lender.name.snakeCase,
    };
  }

  factory RequestLoanModel.fromMap(Map<String, dynamic> map) {
    return RequestLoanModel(
      amount: map['amount'] as double,
      interest: map['interest'] as double,
      tenure: map['tenure'] as int,
      contacts: List.from((map['contacts'] as List)),
      lender: LoanLenderOptions.values.firstWhere(
        (val) => val.name.snakeCase == map['lender'],
        orElse: () => LoanLenderOptions.loanMarket,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestLoanModel.fromJson(String source) =>
      RequestLoanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestLoanModel(amount: $amount, interest: $interest, tenure: $tenure, contacts: $contacts, lender: $lender)';
  }

  @override
  bool operator ==(covariant RequestLoanModel other) {
    if (identical(this, other)) return true;

    return other.amount == amount &&
        other.interest == interest &&
        other.tenure == tenure &&
        listEquals(other.contacts, contacts) &&
        other.lender == lender;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        interest.hashCode ^
        tenure.hashCode ^
        contacts.hashCode ^
        lender.hashCode;
  }
}
