import 'package:app_assignment_sipatex/app/data/services/auth_service.dart';
import 'package:app_assignment_sipatex/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.onRefresh(),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return ListTile(
                onTap: () => Get.toNamed(
                  Routes.PRODUCT,
                  arguments: product,
                ),
                title: Text(
                  product.name,
                  style: context.textTheme.titleLarge,
                ),
                subtitle: Text('${NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(product.basePrice)}\nStock:\t${NumberFormat.currency(
                  locale: 'id',
                  symbol: '',
                  decimalDigits: 0,
                ).format(product.stock)}'),
                trailing: AuthService.to.user.role == 'admin'
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => Get.toNamed(
                              Routes.EDIT_PRODUCT,
                              arguments: product,
                            ),
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => controller.delete(product.id!),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      )
                    : null,
              );
            },
          ),
        ),
      ),
    );
  }
}
