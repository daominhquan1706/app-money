// This file content Global Controller -> permanent: true

import 'dart:convert';
import 'dart:io';

import 'package:moneylover/biz/app_repository.dart';
import 'package:moneylover/biz/user_repository.dart';
import 'package:moneylover/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:moneylover/biz/constants.dart';
import 'package:moneylover/common/dialog/dialog_utils.dart';
import 'package:moneylover/envs/base.dart';
import 'package:moneylover/routes/app_pages.dart';
import 'package:moneylover/services/api_service.dart';
import 'package:moneylover/services/data_request.dart';

class SuntecNavigatorObserver extends NavigatorObserver {
  // @override
  // void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {}

  @override
  void didPop(Route route, Route previousRoute) {
    if (route.settings?.name?.isNotEmpty == true) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
    super.didPop(route, previousRoute);
  }
}

class AppController extends GetxService {
  final IEnviroment env;
  IApiService get apiService => Get.find();

  AppController({this.env}) {
    String token = GetStorage().read<String>(Constants.TOKEN_KEY);
    bool isAuthenticated = token?.isNotEmpty == true;
    debugPrint("token: $token");
    if (isAuthenticated) {
      apiService.markAuthorized(token);
    }

    _startHookRequest();
  }

  // Hook requests
  void _startHookRequest() {
    if (apiService is ApiService) {
      final service = apiService as ApiService;
      service.connector.httpClient.addResponseModifier((request, response) {
        if ([502, 503].contains(response?.statusCode) || response == null) {
          Get.log(request.headers['Authorization']);
          EasyLoading.dismiss();
          DialogUtils.showInternalServerErrorMessage();
          return null;
        }
        return response;
      });
    }
  }

  IAppRepository get _repo => Get.find();
  IUserRepository get _userRepo => Get.find();

  Future<void> authenticatedLoad() async {
    final user = await _userRepo.fetchMeAsync();
    if (user != null) {
      notifyUserUpdated(user);
    }
  }

  Future<void> saveToken(UserModel auth, {bool isNeedOverride = true}) async {
    final box = GetStorage();
    if (isNeedOverride && auth?.token?.isNotEmpty == true) {
      await box
          .write(Constants.TOKEN_KEY, auth.token)
          .then((_) => print('Constants.TOKEN_KEY had been written'));
    }
    if (auth?.token?.isNotEmpty == true &&
        (box.read(Constants.TOKEN_KEY) == null ||
            box.read<String>(Constants.TOKEN_KEY).isEmpty == true)) {
      await box
          .write(Constants.TOKEN_KEY, auth.token)
          .then((_) => print('Constants.TOKEN_KEY had been re-written'));
    }
    final token = box.read<String>(Constants.TOKEN_KEY);
    if (token?.isNotEmpty == true) {
      apiService.markAuthorized(token);
    }
    // String token = GetStorage().read<String>(Constants.TOKEN_KEY);
    return notifyUserUpdated(auth, isNeedOverride: isNeedOverride);
  }

  Future<void> clearToken() async {
    userRx.value = null;
    apiService.markAuthorized(null);
    final box = GetStorage();
    await box.remove(Constants.TOKEN_KEY);
    await box.remove(Constants.USER_KEY);
    // return box.erase();
  }

  Future<void> refreshUserData() async {
    await fetchMe(
        dataRequest: DataRequest<UserModel>(onSuccess: (UserModel model) async {
      notifyUserUpdated(model);
    }, onFailure: (code, msg, _) {
      Get.offNamed(Routes.login);
    }, onErrorHttp: (errorMsg) {
      Get.offNamed(Routes.login);
    }));
  }

  Future<void> notifyUserUpdated(UserModel newData,
      {bool isNeedOverride = true}) async {
    if (newData == null) return;

    updateUser(newData, isNeedOverride: isNeedOverride);
  }

  Future<void> updateUser(UserModel newData,
      {bool isNeedOverride = true}) async {
    UserModel auth = loadUser();
    if (auth == null) {
      auth = newData;
    } else {
      // auth = auth.copyNotNull(newData);
    }
    if (auth?.token?.isNotEmpty == true) {
      apiService.markAuthorized(auth.token);
    }
    userRx.value = auth;
    if (isNeedOverride) {
      await saveUser(auth);
    }
  }

  Future<UserModel> freeUpdateUser({Map<String, dynamic> data}) async {
    if (userRx.value != null) {
      final user = await _userRepo.freeUpdateUser(
        id: userRx.value.id,
        data: data,
      );
      if (user != null) {
        await updateUser(user);
      }
      return user;
    }

    return null;
  }

  bool shouldShowConfirmCorporate = false;

  final userRx = Rx<UserModel>(null);
  UserModel get currentUser => userRx.value;
  UserModel loadUser() {
    final userDataString = GetStorage().read<String>(Constants.USER_KEY);
    if (userDataString?.isNotEmpty == true) {
      return UserModel.fromJson(json.decode(userDataString));
    }
    return null;
  }

  Future<void> saveUser(UserModel user) async {
    userRx.value = user;
    return await GetStorage()
        .write(Constants.USER_KEY, json.encode(user.toJson()));
  }

  Future<void> fetchMe({DataRequest<UserModel> dataRequest}) {
    return _userRepo.fetchMe(dataRequest: dataRequest);
  }

  Future<void> logout() async {
    clearToken();
    Get.offAllNamed(Routes.login);
  }

  Future<bool> checkDeepLinks(String url) async {
    return false;
  }
}

// MARK: - MULTI-THREADING
Future<int> _upload(Map params) async {
  final String uploadEndpoint = params['uploadEndpoint'];
  final String contentType = params['contentType'];
  final file = params['file'];
  final request = http.StreamedRequest('PUT', Uri.parse(uploadEndpoint))
    ..headers.addAll({'Content-Type': contentType});
  if (file is File) {
    request.contentLength = (await file.readAsBytes()).length;
    file.openRead().listen((chunk) {
      print(chunk.length);
      request.sink.add(chunk);
    }, onDone: () {
      request.sink.close();
    });
  }
  final http.StreamedResponse streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);
  return response.statusCode;
}
