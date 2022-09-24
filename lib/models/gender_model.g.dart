// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenderModel _$GenderModelFromJson(Map<String, dynamic> json) {
  return GenderModel(
    id: json['id'] as String,
    gender: json['gender'] as String,
    userId: json['userId'] as int,
    users: (json['users'] as List)
        ?.map((e) =>
            e == null ? null : GenderModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GenderModelToJson(GenderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gender': instance.gender,
      'userId': instance.userId,
      'users': instance.users,
    };
