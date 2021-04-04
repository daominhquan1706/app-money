import 'package:money_app/constants/constant.dart';
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
      final data = await ApiService.instance.get(
        ApiURL.listWallets,
        params: params,
      );
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
}
