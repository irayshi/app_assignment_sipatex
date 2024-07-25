import 'package:app_assignment_sipatex/app/data/providers/product_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final categories = <String>[].obs;

  @override
  void onInit() {
    ever(ProductProvider.to.products, (products) {
      categories.value =
          products.map((product) => product.productCategory).toSet().toList();
    });
    super.onInit();
  }

  void onRefresh() {
    ProductProvider.to.initProduct();
  }
}
