import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/repository/record_repository.dart';
import 'package:money_app/repository/wallet_repository.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/view_models/home_viewmodel.dart';

class RecordCreateViewModel with ChangeNotifier {
  List<Wallet> listWallet = [];
  List<TypeRecord> listTypeRecord = [];
  double amount;
  DateTime date = DateTime.now();
  String note;
  String title;
  Wallet wallet;
  TypeRecord typeRecord;

  final RecordRepository recordRepository = RecordRepository.instance;
  final WalletRepository walletRepository = WalletRepository.instance;
  HomeViewModel _homeViewModel;

  HomeViewModel get homeViewModel => _homeViewModel;

  set homeViewModel(HomeViewModel value) {
    if (_homeViewModel == null) {
      _homeViewModel ??= value;
      fetchData();
    }
  }

  void fetchData() {
    listWallet = _homeViewModel.listWallet;
    setWallet(_homeViewModel.currentWallet);
    notifyListeners();
  }

  void setWallet(Wallet wallet) {
    if (wallet != null) {
      this.wallet = wallet;
      if (wallet != null && wallet.id != null) {
        getListTypeRecord(wallet.id);
      }
      notifyListeners();
    }
  }

  void onPickWallet(Wallet w) {
    wallet = w;
    notifyListeners();
    getListTypeRecord(wallet.id);
  }

  Future getListTypeRecord(String walletId) async {
    final result = await walletRepository.listTypeRecord(walletId);
    listTypeRecord = result ?? [];
    notifyListeners();
  }

  void onPickTypeRecord(TypeRecord t) {
    typeRecord = t;
    notifyListeners();
  }

  String get dateString {
    return DateFormat.yMMMd().format(date);
  }
}
