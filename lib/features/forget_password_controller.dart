import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_router.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();

  void onContinue() {
    appRouter.go(AppRoutes.verify);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
