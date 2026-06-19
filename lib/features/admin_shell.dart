import 'package:ai_memory_admin/features/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'brand.dart';


class AdminShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AdminShell({super.key, required this.navigationShell});

  static const double mobileBreakpoint = 900;

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController(), permanent: true);
    final isMobile = MediaQuery.of(context).size.width < mobileBreakpoint;

    if (isMobile) {
      return Scaffold(
        backgroundColor: const Color(0xFF050507),
        drawer: Drawer(
          width: 270,
          backgroundColor: const Color(0xFF000000),
          child: SafeArea(
            child: _Sidebar(navigationShell: navigationShell, isDrawer: true),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const _TopBar(isMobile: true),
              Expanded(child: navigationShell),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF050507),
      body: Row(
        children: [
          _Sidebar(navigationShell: navigationShell),
          Expanded(
            child: Column(
              children: [
                const _TopBar(),
                Expanded(child: navigationShell),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final bool isDrawer;
  const _Sidebar({required this.navigationShell, this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    final current = navigationShell.currentIndex;

    void go(int index) {
      navigationShell.goBranch(index, initialLocation: index == current);
      if (isDrawer) Navigator.of(context).maybePop();
    }

    return Container(
      width: isDrawer ? null : 280,
      color: const Color(0xFF000000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 24),
            child: BrandLogo(size: 84),
          ),
          _SidebarItem(
            icon: Icons.speed_outlined,
            label: 'DashBoard',
            isSelected: current == 0,
            onTap: () => go(0),
          ),
          _SidebarItem(
            icon: Icons.groups_2_outlined,
            label: 'User Management',
            isSelected: current == 1,
            onTap: () => go(1),
          ),
          _SidebarItem(
            icon: Icons.shield_outlined,
            label: 'Administrators',
            isSelected: current == 2,
            onTap: () => go(2),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        decoration: BoxDecoration(
          gradient: isSelected ? kBrandGradient : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xFF8A8A93),
            ),
            const SizedBox(width: 14),
            AppText(
              data: label,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xFF8A8A93),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final bool isMobile;
  const _TopBar({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();

    final chip = InkWell(
      onTap: c.openMenu,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0E),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF2A2A32)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
                  () => Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: c.avatarUrl.value.isEmpty ? kBrandGradient : null,
                  shape: BoxShape.circle,
                  image: c.avatarUrl.value.isEmpty
                      ? null
                      : DecorationImage(
                      image: NetworkImage(c.avatarUrl.value),
                      fit: BoxFit.cover),
                ),
                alignment: Alignment.center,
                child: c.avatarUrl.value.isEmpty
                    ? AppText(
                  data: c.initials,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFFFFF),
                )
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                      () => AppText(
                    data: c.name.value,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
                Obx(
                      () => AppText(
                    data: c.role.value,
                    fontSize: 13,
                    color: const Color(0xFF8A8A93),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: const Color(0xFF16161C),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2A2A32)),
              ),
              child: const Icon(Icons.keyboard_arrow_down,
                  size: 18, color: Color(0xFFD7D7DD)),
            ),
          ],
        ),
      ),
    );

    if (isMobile) {
      return Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFFFFFFFF)),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
            const Spacer(),
            chip,
          ],
        ),
      );
    }

    return Container(
      height: 100,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: chip,
    );
  }
}