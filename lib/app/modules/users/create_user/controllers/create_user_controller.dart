import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:app_assignment_sipatex/app/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserController extends GetxController {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  var role = 'guest';
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  RxBool hover = false.obs;
  RxBool hover2 = false.obs;
  RxBool obscure = true.obs;
  final formKey = GlobalKey<FormState>();

  bool checkUsername = false;
  bool checkEmail = false;

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

  void create() async {
    if (!formKey.currentState!.validate()) return;
    if (checkEmail = await UserProvider.to.checkEmail(emailCtrl.text)) {
      formKey.currentState!.validate();
      return;
    }

    onClick.value = false;
    UserProvider.to.create(
      User(
        email: emailCtrl.text,
        password: passwordCtrl.text,
        displayName: nameCtrl.text,
        role: role,
      ),
    );
    UserProvider.to.onInit();
    Get.back();
    onClick.value = true;
    Get.rawSnackbar(message: 'Success');
  }
}
