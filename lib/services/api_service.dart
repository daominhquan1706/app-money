import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moneylover/common/dialog/dialog_utils.dart';
import 'package:moneylover/common/utils/parse_utils.dart';
import 'package:moneylover/common/utils/utils.dart';
import 'package:moneylover/language/string_manager.dart';
import 'package:moneylover/services/map_error_response.dart';

const Map<String, String> MEDIA_TYPES = {
  "dart": "application/dart",
  "js": "application/javascript",
  "html": "text/html; charset=UTF-8",
  "htm": "text/html; charset=UTF-8",
  "css": "text/css",
  "txt": "text/plain",
  "json": "application/json",
  "ico": "image/vnd.microsoft.icon",
  "png": "image/png",
  "bmp": "image/bmp",
  "jpg": "image/jpeg",
  "jpeg": "image/jpeg",
  "tiff": "image/tiff",
  "ogg": "audio/ogg",
  "mp3": "audio/mpeg",
  "ogv": "video/ogg",
  "mp4": "video/mp4",
  "mov": "video/mov",
  "webm": "video/webm",
  "pdf": "application/pdf"
};

abstract class IApiService {
  String getMediatype(String filename);

  bool isAuthorized();

  void markAuthorized(String token);

  Future<void> requestApi(String url,
      {Method method = Method.post,
      dynamic body,
      String contentType,
      Map<String, String> headers,
      Map<String, dynamic> query,
      Function(dynamic) onSuccess,
      Function(int, String, dynamic) onFailure,
      Function(String) onErrorHttp,
      Progress uploadProgress});

  Future<Response<T>> get<T>(
    String url, {
    Map<String, String> headers,
    String contentType,
    Map<String, dynamic> query,
    Decoder<T> decoder,
  });

  Future<Response<T>> post<T>(
    String url, {
    dynamic body,
    String contentType,
    Map<String, String> headers,
    Map<String, dynamic> query,
    Decoder<T> decoder,
    Progress uploadProgress,
  });

  Future<Response<T>> put<T>(
    String url, {
    dynamic body,
    String contentType,
    Map<String, String> headers,
    Map<String, dynamic> query,
    Decoder<T> decoder,
    Progress uploadProgress,
  });

  Future<Response<T>> patch<T>(
    String url, {
    dynamic body,
    String contentType,
    Map<String, String> headers,
    Map<String, dynamic> query,
    Decoder<T> decoder,
    Progress uploadProgress,
  });

  Future<Response<T>> request<T>(
    String url,
    String method, {
    dynamic body,
    String contentType,
    Map<String, String> headers,
    Map<String, dynamic> query,
    Decoder<T> decoder,
    Progress uploadProgress,
  });

  Future<Response<T>> delete<T>(
    String url, {
    Map<String, String> headers,
    String contentType,
    Map<String, dynamic> query,
    Decoder<T> decoder,
  });
}

class ApiService extends GetxService implements IApiService {
  final GetConnect connector;

  ApiService({@required GetConnect connector})
      : assert(connector != null),
        connector = connector {
    connector.httpClient.addRequestModifier((request) {
      if (request.headers?.containsKey('localization') != true) {
        request.headers
            .addAll({"localization": Get.locale.languageCode ?? 'en'});
      }
      return request;
    });
  }

  // Authorized will be marked, need hook on after authroize actions
  String _token;

  @override
  void markAuthorized(String token) {
    _token = token;
    connector.httpClient.addAuthenticator((request) {
      if (_token?.isNotEmpty == true) {
        request.headers['Authorization'] = _token;
      }
      return request;
    });
  }

