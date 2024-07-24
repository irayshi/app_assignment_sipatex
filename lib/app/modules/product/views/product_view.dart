import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});
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
            controller.product.name,
            style: context.textTheme.displaySmall,
          ),
          const SizedBox(height: 10),
          Text(
            NumberFormat.currency(
              locale: 'id',
              symbol: 'Rp ',
              decimalDigits: 0,
            ).format(
              controller.product.basePrice,
            ),
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            controller.product.description,
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(height: 30),
          Text('Category: ${controller.product.productCategory}'),
          const SizedBox(height: 10),
          if (controller.product.brand != null) ...[
            Text('Brand: ${controller.product.brand}'),
            const SizedBox(height: 10),
          ],
          Text('Stock: ${NumberFormat.currency(
            locale: 'id',
            symbol: '',
            decimalDigits: 0,
          ).format(
            controller.product.stock,
          )}'),
          const SizedBox(height: 10),
          if (controller.product.storageOptions != null &&
              controller.product.storageOptions!.isNotEmpty) ...[
            Text('Storage: ${controller.product.storageOptions}'),
            const SizedBox(height: 10),
          ],
          if (controller.product.colorOptions != null &&
              controller.product.colorOptions!.isNotEmpty) ...[
            Text('Color: ${controller.product.colorOptions}'),
            const SizedBox(height: 10),
          ],
          if (controller.product.display != null) ...[
            Text('Display: ${controller.product.display}'),
            const SizedBox(height: 10),
          ],
          if (controller.product.cPU != null) ...[
            Text('CPU: ${controller.product.cPU}'),
            const SizedBox(height: 10),
          ],
          if (controller.product.gPU != null) ...[
            Text('GPU: ${controller.product.gPU}'),
            const SizedBox(height: 10),
          ],
          if (controller.product.camera != null) ...[
            if (controller.product.camera!.frontCamera != null) ...[
              Text('Rear Camera: ${controller.product.camera!.rearCamera}'),
              const SizedBox(height: 10),
            ],
            if (controller.product.camera!.frontCamera != null)
              Text('Front Camera: ${controller.product.camera!.frontCamera}'),
          ],
        ],
      ),
    );
  }
}
