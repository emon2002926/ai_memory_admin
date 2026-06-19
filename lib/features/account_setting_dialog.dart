import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/widgets/text/app_text.dart';
import 'brand.dart' hide AppText;
import 'profile_controller.dart';

class AccountSettingDialog extends StatelessWidget {
  const AccountSettingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    return Dialog(
      backgroundColor: const Color(0x00000000),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Container(
            padding: const EdgeInsets.fromLTRB(28, 22, 28, 28),
            decoration: BoxDecoration(
              color: const Color(0xFF000000),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF26262E)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => Get.back(),
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close,
                            color: Color(0xFF000000), size: 22),
                      ),
                    ),
                  ),
                  Center(
                    child: AppText(
                      data: 'Account Setting',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _row('Name',
                      BrandField(controller: c.accName, hintText: 'Full name')),
                  _row(
                      'Email',
                      BrandField(
                          controller: c.accEmail,
                          hintText: 'Email address',
                          keyboardType: TextInputType.emailAddress)),
                  _row(
                      'Phone',
                      BrandField(
                          controller: c.accPhone,
                          hintText: 'Phone number',
                          keyboardType: TextInputType.phone)),
                  _row('Role',
                      BrandField(controller: c.accRole, hintText: 'Role')),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(child: _cancelButton()),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GradientButton(
                            text: 'Save', onTap: c.saveAccount),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, Widget input) {
    final labelWidget = AppText(
      data: label,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: const Color(0xFFFFFFFF),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 460) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [labelWidget, const SizedBox(height: 8), input],
            );
          }
          return Row(
            children: [
              SizedBox(width: 120, child: labelWidget),
              const SizedBox(width: 16),
              Expanded(child: input),
            ],
          );
        },
      ),
    );
  }

  Widget _cancelButton() {
    return InkWell(
      onTap: () => Get.back(),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF5B7BF5)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: AppText(
          data: 'Cancel',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF8FA6FF),
        ),
      ),
    );
  }
}
