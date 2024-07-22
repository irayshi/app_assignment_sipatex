import 'package:app_assignment_sipatex/app/data/services/auth_service.dart';
import 'package:app_assignment_sipatex/app/modules/home/views/widgets/bottom_navigation_widget.dart';
import 'package:app_assignment_sipatex/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Obx(
            () => Text(
              'Name: ${AuthService.to.user.displayName}',
              style: context.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => Text(
              'Email: ${AuthService.to.user.email}',
              style: context.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => Text(
              'Role: ${AuthService.to.user.role}',
              style: context.textTheme.titleMedium,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: AuthService.to.user.role == 'admin' ? 2 : 1,
        onTap: (index) {
          if (AuthService.to.user.role == 'admin') {
            if (index == 0) Get.offNamed(Routes.HOME);
            if (index == 1) Get.offNamed(Routes.USERS);
          } else {
            if (index == 0) Get.offNamed(Routes.HOME);
          }
        },
      ),
    );
  }
}
