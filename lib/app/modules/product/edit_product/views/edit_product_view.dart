import 'package:app_assignment_sipatex/app/core/values/colors.dart';
import 'package:app_assignment_sipatex/app/modules/main/controllers/home_controller.dart';
import 'package:app_assignment_sipatex/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/edit_product_controller.dart';

class EditProductView extends GetView<EditProductController> {
  const EditProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.nameCtrl,
              onChanged: (value) {
                if (controller.productExists) {
                  controller.productExists = false;
                }
              },
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                } else if (controller.productExists) {
                  return 'Name is already exists';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.descriptionCtrl,
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Autocomplete<String>(
              initialValue: controller.productCategoryCtrl.value,
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text.trim().isEmpty) {
                  return List.empty();
                }
                return Get.find<HomeController>()
                    .categories
                    .where((category) => category
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                    .cast<String>();
              },
              onSelected: (option) =>
                  controller.productCategoryCtrl.text = option,
              fieldViewBuilder: (
                context,
                textEditingController,
                focusNode,
                onFieldSubmitted,
              ) {
                return TextFormField(
                  focusNode: focusNode,
                  controller: textEditingController,
                  onChanged: (value) =>
                      controller.productCategoryCtrl.text = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Category is required';
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Brand',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.brandCtrl,
            ),
            const SizedBox(height: 20),
            const Text(
              'Price',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.basePriceCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Price is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Stock',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.stockCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Stock is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Storage Options',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.storageOptionsCtrl,
              decoration: const InputDecoration(
                helperText: 'Separate options with commas',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Color Options',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.colorOptionsCtrl,
              decoration: const InputDecoration(
                helperText: 'Separate options with commas',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Display',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.displayCtrl,
            ),
            const SizedBox(height: 20),
            const Text(
              'CPU',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.cPUCtrl,
            ),
            const SizedBox(height: 20),
            ...[
              const Text(
                'GPU',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.gPUCtrl,
              ),
              const SizedBox(height: 20),
            ],
            const Text(
              'Rear Camera',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.rearCameraCtrl,
            ),
            const SizedBox(height: 20),
            const Text(
              'Front Camera',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.frontCameraCtrl,
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              buttonColor: controller.onClick.value ? null : grey,
              textButton: controller.onClick.value ? 'Edit' : 'Loading...',
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              onTap: controller.onClick.value ? () => controller.edit() : null,
              width: double.infinity,
              height: 40,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
