import 'package:app_assignment_sipatex/app/data/models/product_model.dart';
import 'package:app_assignment_sipatex/app/data/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class CreateProductController extends GetxController {
  final productCategoryCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final basePriceCtrl = MoneyMaskedTextController(
    decimalSeparator: '',
    precision: 0,
    leftSymbol: 'Rp ',
    initialValue: 0,
  );
  final stockCtrl = MoneyMaskedTextController(
    decimalSeparator: '',
    precision: 0,
    initialValue: 0,
  );
  final storageOptionsCtrl = TextEditingController();
  final colorOptionsCtrl = TextEditingController();
  final displayCtrl = TextEditingController();
  final cPUCtrl = TextEditingController();
  final gPUCtrl = TextEditingController();
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
    gPUCtrl.dispose();
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
        brand: brandCtrl.text == '' ? null : brandCtrl.text,
        description: descriptionCtrl.text,
        basePrice: basePriceCtrl.numberValue.toInt(),
        inStock: stockCtrl.numberValue.toInt() > 0,
        stock: stockCtrl.numberValue.toInt(),
        storageOptions: storageOptionsCtrl.text == ''
            ? null
            : storageOptionsCtrl.text.split(',').map((e) => e.trim()).toList(),
        colorOptions: colorOptionsCtrl.text == ''
            ? null
            : colorOptionsCtrl.text.split(',').map((e) => e.trim()).toList(),
        display: displayCtrl.text == '' ? null : displayCtrl.text,
        cPU: cPUCtrl.text == '' ? null : cPUCtrl.text,
        gPU: gPUCtrl.text == '' ? null : gPUCtrl.text,
        camera: Camera(
          frontCamera: frontCameraCtrl.text == '' ? null : frontCameraCtrl.text,
          rearCamera: rearCameraCtrl.text == '' ? null : rearCameraCtrl.text,
        ),
      ),
    );
    ProductProvider.to.onInit();
    Get.back();
    onClick.value = true;
    Get.rawSnackbar(message: 'Success');
  }
}
