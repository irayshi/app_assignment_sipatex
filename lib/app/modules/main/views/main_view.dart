import 'package:app_assignment_sipatex/app/data/services/auth_service.dart';
import 'package:app_assignment_sipatex/app/modules/main/views/home_view.dart';
import 'package:app_assignment_sipatex/app/modules/main/views/users_view.dart';
import 'package:app_assignment_sipatex/app/modules/main/views/profile_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.index.value,
          children: [
            const HomeView(),
            if (AuthService.to.user.role == 'admin') ...[
              const UsersView(),
            ],
            const ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.index.value,
          onTap: (index) => controller.index.value = index,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            if (AuthService.to.user.role == 'admin')
              const BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Users',
              ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
