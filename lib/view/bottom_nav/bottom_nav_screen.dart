import '../../controller/bottom_nav/bottom_nav_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/drawer/drawer_widget.dart';
import 'custom_bottom_nav_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final controller = Get.put(BottomNavController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      body: _body(context),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
            selectedIndex: controller.selectedIndex.value,
            onItemTapped: controller.onItemTapped,
            controller: controller,
          scaffoldKey: _scaffoldKey
          )),
    );
  }

  _body(BuildContext context) {
    return SafeArea(
        child: Obx(() => controller.body[controller.selectedIndex.value]));
  }
}
