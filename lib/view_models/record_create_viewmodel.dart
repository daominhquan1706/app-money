import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  int segmentIndex = 0;

  final WalletManager _walletManager = WalletManager.instance;

  List<TypeRecord> get listTypeRecordOutCome =>
      _walletManager.listTypeRecordOutcom;
  List<TypeRecord> get listTypeRecordInCome =>
      _walletManager.listTypeRecordIncome;
  List<Wallet> get listWallet => _walletManager.listWallet;
  Record recordForEdit;

  List<TypeRecord> get listTypeRecord {
    if (segmentIndex == 0) {
      return _walletManager.listTypeRecordOutcom;
    } else {
      return _walletManager.listTypeRecordIncome;
    }
  }

  Future initialize({Record record}) async {
    recordForEdit = record;
    if (_walletManager.currentWallet != null) {
      await getListTypeRecord(_walletManager.currentWallet.id);
    }
  }

  Future onPickWallet(Wallet wallet) async {
    _walletManager.onPickWallet(wallet);
    typeRecord = null;
    await getListTypeRecord(wallet.id);
    notifyListeners();
  }

  Future getListTypeRecord(String walletId) async {
    _walletManager.getListTypeRecord(walletId).then((_) {
      final isEdit = recordForEdit != null;
      if (isEdit) {
        setUpRecordForEdit(recordForEdit);
      } else {
        onSwithType(0);
      }
    });
  }

  void onSwithType(int index) {
    segmentIndex = index;
    final list = segmentIndex == 0
        ? _walletManager.listTypeRecordOutcom
        : _walletManager.listTypeRecordIncome;
    if (list.isNotEmpty) {
      onPickTypeRecord(list.first);
    }
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

  Future<Record> onSaveRecord() async {
    Record result;
    final bool isEdit = recordForEdit != null;
    if (isEdit) {
      recordForEdit
        ..createDate = Timestamp.fromDate(date)
        ..amount = amount
        ..title = typeRecord.name
        ..typeRecordId = typeRecord.id
        ..note = note;

      await _walletManager.onUpdateRecord(recordForEdit);
      return recordForEdit;
    } else {
      final Record record = Record(
        createDate: Timestamp.fromDate(date),
        amount: amount,
        title: typeRecord.name,
        isAdd: segmentIndex == 1,
        walletId: wallet.id,
        typeRecordId: typeRecord.id,
        note: note,
      );
      final createdRecord = await _walletManager.onCreateRecord(record);
      return createdRecord;
    }
  }

  Future<void> onReorderTypeRecords({List<TypeRecord> listTypeRecord}) async {
    await _walletManager.onReorderTypeRecord(listTypeRecord);
    notifyListeners();
  }

  Future<void> onDeleteRecord() async{
    await _walletManager.onDeleteRecord(recordForEdit);
    notifyListeners();
  }

  void setUpRecordForEdit(Record record) {
    segmentIndex = record.isAdd ? 1 : 0;
    date = record.createDate.toDate();
    amount = record.amount;
    final typeRecord = [
      ..._walletManager.listTypeRecordIncome,
      ..._walletManager.listTypeRecordOutcom
    ].firstWhere((element) => element.id == record.typeRecordId,
        orElse: () => null);
    title = typeRecord.name;
    onPickTypeRecord(typeRecord);
    note = record.note;
    notifyListeners();
  }
}
