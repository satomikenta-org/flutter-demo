import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class AuthController extends GetxController {

  bool isAuth() {
    return true;
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}