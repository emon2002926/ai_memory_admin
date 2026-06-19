import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'administrators_controller.dart';
import 'admin_form_dialog.dart';

class NewAdministratorDialog extends StatelessWidget {
  const NewAdministratorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AdministratorsController>();
    return AdminFormDialog(
      title: 'New Administrators Profile Create',
      actionLabel: 'Create',
      onAction: c.createAdmin,
      controller: c,
    );
  }
}
