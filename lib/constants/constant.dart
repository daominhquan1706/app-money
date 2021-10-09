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

  String get key {
    switch (this) {
      case HomeMenu.search:
        return 'search';
      case HomeMenu.signOut:
        return 'signOut';
      default:
        return null;
    }
  }
}

List<HomeMenu> get listHomeMenu {
  return [HomeMenu.search, HomeMenu.signOut];
}

// ignore: avoid_classes_with_only_static_members
mixin ApiURL {
  //wallet
  static String listWallets = "wallet/list";
  static String createWallet = "wallet/create";
  static String listTypeRecordOfWallet = "wallet/listTypeRecordOfWallet";

  //record
  static String listRecord = "records/list";
  static String listRecordByUserId = "record/listByUserId";
  static String createRecord = "record/create";

  //user
  static String login = "user/login";
  static String register = "user/signup";
}

mixin CollectionName {
  static String user = "user";
  static String record = "record";
  static String wallet = "wallet";
  static String typeRecord = "type_record";
}
