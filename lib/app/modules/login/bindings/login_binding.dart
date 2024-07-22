import 'package:app_assignment_sipatex/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
  }
}
