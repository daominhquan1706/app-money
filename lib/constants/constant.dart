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
  static String listWallets = "wallets";
  static String listRecord = "records";
}
