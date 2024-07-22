import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:app_assignment_sipatex/app/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  final users = <User>[].obs;

  @override
  void onInit() {
    ever(UserProvider.to.users, (data) {
      users.value = data;
    });
    super.onInit();
  }

  void onRefresh() {
    UserProvider.to.onInit();
  }

  void delete(int id) {
    Get.defaultDialog(
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.white,
      title: 'Alert',
      middleText: 'Apa anda yakin ingin menghapus data ini?',
      textConfirm: 'Iya',
      textCancel: 'Batal',
      onConfirm: () {
        UserProvider.to.delete(id);
        UserProvider.to.onInit();
        if (users.isEmpty) Get.back();
        Get.back();
      },
    );
  }
}
