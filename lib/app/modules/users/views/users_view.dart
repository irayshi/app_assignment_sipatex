import 'package:app_assignment_sipatex/app/modules/home/views/widgets/bottom_navigation_widget.dart';
import 'package:app_assignment_sipatex/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.onRefresh(),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return ListTile(
                onTap: () => Get.toNamed(
                  Routes.DETAIL_USER,
                  arguments: user,
                ),
                title: Text(user.displayName!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => Get.toNamed(
                        Routes.EDIT_USER,
                        arguments: user,
                      ),
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () => controller.delete(user.id!),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add User',
        onPressed: () => Get.toNamed(Routes.CREATE_USER),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Get.offNamed(Routes.HOME);
          if (index == 2) Get.offNamed(Routes.PROFILE);
        },
      ),
    );
  }
}
