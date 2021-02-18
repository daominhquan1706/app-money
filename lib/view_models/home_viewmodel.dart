import 'package:flutter/cupertino.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/repository/record_repository.dart';
import 'package:money_app/repository/wallet_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel() {
    fetchData();
  }

  static final HomeViewModel instance = HomeViewModel();
  List<Record> listRecordFull;
  List<Record> listRecord;
  List<Wallet> listWallet;
  final RecordRepository recordRepository = RecordRepository();
  final WalletRepository walletRepository = WalletRepository();
  Wallet currentWallet;
  SharedPreferences prefs;

  void fetchData() {
    getRecord();
    getWallet();
    setUpSharedPreference();
  }

  Future getRecord() async {
    listRecordFull = await recordRepository.getRecords();
    listRecord = listRecordFull;
    notifyListeners();
  }

  Future getWallet() async {
    listWallet = await walletRepository.getWallets();
    notifyListeners();
  }

  Future setUpSharedPreference() async {
    prefs ??= await SharedPreferences.getInstance();
    notifyListeners();
  }

  void onPickWallet(Wallet wallet) {
    currentWallet = wallet;
    listRecord = listRecordFull
        .where((element) => element.walletId == currentWallet.id)
        .toList();
    print(listRecord.where((element) => element.amount == null));
    notifyListeners();
  }
}
