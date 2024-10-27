import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import 'categories_widget.dart';
import 'featured_widget.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PrimaryTextInputWidget(
                controller: TextEditingController(), labelText: "Search"),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CategoriesWidget(controller: controller),
                  FeaturedWidget(controller: controller)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
