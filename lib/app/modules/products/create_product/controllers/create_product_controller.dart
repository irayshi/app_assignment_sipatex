import 'package:app_assignment_sipatex/app/data/models/product_model.dart';
import 'package:app_assignment_sipatex/app/data/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductController extends GetxController {
  final productCategoryCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final basePriceCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final storageOptionsCtrl = TextEditingController();
  final colorOptionsCtrl = TextEditingController();
  final displayCtrl = TextEditingController();
  final cPUCtrl = TextEditingController();
  final rearCameraCtrl = TextEditingController();
  final frontCameraCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final onClick = true.obs;

  @override
  void onClose() {
    productCategoryCtrl.dispose();
    nameCtrl.dispose();
    brandCtrl.dispose();
    descriptionCtrl.dispose();
    basePriceCtrl.dispose();
    stockCtrl.dispose();
    storageOptionsCtrl.dispose();
    colorOptionsCtrl.dispose();
    displayCtrl.dispose();
    cPUCtrl.dispose();
    rearCameraCtrl.dispose();
    frontCameraCtrl.dispose();
    super.onClose();
  }

  void create() {
    if (!formKey.currentState!.validate()) return;

    onClick.value = false;
    ProductProvider.to.create(
      Product(
        productCategory: productCategoryCtrl.text,
        name: nameCtrl.text,
        brand: brandCtrl.text,
        description: descriptionCtrl.text,
        basePrice: int.parse(basePriceCtrl.text),
        inStock: int.parse(stockCtrl.text) > 0,
        stock: int.parse(stockCtrl.text),
        storageOptions: storageOptionsCtrl.text.trim().split(','),
        colorOptions: colorOptionsCtrl.text.trim().split(','),
        display: displayCtrl.text,
        cPU: cPUCtrl.text,
        camera: Camera(
          frontCamera: frontCameraCtrl.text,
          rearCamera: rearCameraCtrl.text,
        ),
      ),
    );
    ProductProvider.to.onInit();
    Get.back();
    onClick.value = true;
    Get.rawSnackbar(message: 'Success');
  }
}
