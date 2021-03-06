import 'dart:convert';

import 'package:money_app/constants/constant.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/services/api_service.dart';

class WalletRepository {
  WalletRepository._privateConstructor();
  static final WalletRepository instance =
      WalletRepository._privateConstructor();

  Future<List<Wallet>> getWallets() async {
    final data = await ApiService.instance.get(ApiURL.listWallets);
    print(data);
    final list = (jsonDecode(data) as List)
        .map<Wallet>((e) => Wallet.fromJson(e as Map<String, dynamic>))
        .toList();
    list.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    return list ?? [];
  }
}
