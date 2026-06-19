import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'administrators_controller.dart';
import 'brand.dart';

class AdminFormDialog extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onAction;
  final AdministratorsController controller;
  const AdminFormDialog({
    super.key,
    required this.title,
    required this.actionLabel,
    required this.onAction,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0x00000000),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Container(
            padding: const EdgeInsets.fromLTRB(28, 22, 28, 28),
            decoration: BoxDecoration(
              color: const Color(0xFF0E0E14),
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
                  Center(
                    child: AppText(
                      data: title,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 26),
                  _row('Name',
                      BrandField(controller: controller.formName, hintText: 'Full name')),
                  _row(
                      'Email',
                      BrandField(
                          controller: controller.formEmail,
                          hintText: 'Email address',
                          keyboardType: TextInputType.emailAddress)),
                  _row(
                      'Contact',
                      BrandField(
                          controller: controller.formContact,
                          hintText: 'Contact number',
                          keyboardType: TextInputType.phone)),
                  _row('Role', _roleDropdown(controller)),
                  _row('Image', _imagePicker(controller),
                      labelColor: const Color(0xFF8FA6FF)),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Get.back(),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFF5B7BF5)),
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
                        child: GradientButton(
                            text: actionLabel, onTap: onAction),
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

  Widget _row(String label, Widget input,
      {Color labelColor = const Color(0xFFFFFFFF)}) {
    final labelWidget = AppText(
      data: label,
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: labelColor,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
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

  Widget _roleDropdown(AdministratorsController c) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF000000),
        border: Border.all(color: const Color(0xFF3A3A45)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(
          () => DropdownButton<String>(
            isExpanded: true,
            dropdownColor: const Color(0xFF16161C),
            value: c.formRole.value,
            icon: const Icon(Icons.keyboard_arrow_down,
                color: Color(0xFFD7D7DD)),
            items: c.roles
                .map(
                  (r) => DropdownMenuItem<String>(
                    value: r,
                    child: AppText(
                      data: r,
                      fontSize: 16,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) c.formRole.value = v;
            },
          ),
        ),
      ),
    );
  }

  Widget _imagePicker(AdministratorsController c) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF000000),
        border: Border.all(color: const Color(0xFF3A3A45)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Obx(
              () => AppText(
                data: c.formImageName.value.isEmpty
                    ? 'Choose image'
                    : c.formImageName.value,
                fontSize: 15,
                color: c.formImageName.value.isEmpty
                    ? const Color(0xFF8A8A93)
                    : const Color(0xFFFFFFFF),
              ),
            ),
          ),
          InkWell(
            onTap: c.pickImage,
            child: Container(
              height: 54,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFF26262E),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(9),
                  bottomRight: Radius.circular(9),
                ),
              ),
              child: AppText(
                data: 'Choose',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
