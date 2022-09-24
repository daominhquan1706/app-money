import 'package:intl/intl.dart';

extension DynamicExtension on dynamic {
  String get formatCurrencyNoName {
    const locale = 'en';
    const currencyName = '';
    const errorText = '0';
    var formatter = NumberFormat.currency(
        locale: locale,
        name: currencyName,
        decimalDigits: 0,
        customPattern: "#,##0.00\u00A4");
    switch (runtimeType) {
      case num:
      case int:
      case double:
        return formatter.format(this ?? 0);
      case String:
        var value = double.tryParse(this ?? 0);
        if (value == null) {
          return errorText;
        }
        return formatter.format(value);
      default:
        return errorText;
    }
  }

  String get formatCurrency {
    const locale = 'en';
    const errorText = '0';
    var formatter = NumberFormat.simpleCurrency(
      locale: locale,
      decimalDigits: 0,
    );
    switch (runtimeType) {
      case num:
      case int:
      case double:
        return formatter.format(this ?? 0);
      case String:
        var value = double.tryParse(this ?? 0);
        if (value == null) {
          return errorText;
        }
        return formatter.format(value);
      default:
        return errorText;
    }
  }

   String get formatCurrency2decimal {
    const locale = 'en';
    const errorText = '0';
    var formatter = NumberFormat.simpleCurrency(
      locale: locale,
      decimalDigits: 2,
    );
    switch (runtimeType) {
      case num:
      case int:
      case double:
        return formatter.format(this ?? 0);
      case String:
        var value = double.tryParse(this ?? 0);
        if (value == null) {
          return errorText;
        }
        return formatter.format(value);
      default:
        return errorText;
    }
  }

  

  String get thousandFormat {
    const locale = 'en_US';
    const errorText = '0';
    var formatter = NumberFormat.decimalPattern(locale);
    switch (runtimeType) {
      case num:
      case int:
      case double:
        return formatter.format(this ?? 0);
      case String:
        var value = double.tryParse(this ?? 0);
        if (value == null) {
          return errorText;
        }
        return formatter.format(value);
      default:
        return errorText;
    }
  }
}
