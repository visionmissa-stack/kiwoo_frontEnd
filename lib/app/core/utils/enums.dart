// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kiwoo/app/core/utils/kiwoo_icons.dart';

import 'app_string.dart';

enum OTPType { register, forgotPassword }

enum LoanLenderOptions {
  loanMarket(AppStrings.LOAN_MARKET),
  contacts(AppStrings.CONTACTS);

  final String value;

  const LoanLenderOptions(this.value);
}

enum SortDirection { asc, desc }

enum Direction {
  inbound,
  cashin,
  outbound;

  static Direction fromMap(int? index) {
    return Direction.values.elementAtOrNull(index ?? -1) ?? outbound;
  }

  static Direction fromName(String index) {
    return Direction.values.firstWhere((el) => el.name == index);
  }

  int toMap() => index;
}

enum SocketStatus {
  disconnected('Disconnected'),
  connecting('Connecting...'),
  connected(''),
  reconnecting('Reconnecting...');

  final String text;
  const SocketStatus(this.text);
}

enum MessageStatus {
  sending,
  sent,
  received,
  read;

  static MessageStatus fromMap(String? name) {
    return MessageStatus.values.firstWhere(
      (el) => el.name == name,
      orElse: () => sending,
    );
  }
}

enum LoanApprovalStatus {
  pending,
  offered,
  approved,
  rejected;

  static fromMap(String name) {
    return LoanApprovalStatus.values.firstWhereOrNull((el) => el.name == name);
  }
}

enum LoanStatus {
  requested,
  active,
  paidoff;

  static LoanStatus? fromMap(String name) {
    return LoanStatus.values.firstWhereOrNull((el) => el.name == name);
  }
}

enum CameraStatus { off, noCamAvailable, initialized, shooting, previewing }

enum IdentityType {
  front,
  back,
  face;

  static IdentityType? fromMap(String name) {
    return IdentityType.values.firstWhereOrNull((el) => el.name == name);
  }
}

enum NotificationType {
  chat,
  loanRequest,
  newLoanOffer,
  loanOfferAccepted,
  loanOfferRejected,
  loanAcceted,
  cashin,
  cashout,
  unKnow;

  static NotificationType fromMap(String? name) {
    return NotificationType.values.firstWhere(
      (el) => el.name == name,
      orElse: () => unKnow,
    );
  }
}

enum TransactionType {
  cashin,
  cashout,
  p2p,
  transfer,
  loan,
  recharge,
  installment,
  payment,
  loanPayBack;

  static TransactionType fromMap(String? name) {
    return TransactionType.values.firstWhere(
      (el) => el.name == name,
      orElse: () => transfer,
    );
  }

  String toMap() => name;
}

enum TransactionMethod {
  Airtel,
  MTN,
  Orange,
  Safari_com,
  M_Pesa,
  p2p;

  static TransactionMethod fromMap(String? name) {
    return TransactionMethod.values.firstWhere(
      (el) => el.name == name,
      orElse: () => p2p,
    );
  }

  String toMap() => name;
}

enum TransactionStatus {
  pending,
  failed,
  success;

  Color get color {
    switch (this) {
      case TransactionStatus.pending:
        return const Color.fromARGB(255, 255, 153, 0);
      case TransactionStatus.failed:
        return const Color.fromARGB(255, 244, 67, 54);
      case TransactionStatus.success:
        return const Color.fromARGB(255, 76, 175, 79);
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionStatus.pending:
        return Kiwoo.schedule;
      case TransactionStatus.failed:
        return Kiwoo.cancel_circled_outline;
      case TransactionStatus.success:
        return Kiwoo.success;
    }
  }

  static TransactionStatus fromMap(String? name) {
    return TransactionStatus.values.firstWhere((el) => el.name == name);
  }

  String toMap() => name;
}

enum LedgerType {
  cashin,
  cashout;

  static LedgerType fromMap(String? name) {
    return LedgerType.values.firstWhere((el) => el.name == name);
  }

  String toMap() => name;
}

enum LedgerMethod {
  Airtel,
  MTN,
  Orange,
  Safari_com,
  M_Pesa;

  static LedgerMethod fromMap(String? name) {
    return LedgerMethod.values.firstWhere((el) => el.name == name);
  }

  String toMap() => name;
}

enum VerificationStatus {
  none,
  pending,
  verified,
  verifiedby1,
  rejected;

  static VerificationStatus? fromString(String name) {
    return VerificationStatus.values.firstWhereOrNull(
          (el) => el.name == name,
        ) ??
        none;
  }

  bool get isVerified {
    return this == verified || this == verifiedby1 ? true : false;
  }

  bool get isPending => this == pending;
  String get textStatus {
    switch (this) {
      case VerificationStatus.none:
        return "Verification Required";
      case VerificationStatus.pending:
        return "Verification Pending";
      case VerificationStatus.verified:
        return "Verified";
      case VerificationStatus.verifiedby1:
        return "Verified by Someone";
      case VerificationStatus.rejected:
        return "Rejected";
    }
  }
}
