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
          (controller.isLoading || controller.isCategoryLoading) ? const CustomLoadingAPI() : _bodyWidget()),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          PrimaryTextInputWidget(
            controller: controller.searchController,
            labelText: Strings.search,
            onChanged: (value) {
              if(value.length.isGreaterThan(2)){
                controller.talentList.value  = controller.homeModel.data.homeTalents.where((item) => item.name.toLowerCase().contains(value.toLowerCase())).toList();
              }else{
                controller.talentList.value  = controller.homeModel.data.homeTalents;
              }
            },
            suffixIcon: controller.talentList.length ==
                controller.homeModel.data.homeTalents.length
                ? null
                : IconButton(
                onPressed: () {
                  controller.searchController.clear();
                  controller.talentList.value =
                      controller.homeModel.data.homeTalents;
                }, icon: const Icon(Icons.close)),
          ),
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
