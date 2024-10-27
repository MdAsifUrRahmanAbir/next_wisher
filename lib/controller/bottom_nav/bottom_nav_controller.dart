import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../view/nav_pages/dashboard/dashboard_page.dart';
import '../../view/nav_pages/message/messages_page.dart';
import '../../view/nav_pages/profile/profile_page.dart';

class BottomNavController extends GetxController{
  RxInt selectedIndex = 0.obs;
  RxBool isDark = false.obs;

  void onItemTapped(int index) {
      selectedIndex.value = index;
  }

  List body = [
    MessagePage(),
    DashboardPage(),
    const Center(child: Text("Menu")),
    const Center(child: Text("Language")),
    const ProfilePage()
  ];

  // List bodyTitle = [
  //   "How To Order",
  //   "Prices",
  //   "Shopping Cart",
  //   "Profile"
  // ];
}