import 'package:flutter/material.dart';
import 'app_router.dart';
import 'brand.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      children: [
        Center(child: BrandLogo(size: 110)),
        const SizedBox(height: 40),
        AppText(
          data: 'Password Updated Successfully!',
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFFFFFFF),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 18),
        AppText(
          data: 'Your new password has been saved. You can now continue securely.',
          fontSize: 16,
          color: const Color(0xFFD7D7DD),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 36),
        GradientButton(
          text: 'Sign in',
          onTap: () => appRouter.go(AppRoutes.login),
        ),
      ],
    );
  }
}
