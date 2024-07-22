import 'package:app_assignment_sipatex/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

import '../controllers/users_controller.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersController>(
      () => UsersController(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
  }
}
