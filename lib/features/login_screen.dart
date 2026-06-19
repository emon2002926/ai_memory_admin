import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'brand.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoginController());

    return AuthScaffold(
      children: [
        Center(child: BrandLogo(size: 96)),
        const SizedBox(height: 24),
        AppText(
          data: 'Login to Account',
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFFFFFFF),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        AppText(
          data: 'Please enter your email and password to continue',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFD7D7DD),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        AppText(
          data: 'Email address',
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 10),
        BrandField(
          controller: c.emailController,
          hintText: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        AppText(
          data: 'Password',
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFFFFFFF),
        ),
        const SizedBox(height: 10),
        Obx(
          () => BrandField(
            controller: c.passwordController,
            hintText: 'Enter your password',
            obscureText: c.obscure.value,
            suffixWidget: IconButton(
              onPressed: c.toggleObscure,
              icon: Icon(
                c.obscure.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFFD7D7DD),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: c.toggleRemember,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        gradient: c.remember.value ? kBrandGradient : null,
                        color: c.remember.value ? null : const Color(0xFF000000),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFF5B7BF5)),
                      ),
                      child: c.remember.value
                          ? const Icon(Icons.check,
                              size: 16, color: Color(0xFFFFFFFF))
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  AppText(
                    data: 'Remember Password',
                    fontSize: 15,
                    color: const Color(0xFFFFFFFF),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: c.onForgot,
              child: AppText(
                data: 'Forget Password?',
                fontSize: 15,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        GradientButton(text: 'Login', onTap: c.onLogin),
      ],
    );
  }
}
