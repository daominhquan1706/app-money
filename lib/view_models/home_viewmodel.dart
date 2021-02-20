import 'package:flutter/cupertino.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/repository/record_repository.dart';
import 'package:money_app/repository/wallet_repository.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel() {
    fetchData();
  }

  static final HomeViewModel instance = HomeViewModel();
  List<Record> listRecordFull;
  List<Record> listRecord;
  List<Wallet> listWallet;
  final RecordRepository recordRepository = RecordRepository.instance;
  final WalletRepository walletRepository = WalletRepository.instance;
  Wallet currentWallet;
  SharedPreferenceService prefsService = SharedPreferenceService.instance;

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
    prefsService.prefs ??= await SharedPreferences.getInstance();
    notifyListeners();
  }

  void onPickWallet(Wallet wallet) {
    if (wallet == null) {
      listRecord = listRecordFull;
      notifyListeners();
    } else {
      currentWallet = wallet;
      listRecord = listRecordFull
          .where((element) => element.walletId == currentWallet.id)
          .toList();
      notifyListeners();
    }
  }

  void onCreateWallet(Wallet wallet) {
    if (wallet == null) {
      return;
    }
    int id = 0;
    final listId = listWallet.map((e) => e.id ?? 0).toList();
    while (listId.contains(id)) {
      id++;
    }
    wallet.id = id;
    listWallet.add(wallet);
    notifyListeners();
  }

  void onCreateRecord(Record record) {
    if (record == null) {
      return;
    }
    int id = 0;
    final listId = listRecord.map((e) => e.id ?? 0).toList();
    while (listId.contains(id)) {
      id++;
    }
    record.id = id;
    listRecordFull.add(record);
    onPickWallet(currentWallet);
    notifyListeners();
  }
}
