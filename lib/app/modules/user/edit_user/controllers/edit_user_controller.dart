import 'package:app_assignment_sipatex/app/data/models/user_model.dart';
import 'package:app_assignment_sipatex/app/data/providers/user_provider.dart';
import 'package:app_assignment_sipatex/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUserController extends GetxController {
  final User _user = Get.arguments;

  late final TextEditingController nameCtrl;
  late final TextEditingController emailCtrl;

  final emailFocus = FocusNode();

  RxBool hover = false.obs;
  RxBool hover2 = false.obs;
  RxBool obscure = true.obs;
  final formKey = GlobalKey<FormState>();

  bool checkUsername = false;
  bool checkEmail = false;

  final onClick = true.obs;

  var role = 'guest';

  @override
  void onInit() {
    nameCtrl = TextEditingController(text: _user.displayName);
    emailCtrl = TextEditingController(text: _user.email);
    role = _user.role!;
    super.onInit();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    emailFocus.dispose();
    super.onClose();
  }

  void edit() async {
    if (!formKey.currentState!.validate()) return;
    if (emailCtrl.text != _user.email!) {
      if (checkEmail = await UserProvider.to.checkEmail(emailCtrl.text)) {
        formKey.currentState!.validate();
        return;
      }
    }

    onClick.value = false;
    UserProvider.to.edit(
      User(
        id: _user.id,
        email: emailCtrl.text,
        displayName: nameCtrl.text,
        role: role,
      ),
    );
    UserProvider.to.onInit();
    if (AuthService.to.user.id == _user.id) {
      AuthService.to.refreshAuth();
    }
    Get.back();
    onClick.value = true;
    Get.rawSnackbar(message: 'Success');
  }
}
