import 'package:app_assignment_sipatex/services/auth_service.dart';
import 'package:app_assignment_sipatex/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final obscureText = false.obs;
  final loadLogin = false.obs;
  final loginKey = GlobalKey<FormState>();
  Future<void> login() async {
    if (loadLogin.value) return;
    if (!loginKey.currentState!.validate()) return;
    loadLogin.value = true;
    try {
      await AuthService.to.login(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );
    } catch (e) {
      MySnackbar.error(message: e.toString());
    }
    loadLogin.value = false;
  }
}
