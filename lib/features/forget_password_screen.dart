import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'brand.dart';
import 'forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ForgetPasswordController());

    return AuthScaffold(
      children: [
        Center(child: BrandLogo(size: 96)),
        const SizedBox(height: 30),
        AppText(
          data: 'Forget Password?',
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFFFFFFF),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        AppText(
          data: 'Please enter your email to get verification code',
          fontSize: 16,
          color: const Color(0xFFD7D7DD),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        AppText(
          data: 'Email address',
          fontSize: 15,
          color: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 10),
        BrandField(
          controller: c.emailController,
          hintText: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 30),
        GradientButton(text: 'Continue', onTap: c.onContinue),
      ],
    );
  }
}
