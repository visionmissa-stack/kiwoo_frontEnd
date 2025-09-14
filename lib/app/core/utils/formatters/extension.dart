import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'format_number.dart';

extension NumberFormat on num {
  String get toEGTH => toEGTHCurrency().format(this);
  String get toEGTHCompact {
    return "${toEGTHCurrency().currencySymbol} $formatNumberCompact";
  }

  String get toUS => toUsCurrency.format(this / 138);
  String get formatNumber => numberFormater.format(this);
  String get formatNumberCompact {
    var formater = numberFormater;
    if (this > 100000) {
      formater = numberFormaterCompact;
    }

    return formater.format(this);
  }
}

extension NumberStringFormat on String? {
  double get _toDouble => (double.tryParse(this ?? '0') ?? 0);
  String get toEHTG => _toDouble.toEGTH;
  String get toEHTGCompact => _toDouble.toEGTHCompact;
  String get toUS => _toDouble.toUS;
  String get formatNumber => _toDouble.formatNumber;
}

extension StringExtention on String? {
  String? get snakeCase => GetUtils.snakeCase(this, separator: '_');
}

extension DateTimeExtention on DateTime {
  String format(String format) {
    return DateFormat(format).format(this);
  }

  String since() {
    // Convert the provided UTC DateTime to local time
    final localDateTime = isUtc ? toLocal() : this;
    final now = DateTime.now();
    final timeFormat = DateFormat('kk:mm');
    var diffDays = now.difference(localDateTime).inDays;
    if (diffDays == 0) {
      return timeFormat.format(localDateTime);
    } else if (diffDays == 1) {
      // If the date is yesterday, show "Yesterday" and the time
      return 'Yesterday';
    } else if (diffDays < 7) {
      // IF date is in te last 6 days show the day name
      return DateFormat.EEEE().format(localDateTime);
    } else {
      // Otherwise, show the full date
      return DateFormat('dd/MM/yy').format(localDateTime);
    }
  }

  String afterSince([String format = 'dd/MM/yy']) {
    // Convert the provided UTC DateTime to local time
    final localDateTime = isUtc ? toLocal() : this;
    final now = DateTime.now();
    final timeFormat = DateFormat('kk:mm');
    var diffDays = localDateTime.difference(now).inDays;
    if (diffDays == 0) {
      return timeFormat.format(localDateTime);
    } else if (diffDays == 1) {
      // If the date is yesterday, show "Yesterday" and the time
      return 'Tomorrow';
    } else if (diffDays < 7) {
      // IF date is in te last 6 days show the day name
      return DateFormat.EEEE().format(localDateTime);
    } else {
      // Otherwise, show the full date
      return DateFormat(format).format(localDateTime);
    }
  }

  DateTime calculateLoanCompletionDate(int tenure) {
    DateTime loanCompletionDate = DateTime(
      year,
      month + tenure,
      day,
    );
    return loanCompletionDate;
  }
}

extension PhoneExtention on Phone {
  String get normalised {
    if (normalizedNumber.isNotEmpty) {
      return normalizedNumber;
    }
    return number.replaceAll(RegExp(r'\s|-|\(|\)'), '');
  }

  bool get isValidPhone {
    var regex = RegExp(r'^(\+?509)?[3,4]\d{7}$');
    return regex.hasMatch(normalised);
  }

  String get getValidNumber {
    return '509${normalised.replaceFirst(RegExp(r'^\+?509'), '')}';
  }
}

extension PhoneExtention2 on String {
  String get normalised {
    return replaceAll(RegExp(r'\s|-|\(|\)'), '');
  }

  bool get isValidPhone {
    var regex = RegExp(r'^(\+?509)?[3,4]\d{7}$');
    return regex.hasMatch(normalised);
  }

  String get getValidNumber {
    return '509${normalised.replaceFirst(RegExp(r'^\+?509'), '')}';
  }
}
