import 'dart:convert';

bool isNotEmpty(String s) {
  return s != null && s.trim().isNotEmpty;
}

bool isEmpty(String s) {
  return !isNotEmpty(s);
}

bool isListEmpty(List l) => l == null || l.isEmpty;

bool checkDeeplink(String link) {
  final uri = Uri.parse(link);
  // Sample apm-staging.suntec.sg
  // if (uri.host.contains(RegExp(r'apm-?.*\.suntec\.sg'))) {
  //   return true;
  // }
  return uri.host.contains('apmasia.com.sg');
}

String beautifyJson(Map json) {
  try {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(json);
    return prettyprint;
  } catch (e) {
    return jsonEncode(json);
  }
}