  @override
  Future<void> requestApi(String url,
      {Method method = Method.post,
      dynamic body,
      String contentType,
      Map<String, String> headers,
      Map<String, dynamic> query,
      Function(dynamic) onSuccess,
      Function(int, String, dynamic) onFailure,
      Function(String) onErrorHttp,
      Progress uploadProgress}) async {
    defaultDecoder(dynamic json) => json as Map<dynamic, dynamic>;

    headers ??= {};

    headers.addAll({"localization": Get.locale.languageCode ?? 'en'});

    logRequest(url: url, method: method.name, headers: headers, query: query);

    Response<Map<dynamic, dynamic>> result;
    if (method == Method.get) {
      result = await get(url,
          headers: headers,
          contentType: contentType,
          query: query,
          decoder: defaultDecoder);
    }

    if (method == Method.post) {
      result = await post(url,
          body: body,
          contentType: contentType,
          headers: headers,
          query: query,
          uploadProgress: uploadProgress,
          decoder: defaultDecoder);
    }

    if (method == Method.put) {
      result = await put(url,
          body: body,
          contentType: contentType,
          headers: headers,
          query: query,
          uploadProgress: uploadProgress,
          decoder: defaultDecoder);
    }

    if (result == null) {
      onErrorHttp(StringManager.textErrorNetwork.tr);
      DialogUtils.showInternalServerErrorMessage();
      return;
    }

    logResponse(result);

    dynamic json = result.body;
    if (json != null && json is Map) {
      if (result.isOk) {
        Map dataMap = json["data"] ?? json;
        onSuccess(dataMap);
        return;
      } else {
        String errorMsg = ParseUtils.parse<String>(json["message"]);
        String message = StringManager.textError.tr;
        if (MapErrorResponse.mapError.containsKey(errorMsg)) {
          message = MapErrorResponse.mapError[errorMsg];
        }
        onFailure(
          ParseUtils.parse<int>(json["code"]),
          message,
          json,
        );
        return;
      }
    } else {
      onErrorHttp(StringManager.textErrorNetwork.tr);
      DialogUtils.showInternalServerErrorMessage();
    }

    return;
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, String> headers,
    String contentType,
    Map<String, dynamic> query,
    Decoder<T> decoder,
  }) async {
    logRequest(url: url, method: "GET", headers: headers, query: query);
    final result = await connector.get<T>(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
    logResponse(result);
    return result;
  }

  @override
  Future<Response<T>> post<T>(
    String url, {
    dynamic body,
    String contentType,
    Map<String, String> headers,
    Map<String, dynamic> query,
    Decoder<T> decoder,
    Progress uploadProgress,
  }) async {
    logRequest(
        url: url, method: "POST", headers: headers, query: query, body: body);
    final result = await connector.post<T>(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    logResponse(result);
    return result;
  }

  @override
  Future<Response<T>> put<T>(
    String url, {
    dynamic body,
    String contentType,
    Map<String, String> headers,
    Map<String, dynamic> query,
    Decoder<T> decoder,
    Progress uploadProgress,
  }) async {
    logRequest(
        url: url, method: "PUT", headers: headers, query: query, body: body);
    final result = await connector.put<T>(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    logResponse(result);
    return result;
  }

  @override
  Future<Response<T>> patch<T>(
    String url, {
    dynamic body,
    String contentType,
    Map<String, String> headers,
    Map<String, dynamic> query,
    Decoder<T> decoder,
    Progress uploadProgress,
  }) async {
    logRequest(
        url: url, method: "PATCH", headers: headers, query: query, body: body);
    final result = await connector.patch<T>(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    logResponse(result);
    return result;
  }

  @override
  Future<Response<T>> request<T>(
    String url,
    String method, {
    dynamic body,
    String contentType,
    Map<String, String> headers,
    Map<String, dynamic> query,
    Decoder<T> decoder,
    Progress uploadProgress,
  }) async {
    logRequest(
        url: url, method: method, headers: headers, query: query, body: body);
    final result = await connector.request<T>(
      url,
      method,
      body: body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
    logResponse(result);
    return result;
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, String> headers,
    String contentType,
    Map<String, dynamic> query,
    Decoder<T> decoder,
  }) async {
    logRequest(url: url, method: "DELETE", headers: headers, query: query);
    final result = await connector.delete(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
    logResponse(result);
    return result;
  }

  @override
  String getMediatype(String filename) {
    int dot = filename.lastIndexOf('.');
    if (dot != -1) {
      var fileType = filename.substring(dot + 1);
      var mediaType = MEDIA_TYPES[fileType.toLowerCase()];
      if (mediaType != null) {
        return mediaType;
      }
    }
    return 'application/octet-stream';
  }

  @override
  bool isAuthorized() {
    return _token?.isNotEmpty == true;
  }

  void logRequest({
    String url,
    String method,
    Map<String, String> headers,
    Map<String, dynamic> query,
    dynamic body,
  }) {
    if (kDebugMode) {
      try {
        if (url.contains('/auth/user/me')) {
          return;
        }

        final log = "-------- REQUEST -----------\n"
            "url: $url\n"
            "method: $method\n"
            "headers: $headers\n"
            "query: ${beautifyJson(query)}\n"
            "${body != null ? "body: ${beautifyJson(body)}" : ""}";
        if (kDebugMode) {
          Get.log(log);
        }
      } catch (e) {
        print(e);
      }
    }

    // CrashlyticsHelper.log(log);
  }

  void logResponse(Response response) {
    if (kDebugMode) {
      try {
        if (response.request.url.toString().contains('/auth/user/me')) {
          return;
        }
        final log = "-------- RESPONSE -----------\n"
            "url: ${response.request.url}\n"
            "statusCode: ${response.statusCode}\n"
            "token: ${response.request.headers['Authorization']}\n"
            "json: ${beautifyJson(response.body)}";
        if (kDebugMode) {
          Get.log(log);
        }
      } catch (e) {
        print(e);
      }
    }
    // CrashlyticsHelper.log(log);
  }
}

enum Method { post, get, put }
