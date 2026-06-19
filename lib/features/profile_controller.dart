import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_router.dart';
import 'profile_menu.dart';
import 'account_setting_dialog.dart';
import 'password_change_dialog.dart';

class ProfileController extends GetxController {
  final RxString name = 'Bayern'.obs;
  final RxString email = 'ovierahaman1@gmail.com'.obs;
  final RxString phone = '+8808454556444'.obs;
  final RxString role = 'Super Admin'.obs;
  final RxString avatarUrl = ''.obs;

  final accName = TextEditingController();
  final accEmail = TextEditingController();
  final accPhone = TextEditingController();
  final accRole = TextEditingController();

  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final retypePass = TextEditingController();
  final RxBool obscureOld = true.obs;
  final RxBool obscureNew = true.obs;
  final RxBool obscureRetype = true.obs;

  String get initials {
    final parts = name.value
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) {
      final w = parts.first;
      return (w.length >= 2 ? w.substring(0, 2) : w).toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  void openMenu() {
    Get.dialog(const ProfileMenu(), barrierColor: const Color(0x22000000));
  }

  void openAccountSetting() {
    Get.back();
    accName.text = name.value;
    accEmail.text = email.value;
    accPhone.text = phone.value;
    accRole.text = role.value;
    Get.dialog(const AccountSettingDialog());
  }

  void openPasswordChange() {
    Get.back();
    oldPass.clear();
    newPass.clear();
    retypePass.clear();
    obscureOld.value = true;
    obscureNew.value = true;
    obscureRetype.value = true;
    Get.dialog(const PasswordChangeDialog());
  }

  void saveAccount() {
    name.value = accName.text.trim();
    email.value = accEmail.text.trim();
    phone.value = accPhone.text.trim();
    role.value = accRole.text.trim();
    Get.back();
    Get.snackbar('Saved', 'Account settings updated.');
  }

  void updatePassword() {
    if (oldPass.text.isEmpty ||
        newPass.text.isEmpty ||
        retypePass.text.isEmpty) {
      Get.snackbar('Missing info', 'Please fill in all password fields.');
      return;
    }
    if (newPass.text != retypePass.text) {
      Get.snackbar('Mismatch', 'New passwords do not match.');
      return;
    }
    Get.back();
    Get.snackbar('Updated', 'Your password has been changed.');
  }

  void logout() {
    Get.back();
    appRouter.go(AppRoutes.login);
  }

  void toggleOld() => obscureOld.value = !obscureOld.value;
  void toggleNew() => obscureNew.value = !obscureNew.value;
  void toggleRetype() => obscureRetype.value = !obscureRetype.value;

  @override
  void onClose() {
    accName.dispose();
    accEmail.dispose();
    accPhone.dispose();
    accRole.dispose();
    oldPass.dispose();
    newPass.dispose();
    retypePass.dispose();
    super.onClose();
  }
}
