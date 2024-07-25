import 'package:app_assignment_sipatex/app/core/values/colors.dart';
import 'package:app_assignment_sipatex/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_user_controller.dart';

class EditUserView extends GetView<EditUserController> {
  const EditUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditUserView'),
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
                if (controller.emailExists) {
                  controller.emailExists = false;
                }
              },
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                } else if (!value.isEmail) {
                  return 'Email is invalid';
                } else if (controller.emailExists) {
                  return 'Email is already exists';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Role',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
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
                textButton: controller.onClick.value ? 'Edit' : 'Loading...',
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onTap:
                    controller.onClick.value ? () => controller.edit() : null,
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
