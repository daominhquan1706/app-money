import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/repository/record_repository.dart';
import 'package:money_app/repository/wallet_repository.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:money_app/view_models/home_viewmodel.dart';

class RecordCreateViewModel with ChangeNotifier {
  List<Wallet> listWallet = [];
  List<TypeRecord> listTypeRecord = [];
  double amount;
  DateTime date;
  String note;
  String title;
  Wallet wallet;
  TypeRecord typeRecord;

  RecordCreateViewModel() {
    fetchData();
  }

  static final RecordCreateViewModel instance = RecordCreateViewModel();

  final RecordRepository recordRepository = RecordRepository.instance;
  final WalletRepository walletRepository = WalletRepository.instance;
  Wallet currentWallet;
  SharedPreferenceService prefsService = SharedPreferenceService.instance;

  void fetchData() {
    listWallet = HomeViewModel.instance.listWallet ?? [];
    date = DateTime.now();
    setWallet(HomeViewModel.instance.currentWallet);
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

  Future getListTypeRecord(int walletId) async {
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
