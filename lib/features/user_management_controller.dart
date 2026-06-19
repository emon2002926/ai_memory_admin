import 'package:get/get.dart';

class UserRow {
  final String sl;
  final String name;
  final String email;
  final String subscription;
  const UserRow({
    required this.sl,
    required this.name,
    required this.email,
    required this.subscription,
  });
}

class UserManagementController extends GetxController {
  final RxList<UserRow> users = <UserRow>[
    UserRow(sl: '#1233', name: 'Kathryn Murp', email: 'bockely@att.com', subscription: 'Premium'),
    UserRow(sl: '#1233', name: 'Devon Lane', email: 'csilvers@rizon.com', subscription: 'Free'),
    UserRow(sl: '#1233', name: 'Foysal Rahman', email: 'qamaho@mail.com', subscription: 'Premium'),
    UserRow(sl: '#1233', name: 'Hari Danang', email: 'xterris@gmail.com', subscription: 'Premium'),
    UserRow(sl: '#1233', name: 'Floyd Miles', email: 'xterris@gmail.com', subscription: 'Premium'),
    UserRow(sl: '#1233', name: 'Eleanor Pena', email: 'xterris@gmail.com', subscription: 'Premium'),
    UserRow(sl: '#1233', name: 'Devon Lane', email: 'xterris@gmail.com', subscription: 'Premium'),
    UserRow(sl: '#1233', name: 'Hari Danang', email: 'xterris@gmail.com', subscription: 'Premium'),
    UserRow(sl: '#1233', name: 'Devon Lane', email: 'xterris@gmail.com', subscription: 'Premium'),
    UserRow(sl: '#1233', name: 'Hari Danang', email: 'xterris@gmail.com', subscription: 'Family'),
  ].obs;

  final RxInt currentPage = 1.obs;
  final int totalPages = 1;

  void blockUser(int index) {
    Get.snackbar('Blocked', '${users[index].name} has been blocked.');
  }

  void prevPage() {
    if (currentPage.value > 1) currentPage.value--;
  }

  void nextPage() {
    if (currentPage.value < totalPages) currentPage.value++;
  }

  void goToPage(int page) => currentPage.value = page;
}
