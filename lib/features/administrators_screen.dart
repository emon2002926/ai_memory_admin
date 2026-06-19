import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/widgets/text/app_text.dart';
import 'administrators_controller.dart';
import 'brand.dart' hide AppText;


class AdministratorsScreen extends StatelessWidget {
  AdministratorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AdministratorsController(), permanent: true);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0C0C11),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF20202A)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: c.onCreate,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: kBrandGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add,
                          color: Color(0xFFFFFFFF), size: 20),
                      const SizedBox(width: 10),
                      AppText(
                        data: 'New Administrators Profile Create',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final tableWidth =
                constraints.maxWidth > 1100 ? constraints.maxWidth : 1100.0;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: tableWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _headerRow(),
                        const SizedBox(height: 8),
                        Obx(
                              () => Column(
                            children: [
                              for (int i = 0; i < c.admins.length; i++)
                                _dataRow(c, i),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerRow() {
    Widget h(String t, int flex, {Alignment align = Alignment.centerLeft}) =>
        Expanded(
          flex: flex,
          child: Align(
            alignment: align,
            child: AppText(
              data: t,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          h('SL no.', 2),
          h('Name', 3),
          h('Email', 3),
          h('Contact Number', 3),
          h('Has Access to', 2),
          h('Action', 2, align: Alignment.centerRight),
        ],
      ),
    );
  }

  Widget _dataRow(AdministratorsController c, int i) {
    final a = c.admins[i];
    Widget cell(String t, int flex) => Expanded(
      flex: flex,
      child: AppText(
        data: t,
        fontSize: 15,
        color: const Color(0xFFD7D7DD),
      ),
    );

    Widget actionBtn(IconData icon, Color color, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFFFFFFFF), size: 20),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1C1C24))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          cell(a.sl, 2),
          cell(a.name, 3),
          cell(a.email, 3),
          cell(a.contact, 3),
          cell(a.access, 2),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                actionBtn(Icons.edit_outlined, const Color(0xFF15803D),
                        () => c.onEdit(i)),
                const SizedBox(width: 12),
                actionBtn(Icons.delete_outline, const Color(0xFFB91C1C),
                        () => c.confirmRemove(i)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}