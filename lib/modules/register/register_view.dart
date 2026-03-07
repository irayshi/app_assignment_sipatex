import 'package:app_assignment_sipatex/app/routes.dart';
import 'package:app_assignment_sipatex/widgets/spacer.dart';
import 'package:app_assignment_sipatex/modules/register/register_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'App Assignment Sipatex',
              style: context.textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Register to MyApp',
                            style: context.textTheme.displayMedium,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "If you already have an account login.\nYou can ",
                                  style: context.textTheme.bodyLarge!,
                                ),
                                TextSpan(
                                  text: 'Login here!',
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.theme.primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.offNamed(Routes.login);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 20,
                    ),
                    child: Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: controller.registerKey,
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Register',
                                  style: context.textTheme.titleLarge,
                                ),
                                TextFormField(
                                  controller: controller.emailCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(labelText: 'Email'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email wajib diisi.';
                                    }
                                    if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                    ).hasMatch(value)) {
                                      return 'Format email tidak valid.';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: controller.nameCtrl,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(labelText: 'Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Name wajib diisi.';
                                    }
                                    return null;
                                  },
                                ),
                                Obx(
                                  () => TextFormField(
                                    controller: controller.passwordCtrl,
                                    obscureText: controller.obscureText.value,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.obscureText.toggle();
                                        },
                                        icon: Icon(
                                          controller.obscureText.value
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password wajib diisi.';
                                      }
                                      if (value.length < 8) {
                                        return 'Password minimal 8 karakter.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Obx(
                                  () => TextFormField(
                                    controller: controller.confirmPasswordCtrl,
                                    obscureText: controller.obscureText.value,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Konfirmasi password wajib diisi.';
                                      }
                                      if (value != controller.passwordCtrl.text) {
                                        return 'Konfirmasi password tidak sama';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Confirmation Password',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.obscureText.toggle();
                                        },
                                        icon: Icon(
                                          controller.obscureText.value
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpace(20),
                                Obx(
                                  () {
                                    var styleFrom = FilledButton.styleFrom(
                                            fixedSize: Size.fromHeight(60),
                                            textStyle:
                                                context.textTheme.titleMedium,
                                          );
                                    return controller.loadRegister.value
                                      ? FilledButton(
                                          style: styleFrom,
                                          onPressed: null,
                                          child: Text('Loading'),
                                        )
                                      : FilledButton(
                                          style: styleFrom,
                                          onPressed: controller.register,
                                          child: Text('Register'),
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
