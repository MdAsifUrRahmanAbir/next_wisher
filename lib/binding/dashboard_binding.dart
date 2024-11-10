import 'package:get/get.dart';

import '../controller/bottom_nav/bottom_nav_controller.dart';


class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
  }
}
