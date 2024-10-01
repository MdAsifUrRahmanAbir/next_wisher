import 'package:next_wisher/utils/basic_screen_imports.dart';

class BottomNavController extends GetxController{
  RxInt selectedIndex = 0.obs;
  RxBool isDark = false.obs;

  void onItemTapped(int index) {
      selectedIndex.value = index;
  }

  List body = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          verticalSpace(10),
          PrimaryTextInputWidget(controller: TextEditingController(), labelText: "Search"),
          // const Center(child: Text("Inbox")),
        ],
      ),
    ),
    const Center(child: Text("Home")),
    const Center(child: Text("Menu")),
    const Center(child: Text("Language")),
    const Center(child: Text("Profile")),
  ];

  // List bodyTitle = [
  //   "How To Order",
  //   "Prices",
  //   "Shopping Cart",
  //   "Profile"
  // ];
}