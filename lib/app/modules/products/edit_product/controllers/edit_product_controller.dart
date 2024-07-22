import 'package:app_assignment_sipatex/app/data/models/product_model.dart';
import 'package:app_assignment_sipatex/app/data/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  final Product _product = Get.arguments;

  late final TextEditingController productCategoryCtrl;
  late final TextEditingController nameCtrl;
  late final TextEditingController brandCtrl;
  late final TextEditingController descriptionCtrl;
  late final TextEditingController basePriceCtrl;
  late final TextEditingController stockCtrl;
  late final TextEditingController storageOptionsCtrl;
  late final TextEditingController colorOptionsCtrl;
  late final TextEditingController displayCtrl;
  late final TextEditingController cPUCtrl;
  late final TextEditingController rearCameraCtrl;
  late final TextEditingController frontCameraCtrl;
  final formKey = GlobalKey<FormState>();
  final onClick = true.obs;

  @override
  void onInit() {
    productCategoryCtrl = TextEditingController(text: _product.productCategory);
    nameCtrl = TextEditingController(text: _product.name);
    brandCtrl = TextEditingController(text: _product.brand);
    descriptionCtrl = TextEditingController(text: _product.description);
    basePriceCtrl = TextEditingController(text: _product.basePrice.toString());
    stockCtrl = TextEditingController(text: _product.stock.toString());
    storageOptionsCtrl = TextEditingController(
        text: _product.storageOptions!.map((e) => e.trim()).join(', '));
    colorOptionsCtrl = TextEditingController(
        text: _product.colorOptions!.map((e) => e.trim()).join(', '));
    displayCtrl = TextEditingController(text: _product.display);
    cPUCtrl = TextEditingController(text: _product.cPU);
    rearCameraCtrl = TextEditingController(text: _product.camera!.rearCamera);
    frontCameraCtrl = TextEditingController(text: _product.camera!.frontCamera);
    super.onInit();
  }

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

  void edit() {
    if (!formKey.currentState!.validate()) return;

    onClick.value = false;
    ProductProvider.to.edit(
      Product(
        id: _product.id,
        featuredImage: _product.featuredImage,
        thumbnailImage: _product.thumbnailImage,
        productCategory: productCategoryCtrl.text,
        name: nameCtrl.text,
        brand: brandCtrl.text,
        description: descriptionCtrl.text,
        basePrice: int.parse(basePriceCtrl.text),
        inStock: int.parse(stockCtrl.text) > 0,
        stock: int.parse(stockCtrl.text),
        storageOptions:
            storageOptionsCtrl.text.split(',').map((e) => e.trim()).toList(),
        colorOptions:
            colorOptionsCtrl.text.split(',').map((e) => e.trim()).toList(),
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
