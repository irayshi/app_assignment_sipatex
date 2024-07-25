import 'package:app_assignment_sipatex/app/data/providers/user_provider.dart';
import 'package:app_assignment_sipatex/app/data/services/auth_service.dart';
import 'package:app_assignment_sipatex/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  RxBool hover = false.obs;
  RxBool hover2 = false.obs;
  RxBool obscure = true.obs;
  final formKey = GlobalKey<FormState>();

  bool checkUsername = false;
  bool emailExists = false;

  final onClick = true.obs;

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }

  void register() async {
    if (!formKey.currentState!.validate()) return;
    String message;
    try {
      if (emailExists = await UserProvider.to.emailExists(emailCtrl.text)) {
        formKey.currentState!.validate();
        return;
      }

      onClick.value = false;
      await AuthService.to.register(
        emailCtrl.text,
        passwordCtrl.text,
        nameCtrl.text,
      );
      Get.offAllNamed(Routes.MAIN);
      message = 'Register berhasil';
    } catch (e) {
      message = 'Register gagal: terjadi kesalahan sistem';
    }
    Get.rawSnackbar(message: message);
    onClick.value = true;
  }
}
