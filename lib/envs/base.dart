abstract class IEnviroment {
  String get domain;
  String get eatsDomain;
  String get emallDomain;
  String get subPath;
  String get description;

  String get scheme;
  int get port;
}

extension IEnviromentExtension on IEnviroment {
  String get baseUrl {
    final uri = Uri(
      scheme: scheme,
      path: subPath,
      host: domain,
      port: port,
    );
    return uri.toString();
  }
}
