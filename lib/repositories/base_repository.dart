import 'dart:convert';
import 'package:moneylover/common/error/handle_exception.dart';
import 'package:moneylover/models/base_model.dart';
import 'package:moneylover/models/utils.dart';
import 'package:moneylover/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Config
const int defaultPage = 1;
const int defaultPageSize = 30;
const String suggestSort = '-createdAt';

mixin MBMixinRepository<T extends BaseModel> {
  // Vars
  String get path;
  IApiService get apiService => Get.find();
  BaseModel Function(Map<String, dynamic>) get decoder;
  final BaseModelEncoder<T> _encoder = (input) => (input as dynamic).toJson();

  Future<ListModel<T>> find({
    String overridePath,
    Map<String, dynamic> query = const {},
    List<String> populate,
    int page = defaultPage,
    int pageSize = defaultPageSize,
    List<String> searchFields,
    String search,
  }) async {
    Map<String, String> finalQuery = {};
    if (query.isNotEmpty) {
      finalQuery = Map.fromEntries(query.entries.map((ent) {
        if (ent.value is Map || ent.value is List) {
          return MapEntry(ent.key, jsonEncode(ent.value));
        }
        return MapEntry(ent.key, '${ent.value}');
      }));
    }
    final response = await apiService.get(
      overridePath ?? path,
      query: {
        ...finalQuery,
        'populate[]': populate,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'searchFields': searchFields,
        'search': search,
      }..removeWhere((_, value) => value == null),
    );
    if (response.isOk) {
      return ListModel<T>.fromJson(response.body, decoder: decoder);
    }
    return null;
  }

  Future<int> count({
    String overridePath,
    Map<String, dynamic> query = const {},
  }) async {
    Map<String, String> finalQuery = {};
    if (query.isNotEmpty) {
      finalQuery = Map.fromEntries(query.entries.map((ent) {
        if (ent.value is Map || ent.value is List) {
          return MapEntry(ent.key, jsonEncode(ent.value));
        }
        return MapEntry(ent.key, '${ent.value}');
      }));
    }
    final response = await apiService.get(
      '${overridePath ?? path}/count',
      query: finalQuery..removeWhere((_, value) => value == null),
    );
    if (response.isOk && response.body is int) {
      return response.body as int;
    }
    return 0;
  }

  Future<T> get(String id,
      {List<String> populate,
      String overridePath,
      Map<String, dynamic> additionalParams = const {}}) async {
    final response = await apiService.get(
      '${overridePath ?? path}/$id',
      query: {
        'populate[]': populate,
        ...additionalParams,
      }..removeWhere((_, value) => value == null),
    );
    if (response.isOk) {
      debugPrint(response.request.headers.toString());
      return decoder(response.body);
    }
    return null;
  }

  Future<T> create(
    T input, {
    String overridePath,
    Map<String, dynamic> additionalParams = const {},
    bool needThrowException = false,
  }) async {
    final response = await apiService.post(
      overridePath ?? path,
      body: <String, dynamic>{
        ...(input as dynamic).toJson(),
        ...additionalParams,
      }..removeWhere((_, value) => value == null),
    );
    if (response.isOk) {
      return decoder(response.body);
    }
    if (needThrowException) {
      return ExceptionHandler.throwError(response);
    }
    return null;
  }

  // Put
  Future<T> update(
    T input, {
    String overridePath,
    Map<String, dynamic> additionalParams = const {},
    bool needThrowException = false,
  }) async {
    final response = await apiService.put(
      '${overridePath ?? path}/${input.id}',
      body: {
        ..._encoder(input)..removeFreezedKeys(),
        ...additionalParams,
      },
    );
    if (response.isOk) {
      return decoder(response.body ?? {});
    }
    if (needThrowException) {
      return ExceptionHandler.throwError(response);
    }
    return null;
  }

  Future<T> patch(T input, {String overridePath}) async {
    final response = await apiService.patch(
      '${overridePath ?? path}/${input.id}',
      body: _encoder(input)..removeFreezedKeys(),
    );
    if (response.isOk) {
      return decoder(response.body ?? {});
    }
    return null;
  }

  Future<bool> delete(String id, {String overridePath}) async {
    final response = await apiService.delete('${overridePath ?? path}/$id');
    return response.isOk;
  }
}

class MBDefaultRepository<T extends BaseModel> with MBMixinRepository<T> {
  @override
  final IApiService apiService;

  @override
  final String path;

  @override
  final BaseModelDecoder decoder;

  MBDefaultRepository({
    @required this.apiService,
    @required this.path,
    @required this.decoder,
  });
}
