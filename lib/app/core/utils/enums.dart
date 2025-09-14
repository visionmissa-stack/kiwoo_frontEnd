import 'package:get/get.dart';

import 'app_string.dart';

enum OTPType {
  register,
  forgotPassword,
}

enum LoanLenderOptions {
  loanMarket(AppStrings.LOAN_MARKET),
  contacts(AppStrings.CONTACTS);

  final String value;

  const LoanLenderOptions(this.value);
}

enum SortDirection { asc, desc }

enum Direction {
  inbound,
  outbound;

  static Direction fromMap(int? index) {
    return Direction.values.elementAtOrNull(index ?? -1) ?? outbound;
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

enum CameraStatus {
  off,
  noCamAvailable,
  initialized,
  shooting,
  previewing,
}

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
  cashIn,
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
  moncash,
  natcash,
  bank,
  card,
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

  static TransactionStatus fromMap(String? name) {
    return TransactionStatus.values.firstWhere((el) => el.name == name);
  }

  String toMap() => name;
}

enum LedgerType {
  cashin,
  cashout;

  static LedgerType fromMap(String? name) {
    return LedgerType.values.firstWhere(
      (el) => el.name == name,
    );
  }

  String toMap() => name;
}

enum LedgerMethod {
  moncash,
  natcash,
  bank,
  card;

  static LedgerMethod fromMap(String? name) {
    return LedgerMethod.values.firstWhere(
      (el) => el.name == name,
    );
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
    return VerificationStatus.values
            .firstWhereOrNull((el) => el.name == name) ??
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
