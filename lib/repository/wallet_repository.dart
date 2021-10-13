import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_app/constants/constant.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/services/api_service.dart';
import 'package:money_app/services/locator_service.dart';
import 'package:money_app/services/login_manager.dart';
import 'package:money_app/services/shared_preference_service.dart';
import 'package:money_app/view_models/login_viewmodel.dart';

class WalletRepository {
  static final WalletRepository instance = locator<WalletRepository>();

  final apiService = ApiService().instance;
  final SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService().instance;
  final CollectionReference _walletRef =
      FirebaseFirestore.instance.collection(CollectionName.wallet);
  final CollectionReference _typeRecordRef =
      FirebaseFirestore.instance.collection(CollectionName.typeRecord);
  Future<List<Wallet>> getWallets() async {
    final user = await _sharedPreferenceService.getUser();
    final snapshot = await _walletRef.where('uid', isEqualTo: user.id).get();
    final wallets = snapshot.docs
        .map((QueryDocumentSnapshot documentSnapshot) =>
            Wallet.fromSnapshot(documentSnapshot))
        .toList();
    wallets.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    return wallets;
  }

  Future<Wallet> createWallet(Wallet wallet) async {
    final uid = LoginManager.instance.user.uid;
    wallet.uid = uid;
    final value = await _walletRef.add(wallet.toJson());
    wallet.id = value.id;
    await Future.wait(listTypeRecordDefault.map((element) {
      element.uid = uid;
      element.walletId = wallet.id;
      return _typeRecordRef.add(element.toJson());
    }));

    return wallet;
  }
}
