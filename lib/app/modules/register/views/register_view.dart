import 'package:app_assignment_sipatex/app/core/values/colors.dart';
import 'package:app_assignment_sipatex/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Join our community! Fill out the form below to create your new account.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Display Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.nameCtrl,
              keyboardType: TextInputType.name,
              onFieldSubmitted: (_) => controller.emailFocus.requestFocus(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              focusNode: controller.emailFocus,
              controller: controller.emailCtrl,
              onChanged: (value) {
                if (value != value.toLowerCase()) {
                  controller.emailCtrl.text = value.toLowerCase();
                }
                if (controller.checkEmail) {
                  controller.checkEmail = false;
                }
              },
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) => controller.passwordFocus.requestFocus(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                } else if (!value.isEmail) {
                  return 'Email is invalid';
                } else if (controller.checkEmail) {
                  return 'Email is already exists';
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
                onFieldSubmitted: (_) =>
                    controller.confirmPasswordFocus.requestFocus(),
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
            const Text(
              'Confirm Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              focusNode: controller.confirmPasswordFocus,
              controller: controller.confirmPasswordCtrl,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Confirm Password is required';
                } else if (value != controller.passwordCtrl.text) {
                  return 'Confirm Password does not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Obx(
              () => ButtonWidget(
                buttonColor: controller.onClick.value ? null : grey,
                textButton:
                    controller.onClick.value ? 'Register' : 'Loading...',
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onTap: controller.onClick.value
                    ? () => controller.register()
                    : null,
                width: double.infinity,
                height: 40,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Do you have an account? '),
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onHover: (value) {
                    controller.hover2.value = value;
                  },
                  onTap: () => Get.back(),
                  child: Obx(
                    () => Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller.hover.value ? (Colors.black) : null,
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
