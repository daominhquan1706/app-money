import 'package:get/get.dart';

class LifeCycleController extends SuperController {

  @override
  void onDetached() {
    print('app in onDetached');
  }

  @override
  void onInactive() {
    print('app in onInactive');
  }

  @override
  void onPaused() {
    print('app in onPaused');
  }

  @override
  void onResumed() {
    print('app in onResumed');
  }
}
