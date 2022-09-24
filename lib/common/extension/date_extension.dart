import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneylover/common/utils/parse_utils.dart';

extension DateTimeExt on DateTime {
  static const timeFormatHHMM = 'HH:mm';
  static const dateFormatMMMddYYY = 'MMM dd, yyyy';
  static const dateFormatddMMMMYYY = 'dd MMMM, yyyy';
  static const dateFormatddMMMMHHmma = 'dd MMMM, HH:mma';
  static const dateFormatddMMyyyy = 'dd/MM/yyyy';
  static const dateFormatHHMMddMMMyyyy = 'HH:mm - dd MMMM yyyy';
  static const dateFormatHHMMaddMMMyyyy = 'HH:mma dd MMMM yyyy';
  static const dateFormatHHMMddMMyyyy = 'HH:mm dd/MM/yyyy';
  static const dateFormatyyyyMMdd = 'yyyy-MM-dd';

  String get formatTimeHHMM => DateFormat(timeFormatHHMM).format(this);

  String get formatTimeHHMMddMMMyyyy =>
      DateFormat(dateFormatHHMMddMMMyyyy).format(this);

  String get formatDateMMMddYYY => DateFormat(dateFormatMMMddYYY).format(this);

  String get formatDateFormatddMMMMYYY =>
      DateFormat(dateFormatddMMMMYYY).format(this);

  String get formatDateddMMyyyy => DateFormat(dateFormatddMMyyyy).format(this);

  String get formatDateyyyyMMdd => DateFormat(dateFormatyyyyMMdd).format(this);

  String get formatDateHHMMddMMyyyy =>
      DateFormat(dateFormatHHMMddMMyyyy).format(this);

  String get formatDateddMMMMHHmma =>
      DateFormat(dateFormatddMMMMHHmma).format(this);

  String get formatDateFormatHHMMaddMMMyyyy =>
      DateFormat(dateFormatHHMMaddMMMyyyy).format(this);

  String formatDateTime(String formatter) => DateFormat(formatter).format(this);

  DateTime get date => this == null ? null : DateTime(year, month, day);

  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  TimeOfDay get toTimeOfDay {
    return TimeOfDay.fromDateTime(this ?? DateTime.now());
  }

  String toFormatDate(String format) {
    return DateFormat(format).format(this);
  }

  String get toTimeAm => DateFormat('hh a').format(this);

  String get toDdMmmYy => DateFormat('dd MMM yy').format(this);

  String toDateAndTime() =>
      "$day ${ParseUtils.month(month)} $year ${toFormatDate("hh:mm a")}";

  String toTimeAndDate() =>
      "${toFormatDate("hh:mm a")} ${toFormatDate('dd MMM yyyy')}";
}
