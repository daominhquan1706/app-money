import 'base.dart';

class ProductionEnviroment implements IEnviroment {
  @override
  final String description = 'Lifestyle Production';
  @override
  final String domain = 'suntec-api.alphapage.co';
  // final String domain = 'suntec-api-develop.alphapage.co';
  @override
  final String subPath = 'api';
  @override
  String get scheme => 'https';
  @override
  int get port => null;

  @override
  String get eatsDomain => 'eats.sunteccity.com.sg';

  @override
  String get emallDomain => 'emall.sunteccity.com.sg';
}
