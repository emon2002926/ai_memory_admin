import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/widgets/text/app_text.dart';
import 'brand.dart' hide AppText;
import 'profile_controller.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    final screenW = MediaQuery.of(context).size.width;
    final cardWidth = screenW - 48 < 420 ? screenW - 48 : 420.0;
    final topInset = screenW < 900 ? 64.0 : 96.0;

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: topInset, right: 16),
        child: Material(
          color: const Color(0x00000000),
          child: Container(
            width: cardWidth,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0E),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF26262E)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    _avatar(c, 56),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(
                            () => AppText(
                              data: c.name.value,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(
                            () => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 7),
                              decoration: BoxDecoration(
                                color: const Color(0xFF8E7BE8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: AppText(
                                data: c.role.value,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Divider(height: 1, color: Color(0xFF26262E)),
                const SizedBox(height: 6),
                _menuRow('Profile', c.openAccountSetting),
                _menuRow('Change Password', c.openPasswordChange),
                const SizedBox(height: 14),
                GradientButton(text: 'Logout', onTap: c.logout, radius: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar(ProfileController c, double size) {
    return Obx(() {
      final url = c.avatarUrl.value;
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: url.isEmpty ? kBrandGradient : null,
          image: url.isEmpty
              ? null
              : DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        ),
        alignment: Alignment.center,
        child: url.isEmpty
            ? AppText(
                data: c.initials,
                fontSize: size * 0.34,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFFFFFF),
              )
            : null,
      );
    });
  }

  Widget _menuRow(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                data: label,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFFFFFF),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFFFFFFF), size: 26),
          ],
        ),
      ),
    );
  }
}
