import 'package:money_app/constants/constant.dart';
import 'package:money_app/model/type_record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/services/api_service.dart';
import 'package:money_app/services/shared_preference_service.dart';

class WalletRepository {
  WalletRepository._privateConstructor();
  static final WalletRepository instance =
      WalletRepository._privateConstructor();

  Future<List<Wallet>> getWallets() async {
    final user = await SharedPreferenceService.instance.getUser();
    if (user != null) {
      final params = {"userId": user.id.toString()};
      final data =
          await ApiService.instance.get(ApiURL.listWallets, params: params);
      final listRecord =
          (data["result"] as Map<String, dynamic>)["list_wallet"];
      final list = (listRecord as List)
          .map<Wallet>((e) => Wallet.fromJson(e as Map<String, dynamic>))
          .toList();
      list.sort((a, b) => b.createdDate.compareTo(a.createdDate));
      return list ?? [];
    }
    return null;
  }

  Future<Map<String, dynamic>> createWallet(Wallet wallet) async {
    final user = await SharedPreferenceService.instance.getUser();
    wallet.userId = user.id;
    final body = wallet.toCreateJson();
    final data =
        await ApiService.instance.post(ApiURL.createWallet, body: body);

    return data["result"] as Map<String, dynamic>;
  }

  Future<List<TypeRecord>> listTypeRecord(int walletId) async {
    final params = {"wallet_id": walletId.toString()};
    final data = await ApiService.instance
        .get(ApiURL.listTypeRecordOfWallet, params: params);
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
