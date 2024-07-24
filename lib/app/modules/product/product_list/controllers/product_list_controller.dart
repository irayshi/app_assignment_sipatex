import 'package:app_assignment_sipatex/app/data/models/product_model.dart';
import 'package:app_assignment_sipatex/app/data/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  final products = <Product>[].obs;

  @override
  void onInit() {
    products.value = ProductProvider.to.products
        .where((product) => product.productCategory == Get.arguments)
        .toList();
    ever(ProductProvider.to.products, (data) {
      products.value = data
          .where((product) => product.productCategory == Get.arguments)
          .toList();
    });
    super.onInit();
  }

  void onRefresh() {
    ProductProvider.to.onInit();
  }

  void delete(int id) {
    Get.defaultDialog(
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.white,
      title: 'Alert',
      middleText: 'Apa anda yakin ingin menghapus data ini?',
      textConfirm: 'Iya',
      textCancel: 'Batal',
      onConfirm: () async {
        ProductProvider.to.delete(id);
        await ProductProvider.to.onInit();
        if (products.isEmpty) Get.back();
        Get.back();
      },
    );
  }
}
