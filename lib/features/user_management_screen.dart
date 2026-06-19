import 'package:ai_memory_admin/features/user_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/widgets/text/app_text.dart';
import 'brand.dart' hide AppText;

class UserManagementScreen extends StatelessWidget {
  UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(UserManagementController());

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
            LayoutBuilder(
              builder: (context, constraints) {
                final tableWidth =
                    constraints.maxWidth > 1000 ? constraints.maxWidth : 1000.0;
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
                              for (int i = 0; i < c.users.length; i++)
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
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => _pagination(c)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerRow() {
    Widget h(String t, int flex) => Expanded(
          flex: flex,
          child: AppText(
            data: t,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFFFFF),
          ),
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          h('SL no.', 2),
          h('Full Name', 3),
          h('Email', 3),
          h('Subscription', 2),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: AppText(
                data: 'Action',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataRow(UserManagementController c, int i) {
    final u = c.users[i];
    Widget cell(String t, int flex) => Expanded(
          flex: flex,
          child: AppText(
            data: t,
            fontSize: 15,
            color: const Color(0xFFD7D7DD),
          ),
        );
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1C1C24))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          cell(u.sl, 2),
          cell(u.name, 3),
          cell(u.email, 3),
          cell(u.subscription, 2),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => c.blockUser(i),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7F1D1D),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.block,
                      color: Color(0xFFFFFFFF), size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pagination(UserManagementController c) {
    Widget pill(String label, VoidCallback onTap, bool active) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: kBrandGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: AppText(
              data: label,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        pill('< Prev', c.prevPage, false),
        for (int p = 1; p <= c.totalPages; p++)
          pill('$p', () => c.goToPage(p), c.currentPage.value == p),
        pill('Next >', c.nextPage, false),
      ],
    );
  }
}
