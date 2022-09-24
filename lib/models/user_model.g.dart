// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    fullname: json['fullname'] as String,
    walletAccount: json['walletAccount'] as int,
    partnerId: json['partnerId'] as String,
    token: json['token'] as String,
    status: json['status'] as String,
    socialMediaId: json['socialMediaId'] as int,
    interestId: json['interestId'] as int,
    profession: json['profession'] as String,
    address: json['address'] as String,
    country: json['country'] as String,
    birthdate: json['birthdate'] as String,
    genderId: json['genderId'] as int,
    profilePhotoPath: json['profilePhotoPath'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'walletAccount': instance.walletAccount,
      'partnerId': instance.partnerId,
      'status': instance.status,
      'socialMediaId': instance.socialMediaId,
      'interestId': instance.interestId,
      'profession': instance.profession,
      'address': instance.address,
      'country': instance.country,
      'birthdate': instance.birthdate,
      'token': instance.token,
      'fullname': instance.fullname,
      'genderId': instance.genderId,
      'profilePhotoPath': instance.profilePhotoPath,
    };
