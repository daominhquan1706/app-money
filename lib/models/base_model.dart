import 'package:flutter/foundation.dart';

abstract class BaseModel  {
  String get id;
}

typedef BaseModelDecoder<T extends BaseModel> = T Function(
    Map<String, dynamic>);
typedef BaseModelEncoder<T> = Map<String, dynamic> Function(T);

// Generic
class ListModel<T extends BaseModel> {
  List<T> rows;
  int total;
  int page;
  int pageSize;
  int totalPages;
  // adapt
  bool get isLastPage =>
      page != null && totalPages != null && page >= totalPages;

  ListModel({
    this.rows,
    this.total,
    this.page,
    this.pageSize,
    this.totalPages,
  });

  factory ListModel.fromJson(
    Map<String, dynamic> json, {
    @required BaseModelDecoder<T> decoder,
  }) {
    return ListModel(
      total: json['total'] as int,
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      totalPages: json['totalPages'] as int,
      rows: (json['rows'] as List)
          ?.map((e) => e == null ? null : decoder(e as Map<String, dynamic>))
          ?.toList(),
    );
  }
  Map<String, dynamic> toJson({
    @required BaseModelEncoder<T> decoder,
  }) {
    Map<String, dynamic> json = {};
    json['total'] = total;
    json['page'] = page;
    json['pageSize'] = pageSize;
    json['totalPages'] = totalPages;
    json['rows'] = rows.map((e) => decoder(e)).toList();
    return json;
  }

  void appendPage(ListModel<T> newList) {
    if (newList == null) return;
    rows?.addAll(newList.rows ?? []);
    total = newList.total ?? total;
    page = newList.page ?? page;
    pageSize = newList.pageSize ?? pageSize;
    totalPages = newList.totalPages ?? totalPages;
  }
}
