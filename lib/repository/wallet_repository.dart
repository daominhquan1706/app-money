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
    final wallets = snapshot.docs
        .map((QueryDocumentSnapshot documentSnapshot) =>
            Wallet.fromSnapshot(documentSnapshot))
        .toList();
    wallets.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    return wallets;
  }

  Future<Wallet> createWallet(Wallet wallet) async {
    final uid = LoginViewModel().instance.user.uid;
    wallet.uid = uid;
    final value = await walletRef.add(wallet.toJson());
    wallet.id = value.id;
    return wallet;
  }
}
