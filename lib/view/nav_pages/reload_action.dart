import 'package:next_wisher/controller/bottom_nav/dashboard_controller.dart';

import '../../controller/bottom_nav/bottom_nav_controller.dart';
import '../../controller/bottom_nav/message_controller.dart';
import '../../utils/basic_screen_imports.dart';

class ReloadAction extends StatelessWidget {
  const ReloadAction({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: child, onRefresh: () async {
      Get.find<DashboardController>().talentList.clear();
      Get.find<DashboardController>().categoriesList.clear();
      Get.find<BottomNavController>().mailCountProcess();
      Get.find<DashboardController>().homeProcess();
      Get.find<MessageController>().mailIndexProcess();
    });
  }
}
