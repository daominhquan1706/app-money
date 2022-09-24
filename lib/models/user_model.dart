import 'package:json_annotation/json_annotation.dart';
import 'package:moneylover/models/base_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends BaseModel {
  @override
  String id;
  String name;
  String email;
  int walletAccount;
  String partnerId;
  String status;
  int socialMediaId;
  int interestId;
  String profession;
  String address;
  String country;
  String birthdate;
  String token;
  String fullname;
  int genderId;
  String profilePhotoPath;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.fullname,
    this.walletAccount = 0,
    this.partnerId,
    this.token,
    this.status,
    this.socialMediaId,
    this.interestId,
    this.profession,
    this.address,
    this.country,
    this.birthdate,
    this.genderId,
    this.profilePhotoPath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
