import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/widgets/text/app_text.dart';
import 'administrators_controller.dart';
import 'brand.dart' hide AppText;

class ConfirmRemoveAccessDialog extends StatelessWidget {
  final int index;
  const ConfirmRemoveAccessDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AdministratorsController>();
    return Dialog(
      backgroundColor: const Color(0x00000000),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Container(
            padding: const EdgeInsets.fromLTRB(28, 22, 28, 34),
            decoration: BoxDecoration(
              color: const Color(0xFF0E0E14),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF26262E)),
            ),
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
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1C1C24),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          color: Color(0xFFFFFFFF), size: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: AppText(
                    data: 'Confirm Remove access',
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFFFFF),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 36),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 58,
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
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () => c.deleteAdmin(index),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 58,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: kBrandGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.delete_outline,
                                  color: Color(0xFFFFFFFF), size: 20),
                              const SizedBox(width: 10),
                              AppText(
                                data: 'Delete',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFFFFFFF),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
