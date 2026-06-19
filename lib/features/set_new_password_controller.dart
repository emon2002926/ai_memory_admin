import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_router.dart';

class SetNewPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirm = true.obs;

  void togglePassword() => obscurePassword.value = !obscurePassword.value;
  void toggleConfirm() => obscureConfirm.value = !obscureConfirm.value;

  void onReset() {
    if (passwordController.text.isEmpty || confirmController.text.isEmpty) {
      Get.snackbar('Missing info', 'Please fill in both fields.');
      return;
    }
    if (passwordController.text != confirmController.text) {
      Get.snackbar('Mismatch', 'Passwords do not match.');
      return;
    }
    appRouter.go(AppRoutes.resetSuccess);
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmController.dispose();
    super.onClose();
  }
}
