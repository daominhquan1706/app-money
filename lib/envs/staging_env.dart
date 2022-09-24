import 'base.dart';

class StagingEnviroment implements IEnviroment {
  @override
  final String description = 'Lifestyle Staging';
  @override
  final String domain = 'suntec-api-develop.alphapage.co';
  @override
  final String subPath = 'api';
  @override
  String get scheme => 'https';
  @override
  int get port => null;
  @override
  String get eatsDomain => 'eats-new-staging.sunteccity.com.sg';

  @override
  String get emallDomain => 'emall-stg.sunteccity.com.sg';
}

class LocalEnviroment implements IEnviroment {
  @override
  final String description = 'Lifestyle Local';
  @override
  final String domain = 'localhost';
  @override
  final String subPath = 'api';
  @override
  String get scheme => 'http';
  @override
  int get port => 3000;
  @override
  String get eatsDomain => 'eats-stg.sunteccity.com.sg';

  @override
  String get emallDomain => 'emall-stg.sunteccity.com.sg';
}
