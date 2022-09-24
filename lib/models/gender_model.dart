import 'package:moneylover/models/base_model.dart';
import 'package:moneylover/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gender_model.g.dart';

@JsonSerializable()
class GenderModel extends BaseModel {
  @override
  String id;
  String gender;
  int userId;
  List<GenderModel> users;

  GenderModel({
    this.id,
    this.gender,
    this.userId,
    this.users,
  });
  factory GenderModel.fromJson(Map<String, dynamic> json) =>
      _$GenderModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenderModelToJson(this);
}
