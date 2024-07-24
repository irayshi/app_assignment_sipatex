import 'package:app_assignment_sipatex/app/data/providers/product_provider.dart';
import 'package:app_assignment_sipatex/app/data/providers/user_provider.dart';
import 'package:app_assignment_sipatex/app/modules/main/controllers/home_controller.dart';
import 'package:app_assignment_sipatex/app/modules/main/controllers/users_controller.dart';
import 'package:app_assignment_sipatex/app/modules/main/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ProductProvider>(
      () => ProductProvider(),
    );
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.lazyPut<UsersController>(
      () => UsersController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
