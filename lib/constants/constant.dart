enum HomeMenu {
  search,
  signOut,
}

extension HomeMenuExtension on HomeMenu {
  String get name {
    switch (this) {
      case HomeMenu.search:
        return 'Search';
      case HomeMenu.signOut:
        return 'Sign Out';
      default:
        return null;
    }
  }
}

List<HomeMenu> get listHomeMenu {
  return [HomeMenu.search, HomeMenu.signOut];
}

// ignore: avoid_classes_with_only_static_members
class ApiURL {
  static String listWallets = "wallet/list";
  static String listRecord = "records/list";
  static String listRecordByUserId = "record/listByUserId";
  static String login = "user/login";
  static String register = "user/signup";
}
