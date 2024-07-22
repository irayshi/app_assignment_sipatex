import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  const DetailProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Text(
            controller.product.name!,
            style: context.textTheme.displaySmall,
          ),
          const SizedBox(height: 10),
          Text(
            '\$${controller.product.basePrice}',
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            controller.product.description!,
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(height: 30),
          Text('Category: ${controller.product.productCategory}'),
          const SizedBox(height: 10),
          Text('Brand: ${controller.product.brand}'),
          const SizedBox(height: 10),
          Text('Stock: ${controller.product.stock}'),
          const SizedBox(height: 10),
          Text('Storage: ${controller.product.storageOptions}'),
          const SizedBox(height: 10),
          Text('Color: ${controller.product.colorOptions}'),
          const SizedBox(height: 10),
          Text('Display: ${controller.product.display}'),
          const SizedBox(height: 10),
          Text('CPU: ${controller.product.cPU}'),
          const SizedBox(height: 10),
          Text('Rear Camera: ${controller.product.camera!.rearCamera}'),
          const SizedBox(height: 10),
          Text('Front Camera: ${controller.product.camera!.frontCamera}'),
        ],
      ),
    );
  }
}
