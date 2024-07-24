import 'package:get/get.dart';

import '../controllers/create_user_controller.dart';

class CreateUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUserController>(
      () => CreateUserController(),
    );
  }
}
