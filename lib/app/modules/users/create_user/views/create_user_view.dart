import 'package:app_assignment_sipatex/app/core/values/colors.dart';
import 'package:app_assignment_sipatex/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_user_controller.dart';

class CreateUserView extends GetView<CreateUserController> {
  const CreateUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
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
            DropdownButtonFormField(
              value: controller.role,
              items: const [
                DropdownMenuItem(
                  value: 'admin',
                  child: Text('Admin'),
                ),
                DropdownMenuItem(
                  value: 'guest',
                  child: Text('Guest'),
                )
              ],
              onChanged: (value) => controller.role = value!,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Role is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Obx(
              () => ButtonWidget(
                buttonColor: controller.onClick.value ? null : grey,
                textButton: controller.onClick.value ? 'Create' : 'Loading...',
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onTap:
                    controller.onClick.value ? () => controller.create() : null,
                width: double.infinity,
                height: 40,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
