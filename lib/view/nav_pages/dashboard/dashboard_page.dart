import 'package:next_wisher/backend/utils/custom_loading_api.dart';

import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import 'categories_widget.dart';
import 'featured_videos_widget.dart';
import 'featured_celebrities_widget.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          controller.isLoading ? const CustomLoadingAPI() : _bodyWidget()),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          PrimaryTextInputWidget(
              controller: TextEditingController(), labelText: Strings.search),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                CategoriesWidget(controller: controller),
                FeaturedCelebritiesWidget(controller: controller),
                FeaturedVideosWidget(controller: controller),
              ],
            ),
          )
        ],
      ),
    );
  }
}
