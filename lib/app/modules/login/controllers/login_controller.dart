import 'package:app_assignment_sipatex/app/data/services/auth_service.dart';
import 'package:app_assignment_sipatex/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final passwordFocus = FocusNode();
  RxBool rememberMe = true.obs;
  RxBool hover = false.obs;
  RxBool hover2 = false.obs;
  RxBool obscure = true.obs;
  final formKey = GlobalKey<FormState>();
  final onClick = true.obs;

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    passwordFocus.dispose();
    super.onClose();
  }

  void login() async {
    if (!formKey.currentState!.validate()) return;

    onClick.value = false;
    final status = await AuthService.to.login(
      emailCtrl.text,
      passwordCtrl.text,
    );
    if (status) {
      Get.offAllNamed(Routes.HOME);
    }
    onClick.value = true;
  }
}
