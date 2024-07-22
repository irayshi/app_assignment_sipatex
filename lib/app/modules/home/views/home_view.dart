import 'package:app_assignment_sipatex/app/data/services/auth_service.dart';
import 'package:app_assignment_sipatex/app/modules/home/views/widgets/bottom_navigation_widget.dart';
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
        onRefresh: () async => controller.onRefresh(),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return ListTile(
                onTap: () => Get.toNamed(
                  Routes.PRODUCTS,
                  arguments: category,
                ),
                title: Text(category!),
              );
            },
          ),
        ),
      ),
      floatingActionButton: AuthService.to.user.role == 'admin'
          ? FloatingActionButton(
              tooltip: 'Add Product',
              onPressed: () {
                Get.toNamed(Routes.CREATE_PRODUCT);
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: 0,
        onTap: (index) {
          if (AuthService.to.user.role == 'admin') {
            if (index == 1) Get.offNamed(Routes.USERS);
            if (index == 2) Get.offNamed(Routes.PROFILE);
          } else {
            if (index == 1) Get.offNamed(Routes.PROFILE);
          }
        },
      ),
    );
  }
}
