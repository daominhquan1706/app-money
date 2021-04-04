import 'package:flutter/cupertino.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/repository/record_repository.dart';
import 'package:money_app/repository/wallet_repository.dart';
import 'package:money_app/services/shared_preference_service.dart';

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
  }

  Future getRecord() async {
    listRecordFull = await recordRepository.getRecords();
    final currentWalletId = await prefsService.getCurrentWalletId();
    if (currentWalletId == null) {
      listRecord = listRecordFull;
    } else {
      listRecord = listRecordFull
          .where((element) => element.walletId == currentWalletId)
          .toList();
    }
    notifyListeners();
  }

  Future getWallet() async {
    listWallet = await walletRepository.getWallets();
    notifyListeners();
  }

  void onPickWallet(Wallet wallet) {
    if (wallet.id == -1) {
      prefsService.changeWallet(null);
      listRecord = listRecordFull;
    } else {
      prefsService.changeWallet(wallet.id);
      currentWallet = wallet;
      listRecord = listRecordFull
          .where((element) => element.walletId == currentWallet.id)
          .toList();
    }
    notifyListeners();
  }

  Future<String> onCreateWallet(Wallet wallet) async {
    if (wallet == null) {
      return "Wallet not null";
    }
    final result = await walletRepository.createWallet(wallet);
    if (result != null) {
      wallet.id = result["wallet_id"] as int;
      listWallet.insert(0, wallet);
      notifyListeners();
      return "SUCCESS";
    } else {
      return "result not be null";
    }
  }

  Future<String> onCreateRecord(Record record) async {
    if (record == null) {
      return "record not be null";
    }
    final result = await recordRepository.createRecord(record);
    if (result != null) {
      record.id = result["record_id"] as int;
      listRecordFull.add(record);
      notifyListeners();
      return "SUCCESS";
    } else {
      return "result not be null";
    }
  }

  double get amountListRecord => [
        ...listRecord.map((e) => e.isAdd ? e.amount : 0 - e.amount),
        0.0,
      ].reduce((a, b) => a + b);

  void deleteRecord(Record record) {
    listRecord.removeWhere((element) => element.id == record.id);
    listRecordFull.removeWhere((element) => element.id == record.id);
    notifyListeners();
  }
}
