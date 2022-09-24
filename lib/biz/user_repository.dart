import 'package:moneylover/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneylover/models/base_model.dart';
import 'package:moneylover/repositories/base_repository.dart';
import 'package:moneylover/services/api_service.dart';
import 'package:moneylover/services/data_request.dart';

abstract class IUserRepository with MBMixinRepository<UserModel> {
  Future<void> fetchMe({@required DataRequest<UserModel> dataRequest});
  Future<UserModel> fetchMeAsync();

  Future<void> fetchLanguages({@required DataRequest<void> dataRequest});

  Future<bool> markLatestActionHandled();
  Future<UserModel> officeMerge({String usertoken, String towerId});
  Future<UserModel> freeUpdateUser({String id, Map<String, dynamic> data});
}

class UserRepository extends IUserRepository {
  final IApiService _apiService = Get.find();

  final String _subPath = '/auth';

  @override
  Future<void> fetchMe({DataRequest<UserModel> dataRequest}) async {
    await _apiService.requestApi(
      '$_subPath/user/me',
      method: Method.get,
      query: {
        "populate[]": ["membership", "membershipuser"]
      },
      onSuccess: (response) {
        UserModel data = UserModel.fromJson(response);
        dataRequest?.onSuccess(data);
      },
      onFailure: (int code, String message, response) {
        dataRequest?.onFailure(code, message, response);
      },
      onErrorHttp: (e) {
        dataRequest?.onErrorHttp(e);
      },
    );
  }

  @override
  Future<UserModel> fetchMeAsync() async {
    final response = await apiService.get(
      '$_subPath/user/me',
      query: {
        "populate[]": ["membership", "membershipuser"]
      },
    );
    if (response.isOk) {
      return decoder(response.body);
    }
    return null;
  }

  @override
  Future<void> fetchLanguages({DataRequest<void> dataRequest}) async {
    await _apiService.requestApi(
      '/localization',
      method: Method.get,
      onSuccess: (response) {
        // UserModel data = UserModel.fromJson(response);
        // dataRequest?.onSuccess(data);
      },
      onFailure: (int code, String message, response) {
        dataRequest?.onFailure(code, message, response);
      },
      onErrorHttp: (e) {
        dataRequest?.onErrorHttp(e);
      },
    );
  }

  @override
  Future<bool> markLatestActionHandled() async {
    final response =
        await _apiService.put('/auth/user/markLatestActionHandled');
    return response.isOk;
  }

  @override
  IApiService get apiService => _apiService;

  @override
  BaseModel Function(Map<String, dynamic> p1) get decoder =>
      (json) => UserModel.fromJson(json);

  @override
  String get path => '/auth/user';

  @override
  Future<UserModel> officeMerge({String usertoken, String towerId}) async {
    final response = await _apiService.post('/userauth/officeMerge', body: {
      'usertoken': usertoken,
      'towerId': towerId,
    });

    if (response != null && response.isOk) {
      return decoder(response.body);
    }
    return null;
  }

  @override
  Future<UserModel> freeUpdateUser(
      {String id, Map<String, dynamic> data}) async {
    final response = await apiService.put(
      '$_subPath/user/$id',
      body: data,
    );
    if (response.isOk) {
      return decoder(response.body);
    }
    return null;
  }
}
