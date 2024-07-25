import 'package:app_assignment_sipatex/app/data/models/product_model.dart';
import 'package:app_assignment_sipatex/app/data/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  final Product _product = Get.arguments;

  late final TextEditingController productCategoryCtrl;
  late final TextEditingController nameCtrl;
  late final TextEditingController brandCtrl;
  late final TextEditingController descriptionCtrl;
  late final MoneyMaskedTextController basePriceCtrl;
  late final MoneyMaskedTextController stockCtrl;
  late final TextEditingController storageOptionsCtrl;
  late final TextEditingController colorOptionsCtrl;
  late final TextEditingController displayCtrl;
  late final TextEditingController cPUCtrl;
  late final TextEditingController gPUCtrl;
  late final TextEditingController rearCameraCtrl;
  late final TextEditingController frontCameraCtrl;
  final formKey = GlobalKey<FormState>();
  final onClick = true.obs;
  bool productExists = false;

  @override
  void onInit() {
    productCategoryCtrl = TextEditingController(text: _product.productCategory);
    nameCtrl = TextEditingController(text: _product.name);
    brandCtrl = TextEditingController(text: _product.brand);
    descriptionCtrl = TextEditingController(text: _product.description);
    basePriceCtrl = MoneyMaskedTextController(
      decimalSeparator: '',
      precision: 0,
      leftSymbol: 'Rp ',
      initialValue: _product.basePrice.toDouble(),
    );
    stockCtrl = MoneyMaskedTextController(
      decimalSeparator: '',
      precision: 0,
      initialValue: _product.stock.toDouble(),
    );
    storageOptionsCtrl = TextEditingController(
        text: _product.storageOptions?.map((e) => e.trim()).join(', '));
    colorOptionsCtrl = TextEditingController(
        text: _product.colorOptions?.map((e) => e.trim()).join(', '));
    displayCtrl = TextEditingController(text: _product.display);
    cPUCtrl = TextEditingController(text: _product.cPU);
    gPUCtrl = TextEditingController(text: _product.gPU);
    rearCameraCtrl = TextEditingController(text: _product.camera?.rearCamera);
    frontCameraCtrl = TextEditingController(text: _product.camera?.frontCamera);
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
    gPUCtrl.dispose();
    rearCameraCtrl.dispose();
    frontCameraCtrl.dispose();
    super.onClose();
  }

  void edit() async {
    if (!formKey.currentState!.validate()) return;

    onClick.value = false;
    String message;
    try {
      if (nameCtrl.text != _product.name) {
        if (productExists =
            await ProductProvider.to.productExists(nameCtrl.text)) {
          formKey.currentState!.validate();
          return;
        }
      }
      await ProductProvider.to.edit(
        Product(
          id: _product.id,
          featuredImage: _product.featuredImage,
          thumbnailImage: _product.thumbnailImage,
          productCategory: productCategoryCtrl.text,
          name: nameCtrl.text,
          brand: brandCtrl.text == '' ? null : brandCtrl.text,
          description: descriptionCtrl.text,
          basePrice: basePriceCtrl.numberValue.toInt(),
          inStock: stockCtrl.numberValue.toInt() > 0,
          stock: stockCtrl.numberValue.toInt(),
          storageOptions: storageOptionsCtrl.text == ''
              ? null
              : storageOptionsCtrl.text
                  .split(',')
                  .map((e) => e.trim())
                  .toList(),
          colorOptions: colorOptionsCtrl.text == ''
              ? null
              : colorOptionsCtrl.text.split(',').map((e) => e.trim()).toList(),
          display: displayCtrl.text == '' ? null : displayCtrl.text,
          cPU: cPUCtrl.text == '' ? null : cPUCtrl.text,
          gPU: gPUCtrl.text == '' ? null : gPUCtrl.text,
          camera: Camera(
            frontCamera:
                frontCameraCtrl.text == '' ? null : frontCameraCtrl.text,
            rearCamera: rearCameraCtrl.text == '' ? null : rearCameraCtrl.text,
          ),
        ),
      );
      Get.back();
      if (productCategoryCtrl.text != _product.productCategory) {
        return Get.back();
      }
      message = 'Produk berhasil diedit';
    } catch (e) {
      message = 'Error: saat mengedit product';
    }
    Get.rawSnackbar(message: message);
    onClick.value = true;
  }
}
