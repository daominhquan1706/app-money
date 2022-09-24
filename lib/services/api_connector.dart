import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moneylover/envs/base.dart';

class ApiConnector extends GetConnect {
  final IEnviroment env;
  ApiConnector({@required this.env})
      : assert(env != null),
        super(
          timeout: 10.seconds,
          userAgent: null,
        );

  @override
  void onInit() {
    super.onInit();
    if (env.domain?.isNotEmpty == true) {
      httpClient.baseUrl = env.baseUrl;
      httpClient.defaultContentType = 'application/json';
    }
  }
}
