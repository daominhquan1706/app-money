// ignore_for_file: constant_identifier_names

enum Flavor {
  PRODUCTION,
  STAGING,
}

class F {
  static Flavor appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'Money Lover';
      case Flavor.STAGING:
        return 'STG Money Lover';
      default:
        return 'title';
    }
  }
}
