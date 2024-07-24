import 'package:app_assignment_sipatex/app/modules/main/controllers/users_controller.dart';
import 'package:get/get.dart';

import '../controllers/product_list_controller.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListController>(
      () => ProductListController(),
    );
    Get.lazyPut<UsersController>(
      () => UsersController(),
    );
  }
}
