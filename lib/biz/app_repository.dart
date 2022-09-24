import 'package:get/get.dart';
import 'package:moneylover/services/api_service.dart';

abstract class IAppRepository {
  Future<Map<String, dynamic>> generateUploadSignature(
      String contentType, String fileName);

  Future<dynamic> setFirebaseToken(String token, String platform);

  Future<int> countUnreadNoti();
}

class AppRepository implements IAppRepository {
  final IApiService _apiService = Get.find();

  @override
  Future<Map<String, dynamic>> generateUploadSignature(
      String contentType, String fileName) async {
    final response = await _apiService.get(
      '/auth/media/generatePresignedUrl',
      query: {
        'contentType': contentType,
        'fileName': fileName,
      }..removeWhere((key, value) => value == null),
      decoder: (json) => json,
    );
    return response.isOk ? response.body : null;
  }

  @override
  Future<dynamic> setFirebaseToken(String token, String platform) async {
    final result = await _apiService.post<Map>(
      '/auth/notificationtoken/',
      // headers: requiredHeaders,
      body: {'token': token, 'platform': platform},
      decoder: (json) => json,
    );
    return result;
  }

  @override
  Future<int> countUnreadNoti() async {
    final response = await _apiService.get(
      '/auth/notification/count',
      // headers: requiredHeaders,
      decoder: (data) {
        if (data is int) return data;
        if (data is Map) return data['total'] as int;
        return 0;
      },
    );
    return response.body;
  }

  @override
  Future<Map<String, dynamic>> checkForUpdate() async {
    final response = await _apiService.get(
      '/auth/config/single',
    );
    if (response.isOk) {
      return response.body;
    }
    return null;
  }
}
