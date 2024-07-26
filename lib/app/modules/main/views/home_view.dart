import 'package:app_assignment_sipatex/app/data/services/auth_service.dart';
import 'package:app_assignment_sipatex/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: Colors.white,
        onRefresh: () async => controller.onRefresh(),
        child: Obx(
          () => controller.categories.isEmpty
              ? const Center(
                  child: Text('Tidak ada data'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return ListTile(
                      onTap: () => Get.toNamed(
                        Routes.PRODUCT_LIST,
                        arguments: category,
                      ),
                      title: Text(category),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: Obx(
        () => Visibility(
          visible: AuthService.to.user.role == 'admin',
          child: FloatingActionButton(
            heroTag: 'home',
            tooltip: 'Add Product',
            onPressed: () => Get.toNamed(Routes.CREATE_PRODUCT),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
