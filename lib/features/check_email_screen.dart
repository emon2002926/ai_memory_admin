import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'brand.dart';
import 'check_email_controller.dart';



class CheckEmailScreen extends StatelessWidget {
  CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(CheckEmailController(), permanent: true);

    return AuthScaffold(
      children: [
        Center(child: BrandLogo(size: 96)),
        const SizedBox(height: 30),
        AppText(
          data: 'Check your email',
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFFFFFFF),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        AppText(
          data:
          'We sent a code to your email address. Please check your email for the 5 digit code.',
          fontSize: 16,
          color: const Color(0xFFD7D7DD),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: TextField(
                    controller: c.boxes[i],
                    focusNode: c.nodes[i],
                    onChanged: (v) => c.onChanged(i, v),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                    cursorColor: const Color(0xFFB18BE8),
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: const Color(0xFF000000),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Color(0xFF3A3A45)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Color(0xFF5B7BF5)),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 30),
        GradientButton(text: 'Verify', onTap: c.onVerify),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              data: 'You have not received the email? ',
              fontSize: 15,
              color: const Color(0xFFD7D7DD),
            ),
            InkWell(
              onTap: c.onResend,
              child: AppText(
                data: 'Resend',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF8FA6FF),
              ),
            ),
          ],
        ),
      ],
    );
  }
}