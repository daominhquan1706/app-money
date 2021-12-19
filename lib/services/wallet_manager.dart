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
  List<TypeRecord> listTypeRecordOutcome = [];
  List<TypeRecord> listTypeRecordIncome = [];

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
  final TypeRecordRepository _typeRecordRepository =
      TypeRecordRepository.instance;
  Future fetchHomeData() async {
    await fetchWallets();
    await fetchRecords();
  }

  Future<void> fetchWallets() async {
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
    _sharedPreferenceService.setWalletId(wallet.id);
    currentWallet = wallet;
    await fetchRecords();
  }

  Future fetchRecords() async {
    if (currentWallet != null) {
      _listRecord = await _recordRepository.getRecords();
    }
  }

  Future<Record> onCreateRecord(Record record) async {
    final user = await _sharedPreferenceService.getUser();
    record.uid = user.id;
    record.walletId = currentWallet.id;
    final result = await _recordRepository.createRecord(record);
    await fetchRecords();
    return result;
  }

  Future<Record> onUpdateRecord(Record record) async {
    final user = await _sharedPreferenceService.getUser();
    record.uid = user.id;
    record.walletId = currentWallet.id;
    await _recordRepository.updateRecord(record);
    await fetchRecords();
    return record;
  }

  Future<void> onDeleteRecord(Record record) async {
    final isSuccess = await _recordRepository.onDeleteRecord(record.id);
    if (isSuccess) {
      _listRecord.removeWhere((element) => element.id == record.id);
    }
  }

  Future<void> onDeleteTypeRecord(TypeRecord typeRecord) async {
    final isSuccess =
        await _typeRecordRepository.onDeleteTypeRecord(typeRecord.id);
    if (isSuccess) {
      if (typeRecord.type == TypeRecordType.outcome) {
        listTypeRecordOutcome
            .removeWhere((element) => element.id == typeRecord.id);
      } else {
        listTypeRecordIncome
            .removeWhere((element) => element.id == typeRecord.id);
      }
    }
  }

  Future<TypeRecord> onUpdateTypeRecord(TypeRecord typeRecord) async {
    await _typeRecordRepository.updateTypeRecord(typeRecord);
    if (typeRecord.type == TypeRecordType.outcome) {
      listTypeRecordOutcome.forEach((element) {
        if (element.id == typeRecord.id) {
          element = typeRecord;
        }
      });
    }
    return typeRecord;
  }

  Future getListTypeRecord() async {
    if (currentWallet != null) {
      final result =
          await _typeRecordRepository.getTypeRecords(currentWallet.id);
      result.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
      listTypeRecordOutcome = result
              .where((element) => element.type == TypeRecordType.outcome)
              .toList() ??
          [];
      listTypeRecordIncome = result
              .where((element) => element.type == TypeRecordType.income)
              .toList() ??
          [];
    }
  }

  Future<TypeRecord> onCreateTypeRecord(TypeRecord typeRecord) async {
    if (typeRecord == null) {
      return null;
    }
    typeRecord.walletId = currentWallet.id;
    final user = await _sharedPreferenceService.getUser();
    typeRecord.uid = user.id;
    typeRecord.orderIndex = 0;
    final result = await _typeRecordRepository.createTypeRecord(typeRecord);
    if (result != null) {
      if (typeRecord.type == TypeRecordType.outcome) {
        listTypeRecordOutcome.insert(0, result);
        await onReorderTypeRecord(listTypeRecordOutcome);
      } else {
        listTypeRecordIncome.insert(0, result);
        await onReorderTypeRecord(listTypeRecordIncome);
      }
      return result;
    } else {
      return null;
    }
  }

  Future<void> onReorderTypeRecord(List<TypeRecord> listTypeRecord) async {
    await Future.wait(listTypeRecord
        .where((e) => e.orderIndex != listTypeRecord.indexOf(e))
        .map((e) => _typeRecordRepository.updateOrderIndex(
            e, listTypeRecord.indexOf(e))));
    await getListTypeRecord();
  }
}
