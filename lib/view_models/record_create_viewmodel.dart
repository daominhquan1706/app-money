import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/services/wallet_manager.dart';

class RecordCreateViewModel with ChangeNotifier {
  double amount;
  DateTime date = DateTime.now();
  String note;
  String title;
  Wallet get wallet => _walletManager.currentWallet;
  TypeRecord typeRecord;

  final WalletManager _walletManager = WalletManager.instance;

  List<TypeRecord> get listTypeRecord => _walletManager.listTypeRecord;
  List<Wallet> get listWallet => _walletManager.listWallet;

  Future initialize() async {
    await getListTypeRecord(_walletManager.currentWallet.id);
  }

  Future onPickWallet(Wallet wallet) async {
    _walletManager.onPickWallet(wallet);
    typeRecord = null;
    await getListTypeRecord(wallet.id);
    notifyListeners();
  }

  Future getListTypeRecord(String walletId) async {
    _walletManager.getListTypeRecord(walletId).then((value) {
      notifyListeners();
    });
  }

  void onPickTypeRecord(TypeRecord t) {
    typeRecord = t;
    notifyListeners();
  }

  String get dateString {
    return DateFormat.yMMMd().format(date);
  }

  Future<TypeRecord> onCreateTypeRecord(TypeRecord typeRecord) async {
    final result = await _walletManager.onCreateTypeRecord(typeRecord);
    notifyListeners();
    return result;
  }

  Future<Record> onCreateRecord(Record record) async {
    record.typeRecordId = typeRecord.id;
    final result = await _walletManager.onCreateRecord(record);
    return result;
  }
}
