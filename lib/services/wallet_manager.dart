import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_app/constants/constant.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/repository/record_repository.dart';
import 'package:money_app/repository/type_record_repository.dart';
import 'package:money_app/repository/wallet_repository.dart';
import 'package:money_app/services/shared_preference_service.dart';

import 'locator_service.dart';

class WalletManager {
  static WalletManager get instance => locator<WalletManager>();
  List<Wallet> listWallet = [];
  List<Record> _listRecord = [];
  List<TypeRecord> listTypeRecord = [];

  List<Record> get listRecordDisplay {
    if (currentWallet != null) {
      return _listRecord
          .where((element) => element.walletId == currentWallet.id)
          .toList();
    }
    return _listRecord;
  }

  Wallet currentWallet;
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService().instance;
  CollectionReference walletRef =
      FirebaseFirestore.instance.collection(CollectionName.wallet);
  final RecordRepository _recordRepository = RecordRepository.instance;
  final WalletRepository _walletRepository = WalletRepository.instance;
  final TypeRecordRepository typeRecordRepository =
      TypeRecordRepository.instance;
  Future fetchData() async {
    await Future.wait([getWallets(), getRecords()]);
  }

  Future<void> getWallets() async {
    listWallet = await _walletRepository.getWallets();
    final currentWalletId = await _sharedPreferenceService.getCurrentWalletId();
    currentWallet = listWallet.firstWhere(
        (element) => element.id == currentWalletId,
        orElse: () => null);
  }

  Future<Wallet> onCreateWallet(Wallet wallet) async {
    if (wallet == null) {
      return null;
    }
    final result = await _walletRepository.createWallet(wallet);
    if (result != null) {
      listWallet.add(result);
      return result;
    } else {
      return null;
    }
  }

  Future<void> onPickWallet(Wallet wallet) async {
    if (wallet.id == "all") {
      _sharedPreferenceService.changeWallet("all");
    } else {
      _sharedPreferenceService.changeWallet(wallet.id);
      currentWallet = wallet;
    }
    await getRecords();
  }

  Future getRecords() async {
    _listRecord = await _recordRepository.getRecords();
  }

  Future<Record> onCreateRecord(Record record) async {
    final user = await _sharedPreferenceService.getUser();
    record.uid = user.id;
    record.walletId = currentWallet.id;
    final result = await _recordRepository.createRecord(record);
    await getRecords();
    return result;
  }

  Future<void> onDeleteRecord(Record record) async {
    // await _recordRepository.deleteRecord(record);
    _listRecord.removeWhere((element) => element.id == record.id);
  }

  Future getListTypeRecord(String walletId) async {
    final result = await typeRecordRepository.getTypeRecords(walletId);
    listTypeRecord = result ?? [];
  }

  Future<TypeRecord> onCreateTypeRecord(TypeRecord typeRecord) async {
    if (typeRecord == null) {
      return null;
    }
    typeRecord.walletId = currentWallet.id;
    final user = await _sharedPreferenceService.getUser();
    typeRecord.uid = user.id;
    final result = await typeRecordRepository.createTypeRecord(typeRecord);
    if (result != null) {
      listTypeRecord.add(result);
      return result;
    } else {
      return null;
    }
  }
}
