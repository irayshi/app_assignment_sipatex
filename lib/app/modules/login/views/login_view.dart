import 'package:app_assignment_sipatex/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 200,
              child: const Text(
                'My Application',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.emailCtrl,
              onChanged: (value) {
                if (value != value.toLowerCase()) {
                  controller.emailCtrl.text = value.toLowerCase();
                }
              },
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) => controller.passwordFocus.requestFocus(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                } else if (!value.isEmail) {
                  return 'Email is invalid';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => TextFormField(
                focusNode: controller.passwordFocus,
                controller: controller.passwordCtrl,
                keyboardType: TextInputType.visiblePassword,
                obscureText: controller.obscure.value,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => controller.obscure.toggle(),
                        icon: Icon(
                          controller.obscure.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 16,
                        ))),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => FilledButton(
                onPressed:
                    controller.onClick.value ? () => controller.login() : null,
                child: Text(controller.onClick.value ? 'Login' : 'Loading...'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don’t Have An Account? '),
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onHover: (value) {
                    controller.hover2.value = value;
                  },
                  onTap: () => Get.toNamed(Routes.REGISTER),
                  child: Obx(
                    () => Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller.hover2.value
                            ? Theme.of(context).colorScheme.onSecondary
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
