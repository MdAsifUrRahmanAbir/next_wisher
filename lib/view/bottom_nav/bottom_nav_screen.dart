import '../../controller/bottom_nav/bottom_nav_controller.dart';
import '../../utils/basic_screen_imports.dart';
import 'custom_bottom_nav_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final controller = Get.put(BottomNavController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: DashboardAppBar(
      //     onMenuTap: () {
      //       debugPrint("Clicked");
      //       _scaffoldKey.currentState!.openDrawer();
      //       debugPrint("Clicked");
      //     },
      //     title: Obx(() => TitleHeading1Widget(
      //           text: controller.bodyTitle[controller.selectedIndex.value],
      //           color: CustomColor.secondaryLightColor,
      //           shadows: [
      //             Shadow(
      //                 color: Theme.of(context).primaryColor,
      //                 blurRadius: 0,
      //                 offset: const Offset(2, 2))
      //           ],
      //         )..animate()
      //         .fadeIn(duration: 900.ms, delay: 300.ms)
      //         .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad))),
      // drawer: DrawerWidget(),
      body: _body(context),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
            selectedIndex: controller.selectedIndex.value,
            onItemTapped: controller.onItemTapped,
            controller: controller,
          )),
    );
  }

  _body(BuildContext context) {
    return SafeArea(
        child: Obx(() => controller.body[controller.selectedIndex.value]));
  }
}
