// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../core/utils/datetime_utility.dart';
import '../../../core/utils/enums.dart';
import '../contact_list_model.dart';
import 'loan_request_model.dart';

List<LoanOfferModel> listOfferFromListMap(List data) {
  var dataResult = <LoanOfferModel>[];
  for (var el in data) {
    dataResult.add(LoanOfferModel.fromMap(el));
  }
  return dataResult;
}

class LoanOfferModel {
  int? id;
  double? offeredInterest;
  int? offeredTenure;
  LoanApprovalStatus? approvalStatus;
  int? loanId;
  int? contactId;
  DateTime? createdAt;
  DateTime? updatedAt;
  ContactData? contact;
  LoanRequestModel? loan;

  LoanOfferModel({
    this.id,
    this.offeredInterest,
    this.offeredTenure,
    this.approvalStatus,
    this.loanId,
    this.contactId,
    this.createdAt,
    this.updatedAt,
    this.contact,
    this.loan,
  });

  LoanOfferModel copyWith({
    int? id,
    double? offeredInterest,
    int? offeredTenure,
    LoanApprovalStatus? approvalStatus,
    int? loanId,
    int? contactId,
    DateTime? createdAt,
    DateTime? updatedAt,
    ContactData? contact,
    LoanRequestModel? loan,
  }) {
    return LoanOfferModel(
      id: id ?? this.id,
      offeredInterest: offeredInterest ?? this.offeredInterest,
      offeredTenure: offeredTenure ?? this.offeredTenure,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      loanId: loanId ?? this.loanId,
      contactId: contactId ?? this.contactId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      contact: contact ?? this.contact,
      loan: loan ?? this.loan,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'offered_interest': offeredInterest,
      'offered_tenure': offeredTenure,
      'approval_status': approvalStatus?.name,
      'loan_id': loanId,
      'contact_id': contactId,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'loan': loan?.toMap(),
      'contact': contact?.toMap(),
    };
  }

  factory LoanOfferModel.fromMap(Map<String, dynamic> map) {
    print("the offer status ${map['approval_status']}${map['id']}");
    return LoanOfferModel(
      id: map['id'] != null ? map['id'] as int : null,
      offeredInterest: map['offered_interest'] != null
          ? double.tryParse('${map['offered_interest']}')
          : null,
      offeredTenure: map['offered_tenure'] != null
          ? map['offered_tenure'] as int
          : null,
      approvalStatus: map['approval_status'] != null
          ? LoanApprovalStatus.fromMap(map['approval_status'])
          : null,
      loanId: map['loan_id'] != null ? map['loan_id'] as int : null,
      contactId: map['contact_id'] != null ? map['contact_id'] as int : null,
      createdAt: map['created_at'] != null
          ? DateTimeUtility.convertDateFromString(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTimeUtility.convertDateFromString(map['updated_at'])
          : null,
      contact: map['contact'] != null
          ? ContactData.fromMap(map['contact'] as Map<String, dynamic>)
          : null,
      loan: map['loan'] != null
          ? LoanRequestModel.fromMap(map['loan'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanOfferModel.fromJson(String source) =>
      LoanOfferModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoanOfferModel(id: $id, offeredInterest: $offeredInterest, offeredTenure: $offeredTenure, approvalStatus: $approvalStatus, loanId: $loanId, contactId: $contactId, createdAt: $createdAt, updatedAt: $updatedAt, contact: $contact, loan: $loan)';
  }

  @override
  bool operator ==(covariant LoanOfferModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.offeredInterest == offeredInterest &&
        other.offeredTenure == offeredTenure &&
        other.approvalStatus == approvalStatus &&
        other.loanId == loanId &&
        other.contactId == contactId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.contact == contact &&
        other.loan == loan;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        offeredInterest.hashCode ^
        offeredTenure.hashCode ^
        approvalStatus.hashCode ^
        loanId.hashCode ^
        contactId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        contact.hashCode ^
        loan.hashCode;
  }
}
