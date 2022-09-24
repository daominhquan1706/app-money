class DateTimeUtil {
  static DateTime utcStringToLocal(String input) {
    if (input == null || input.isEmpty) return null;
    return DateTime.tryParse(input)?.toLocal();
  }

  static String localDateTimeToUTCString(DateTime input) {
    return input?.toUtc()?.toIso8601String();
  }
}

extension RemoveFreezedKeyExtension on Map {
  void removeFreezedKeys() {
    remove('createdAt');
    remove('updatedAt');
    remove('_id');
  }
}
