import 'package:get/get.dart';

class StatItem {
  final String value;
  final String label;
  const StatItem(this.value, this.label);
}

class DashboardController extends GetxController {
  final RxString adminName = 'Moni Roy'.obs;

  final List<StatItem> stats = const [
    StatItem('1320', 'Total Users'),
    StatItem('8', "Today's New Users"),
    StatItem('\$50000', 'Total Earned'),
  ];

  final List<String> growthMonths = const [
    'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  final List<double> growthValues = const [0, 7, 3.5, 9, 5, 14, 7, 20];

  final List<String> revenueMonths = const [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  final List<double> revenueValues = const [
    3800, 7800, 6000, 6000, 4800, 7800,
    6800, 6800, 5200, 5200, 6000, 3600
  ];
}
