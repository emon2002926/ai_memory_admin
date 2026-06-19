import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_router.dart';

class CheckEmailController extends GetxController {
  final List<TextEditingController> boxes =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> nodes = List.generate(5, (_) => FocusNode());

  void onChanged(int index, String value) {
    if (value.isNotEmpty && index < 4) {
      nodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      nodes[index - 1].requestFocus();
    }
  }

  void onVerify() {
    appRouter.go(AppRoutes.resetPassword);
  }

  void onResend() {
    Get.snackbar('Code sent', 'A new code has been sent to your email.');
  }

  @override
  void onClose() {
    for (final b in boxes) {
      b.dispose();
    }
    for (final n in nodes) {
      n.dispose();
    }
    super.onClose();
  }
}
