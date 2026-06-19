import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'new_administrator_dialog.dart';
import 'edit_administrator_dialog.dart';
import 'confirm_remove_access_dialog.dart';

class AdminRow {
  final String sl;
  final String name;
  final String email;
  final String contact;
  final String access;
  const AdminRow({
    required this.sl,
    required this.name,
    required this.email,
    required this.contact,
    required this.access,
  });
}

class AdministratorsController extends GetxController {
  final RxList<AdminRow> admins = <AdminRow>[
    AdminRow(sl: '#1233', name: 'Kathryn Murp', email: 'bockely@att.com', contact: '(201) 555-0124', access: 'Super Admin'),
    AdminRow(sl: '#1233', name: 'Devon Lane', email: 'csilvers@rizon.com', contact: '(219) 555-0114', access: 'Admin'),
    AdminRow(sl: '#1233', name: 'Foysal Rahman', email: 'qamaho@mail.com', contact: '(316) 555-0116', access: 'Admin'),
    AdminRow(sl: '#1233', name: 'Hari Danang', email: 'xterris@gmail.com', contact: '(907) 555-0101', access: 'Admin'),
    AdminRow(sl: '#1233', name: 'Floyd Miles', email: 'xterris@gmail.com', contact: '(505) 555-0125', access: 'Admin'),
    AdminRow(sl: '#1233', name: 'Eleanor Pena', email: 'xterris@gmail.com', contact: '(704) 555-0127', access: 'Admin'),
    AdminRow(sl: '#1233', name: 'Devon Lane', email: 'xterris@gmail.com', contact: '(219) 555-0114', access: 'Admin'),
    AdminRow(sl: '#1233', name: 'Hari Danang', email: 'xterris@gmail.com', contact: '(270) 555-0117', access: 'Admin'),
    AdminRow(sl: '#1233', name: 'Hari Danang', email: 'xterris@gmail.com', contact: '(207) 555-0119', access: 'Admin'),
  ].obs;

  final formName = TextEditingController();
  final formEmail = TextEditingController();
  final formContact = TextEditingController();
  final RxString formRole = 'Admin'.obs;
  final RxString formImageName = ''.obs;

  final List<String> roles = const [
    'Super Admin', 'Admin', 'Owner', 'Editor', 'Visitor'
  ];

  int? editingIndex;

  void onCreate() {
    editingIndex = null;
    formName.clear();
    formEmail.clear();
    formContact.clear();
    formRole.value = 'Admin';
    formImageName.value = '';
    Get.dialog(const NewAdministratorDialog());
  }

  void onEdit(int index) {
    editingIndex = index;
    final a = admins[index];
    formName.text = a.name;
    formEmail.text = a.email;
    formContact.text = a.contact;
    formRole.value = roles.contains(a.access) ? a.access : 'Admin';
    formImageName.value = '';
    Get.dialog(const EditAdministratorDialog());
  }

  void confirmRemove(int index) {
    Get.dialog(ConfirmRemoveAccessDialog(index: index));
  }

  Future<void> pickImage() async {
    try {
      final picked =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) formImageName.value = picked.name;
    } catch (_) {}
  }

  void createAdmin() {
    final name = formName.text.trim();
    final email = formEmail.text.trim();
    if (name.isEmpty || email.isEmpty) {
      Get.snackbar('Missing info', 'Please enter a name and email.');
      return;
    }
    admins.add(AdminRow(
      sl: '#1233',
      name: name,
      email: email,
      contact: formContact.text.trim(),
      access: formRole.value,
    ));
    Get.back();
  }

  void saveEdit() {
    final i = editingIndex;
    if (i == null) return;
    admins[i] = AdminRow(
      sl: admins[i].sl,
      name: formName.text.trim(),
      email: formEmail.text.trim(),
      contact: formContact.text.trim(),
      access: formRole.value,
    );
    Get.back();
  }

  void deleteAdmin(int index) {
    admins.removeAt(index);
    Get.back();
  }

  @override
  void onClose() {
    formName.dispose();
    formEmail.dispose();
    formContact.dispose();
    super.onClose();
  }
}
