import 'package:cached_network_image/cached_network_image.dart';
import 'package:next_wisher/backend/utils/no_data_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../backend/services/dashboard/home_model.dart';
import '../../../controller/bottom_nav/bottom_nav_controller.dart';
import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';

import '../../../utils/strings.dart';
import '../../../widgets/drawer/drawer_widget.dart';
import '../../bottom_nav/custom_bottom_nav_bar.dart';

class FeaturedCelebritiesScreen extends StatelessWidget {
  FeaturedCelebritiesScreen({super.key, required this.showSearchBar, this.appTitle = ""});
  final bool showSearchBar;
  final String appTitle;
  final controller = Get.find<DashboardController>();
     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
          Get
              .find<BottomNavController>()
              .selectedIndex
              .value = 0;

          controller.talentList.value = controller.homeModel.data.homeTalents;
          Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        //    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        appBar: PrimaryAppBar(
          color: appTitle.isEmpty ? null : Colors.black,
          title: appTitle,
            onTap: () {
          Get.find<BottomNavController>().selectedIndex.value = 0;
          controller.talentList.value = controller.homeModel.data.homeTalents;
          Navigator.pop(context);
        }),
        body: _bodyWidget(),
        bottomNavigationBar: Obx(() => CustomBottomNavBar(
              selectedIndex: Get.find<BottomNavController>().selectedIndex.value,
              onItemTapped: Get.find<BottomNavController>().onItemTapped,
              controller: Get.find<BottomNavController>(),
          scaffoldKey: _scaffoldKey,
            )),
      ),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() => Column(
            children: [
              !showSearchBar
                  ? const SizedBox()
                  : PrimaryTextInputWidget(
                      controller: controller.searchController,
                      onChanged: (value) {
                        if (value.length.isGreaterThan(0)) {
                          controller.talentList.value = controller
                              .homeModel.data.homeTalents
                              .where((item) => item.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        } else {
                          controller.talentList.value =
                              controller.homeModel.data.homeTalents;
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
                              },
                              icon: const Icon(Icons.close)),
                      labelText: Strings.search),
              Expanded(
                child: controller.talentList.isEmpty ? const NoDataWidget(): GridView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: .65,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    HomeTalent data = controller.talentList[index];
                    return GestureDetector(
                      onTap: () {
                        controller.talentsProcess(data.userId.toString());
                        Get.toNamed(Routes.talentProfileNext);
                      },
                      child: Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  // image: DecorationImage(
                                  //     image: NetworkImage(data.profileImage),
                                  //     fit: BoxFit.cover),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius * .4)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                imageUrl: data.profileImage,
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                          TitleHeading3Widget(
                              text: data.name,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis),
                          data.amount.isEmpty
                              ? const SizedBox(
                                  height: 25,
                                )
                              : TitleHeading3Widget(
                                  text:
                                      "€${data.amount.first.amount.toStringAsFixed(2)}",
                                  fontWeight: FontWeight.bold),
                        ],
                      ),
                    );
                  },
                  itemCount: controller.talentList.length,
                ),
              ),
            ],
          )),
    );
  }
}
