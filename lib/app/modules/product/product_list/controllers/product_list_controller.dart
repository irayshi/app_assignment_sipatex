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

  void onRefresh() async {
    await ProductProvider.to.initProduct();
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
        String message;
        try {
          await ProductProvider.to.delete(id);
          Get.back();
          if (products.isEmpty) Get.back();
          message = 'Produk berhasil dihapus';
        } catch (e) {
          message = 'Error: saat menghapus product';
        }
        Get.rawSnackbar(message: message);
      },
    );
  }
}
