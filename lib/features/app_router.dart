import 'package:ai_memory_admin/features/password_updated_screen.dart';
import 'package:ai_memory_admin/features/set_new_password_screen.dart';
import 'package:ai_memory_admin/features/user_management_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'admin_shell.dart';
import 'administrators_screen.dart';
import 'check_email_screen.dart';
import 'dashboard_screen.dart';
import 'forget_password_screen.dart';
import 'login_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const verify = '/verify';
  static const resetPassword = '/reset-password';
  static const resetSuccess = '/reset-success';
  static const dashboard = '/dashboard';
  static const users = '/users';
  static const administrators = '/administrators';
}

final GoRouter appRouter = GoRouter(
  navigatorKey: Get.key,
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(path: AppRoutes.login, builder: (_, __) => LoginScreen()),
    GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, __) => ForgetPasswordScreen()),
    GoRoute(path: AppRoutes.verify, builder: (_, __) => CheckEmailScreen()),
    GoRoute(
        path: AppRoutes.resetPassword,
        builder: (_, __) => SetNewPasswordScreen()),
    GoRoute(
        path: AppRoutes.resetSuccess,
        builder: (_, __) => const PasswordUpdatedScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AdminShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.dashboard, builder: (_, __) => DashboardScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.users,
              builder: (_, __) => UserManagementScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.administrators,
              builder: (_, __) => AdministratorsScreen()),
        ]),
      ],
    ),
  ],
);
