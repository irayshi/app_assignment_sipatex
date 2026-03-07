import 'package:app_assignment_sipatex/app/routes.dart';
import 'package:app_assignment_sipatex/widgets/spacer.dart';
import 'package:app_assignment_sipatex/modules/login/login_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                            'Login to MyApp',
                            style: context.textTheme.displayMedium,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "If you don't have an account register.\nYou can ",
                                  style: context.textTheme.bodyLarge!,
                                ),
                                TextSpan(
                                  text: 'Register here!',
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: context.theme.primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.offNamed(Routes.register);
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
                            key: controller.loginKey,
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Login',
                                  style: context.textTheme.titleLarge,
                                ),
                                TextFormField(
                                  controller: controller.emailCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email or username',
                                  ),
                                  onEditingComplete: () =>
                                      FocusScope.of(context).nextFocus(),
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
                                  ),
                                ),
                                verticalSpace(20),
                                Obx(() {
                                  var styleFrom = FilledButton.styleFrom(
                                    fixedSize: Size.fromHeight(60),
                                    textStyle: context.textTheme.titleMedium,
                                  );
                                  return controller.loadLogin.value
                                      ? FilledButton(
                                          style: styleFrom,
                                          onPressed: null,
                                          child: Text('Loading'),
                                        )
                                      : FilledButton(
                                          style: styleFrom,
                                          onPressed: controller.login,
                                          child: Text('Login'),
                                        );
                                }),
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
