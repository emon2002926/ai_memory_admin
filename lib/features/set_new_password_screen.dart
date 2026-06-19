import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/widgets/text/app_text.dart';
import 'brand.dart' hide AppText;
import 'set_new_password_controller.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SetNewPasswordController());

    return AuthScaffold(
      children: [
        Center(child: BrandLogo(size: 96)),
        const SizedBox(height: 30),
        AppText(
          data: 'Set a new password',
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFFFFFFF),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        AppText(
          data: 'Create a new password. Ensure it differs from previous ones for security',
          fontSize: 16,
          color: const Color(0xFFD7D7DD),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        AppText(
          data: 'New Password',
          fontSize: 15,
          color: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 10),
        Obx(
          () => BrandField(
            controller: c.passwordController,
            hintText: 'Enter new password',
            obscureText: c.obscurePassword.value,
            suffixWidget: IconButton(
              onPressed: c.togglePassword,
              icon: Icon(
                c.obscurePassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFFD7D7DD),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        AppText(
          data: 'Confirm Password',
          fontSize: 15,
          color: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 10),
        Obx(
          () => BrandField(
            controller: c.confirmController,
            hintText: 'Re-enter new password',
            obscureText: c.obscureConfirm.value,
            suffixWidget: IconButton(
              onPressed: c.toggleConfirm,
              icon: Icon(
                c.obscureConfirm.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFFD7D7DD),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        GradientButton(text: 'Reset Password', onTap: c.onReset),
      ],
    );
  }
}
