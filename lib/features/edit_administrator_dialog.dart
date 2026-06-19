import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'administrators_controller.dart';
import 'admin_form_dialog.dart';

class EditAdministratorDialog extends StatelessWidget {
  const EditAdministratorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AdministratorsController>();
    return AdminFormDialog(
      title: 'Edit Administrator',
      actionLabel: 'Save',
      onAction: c.saveEdit,
      controller: c,
    );
  }
}
