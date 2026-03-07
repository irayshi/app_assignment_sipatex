import 'package:app_assignment_sipatex/services/auth_service.dart';
import 'package:app_assignment_sipatex/widgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    nameCtrl.dispose();
    confirmPasswordCtrl.dispose();
  }

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final obscureText = false.obs;
  final loadRegister = false.obs;
  final registerKey = GlobalKey<FormState>();
  Future<void> register() async {
    if(loadRegister.value) return;
    if(!registerKey.currentState!.validate()) return;
    loadRegister.value = true;
    try {
      await AuthService.to.register(
        email: emailCtrl.text,
        password: passwordCtrl.text,
        name: nameCtrl.text,
      );
    } catch (e) {
      MySnackbar.error(message: e.toString());
    }
    loadRegister.value = false;
  }
}
