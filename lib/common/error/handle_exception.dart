import 'package:get/get.dart';
import 'auth_error.dart';

class ExceptionHandler {
  static dynamic throwError(Response response, {String tag}) {
    final result = response.body;
    final message = result['message'];
    // FIXME: Unknown
    if (result is! Map) {
      return null;
    }
    if (message == 'DUPLICATED_RECORD') {
      throw const DuplicatedRecordException();
    }
    if (message == 'INVALID_EMAIL_PASSWORD') {
      throw const InvalidEmailOrPasswordException();
    }

    if(message == 'NOT_FOUND') {
      throw const NotFoundException();
    }
    if(message == 'OVER_LIMIT') {
      throw const OverLimit();
    }
    if(message == 'OVER_LIMIT_MEMBER') {
      throw const OverLimitMember();
    }
    // -- And More --
    // -- And More --
    throw Exception('An error occurred, please try again!');
  }
}
