import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_app/constants/constant.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/services/api_service.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:money_app/view_models/login_viewmodel.dart';

class WalletRepository {
  WalletRepository._privateConstructor();
  static final WalletRepository instance =
      WalletRepository._privateConstructor();
  final apiService = ApiService().service;
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService().instance;
  CollectionReference walletRef =
      FirebaseFirestore.instance.collection(CollectionName.wallet);

  Future<List<Wallet>> getWallets() async {
    final user = await _sharedPreferenceService.getUser();
    final snapshot = await walletRef.where('uid', isEqualTo: user.id).get();
    final records = snapshot.docs
        .map((QueryDocumentSnapshot documentSnapshot) =>
            Wallet.fromSnapshot(documentSnapshot))
        .toList();

    return records;
    // final user = await _sharedPreferenceService.getUser();
    // if (user != null) {
    //   final params = {"userId": user.id.toString()};
    //   final data = await apiService.get(ApiURL.listWallets, params: params);
    //   final listRecord =
    //       (data["result"] as Map<String, dynamic>)["list_wallet"];
    //   final list = (listRecord as List)
    //       .map<Wallet>((e) => Wallet.fromJson(e as Map<String, dynamic>))
    //       .toList();
    //   list.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    //   return list ?? [];
    // }
    // return null;
  }

  Future<Wallet> createWallet(Wallet wallet) async {
    final uid = LoginViewModel().instance.user.uid;
    wallet.uid = uid;
    final value = await walletRef.add(wallet.toJson());
    wallet.id = value.id;
    return wallet;
    // final user = await _sharedPreferenceService.getUser();
    // wallet.userId = user.id;
    // final body = wallet.toCreateJson();
    // final data = await apiService.post(ApiURL.createWallet, body: body);
    //
    // return data["result"] as Map<String, dynamic>;
  }

  Future<List<TypeRecord>> listTypeRecord(String walletId) async {
    final params = {"wallet_id": walletId.toString()};
    final data =
        await apiService.get(ApiURL.listTypeRecordOfWallet, params: params);
    if (data != null) {
      final listTypeRecord =
          (data["result"] as Map<String, dynamic>)["list_typeRecord"];
      final list = (listTypeRecord as List)
          .map<TypeRecord>(
              (e) => TypeRecord.fromJson(e as Map<String, dynamic>))
          .toList();
      return list ?? [];
    }
    return null;
  }
}
