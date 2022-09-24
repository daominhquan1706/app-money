import 'package:moneylover/models/user_model.dart';
import 'package:get/get.dart';

class UserAuthController extends GetxController {
  final Rx<UserModel> _user = UserModel(
    id: '1',
    email: '',
    fullname: '',
  ).obs;
  UserModel get user => _user.value;
}
