import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_router.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool obscure = true.obs;
  final RxBool remember = true.obs;

  void toggleObscure() => obscure.value = !obscure.value;
  void toggleRemember() => remember.value = !remember.value;

  void onLogin() {
    appRouter.go(AppRoutes.dashboard);
  }

  void onForgot() {
    appRouter.go(AppRoutes.forgotPassword);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
