import 'package:next_wisher/backend/utils/custom_loading_api.dart';

import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';
import '../reload_action.dart';
import 'categories_widget.dart';
import 'featured_videos_widget.dart';
import 'featured_celebrities_widget.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => (controller.isLoading || controller.isCategoryLoading)
          ? const CustomLoadingAPI()
          : _bodyWidget()),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Image.asset(
                  'assets/bg_search.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: PrimaryTextInputWidget(
                  controller: controller.searchController,
                  labelText: Strings.search,
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
                          icon: const Icon(Icons.close),
                        ),
                ),
              ),
            ],
          ),
          // PrimaryTextInputWidget(
          //   controller: controller.searchController,
          //   labelText: Strings.search,
          //   onChanged: (value) {
          //     if (value.length.isGreaterThan(0)) {
          //       controller.talentList.value = controller
          //           .homeModel.data.homeTalents
          //           .where((item) =>
          //               item.name.toLowerCase().contains(value.toLowerCase()))
          //           .toList();
          //     } else {
          //       controller.talentList.value =
          //           controller.homeModel.data.homeTalents;
          //     }
          //   },
          //   suffixIcon: controller.talentList.length ==
          //           controller.homeModel.data.homeTalents.length
          //       ? null
          //       : IconButton(
          //           onPressed: () {
          //             controller.searchController.clear();
          //             controller.talentList.value =
          //                 controller.homeModel.data.homeTalents;
          //           },
          //           icon: const Icon(Icons.close)),
          // ),
          Expanded(
            child: ReloadAction(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CategoriesWidget(controller: controller),
                  FeaturedCelebritiesWidget(controller: controller),
                  // FeaturedVideosWidget(controller: controller),
                  verticalSpace(Dimensions.paddingSizeVertical * .2),
                  TitleHeading3Widget(
                      text: "How Nextwisher works",
                      padding: const EdgeInsets.all(2)),

                  _howToWork(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _howToWork() {
    return Column(
      children: [
        verticalSpace(Dimensions.paddingSizeVertical * .2),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius * .8),
              color: CustomColor.primaryBGLightColor),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(Get.context!).primaryColor,
                    child: TitleHeading3Widget(text: "1", color: Colors.white),
                  ),
                  horizontalSpace(Dimensions.paddingSizeHorizontal * .4),
                  Expanded(
                    child: TitleHeading4Widget(
                      text: "Find a celebrity",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              verticalSpace(Dimensions.paddingSizeVertical * .2),
              TitleHeading5Widget(
                  text: "Search and find a celebrity.", color: Colors.white),
            ],
          ),
        ),
        verticalSpace(Dimensions.paddingSizeVertical * .2),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius * .8),
              color: CustomColor.primaryBGLightColor),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(Get.context!).primaryColor,
                    child: TitleHeading3Widget(text: "2", color: Colors.white),
                  ),
                  horizontalSpace(Dimensions.paddingSizeHorizontal * .4),
                  Expanded(
                    child: TitleHeading4Widget(
                      text: "Submit your request",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              verticalSpace(Dimensions.paddingSizeVertical * .2),
              TitleHeading5Widget(
                  text: "Tell them what you want to include in the video.",
                  color: Colors.white),
            ],
          ),
        ),
        verticalSpace(Dimensions.paddingSizeVertical * .2),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius * .8),
              color: CustomColor.primaryBGLightColor),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(Get.context!).primaryColor,
                    child: TitleHeading3Widget(text: "3", color: Colors.white),
                  ),
                  horizontalSpace(Dimensions.paddingSizeHorizontal * .4),
                  Expanded(
                    child: TitleHeading4Widget(
                      text: "Get your video",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              verticalSpace(Dimensions.paddingSizeVertical * .2),
              TitleHeading5Widget(
                  text:
                      "It takes up to 5 days to complete your request. When ready, you will get it in your inbox.",
                  color: Colors.white),
            ],
          ),
        ),
        verticalSpace(Dimensions.paddingSizeVertical * .2),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius * .8),
              color: CustomColor.primaryBGLightColor),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(Get.context!).primaryColor,
                    child: TitleHeading3Widget(text: "4", color: Colors.white),
                  ),
                  horizontalSpace(Dimensions.paddingSizeHorizontal * .4),
                  Expanded(
                    child: TitleHeading4Widget(
                      text: "Enjoy",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              verticalSpace(Dimensions.paddingSizeVertical * .2),
              TitleHeading5Widget(
                  text:
                      "Enjoy your video and share it with friends and family.",
                  color: Colors.white),
            ],
          ),
        ),
        verticalSpace(Dimensions.paddingSizeVertical * .2),
      ],
    );
  }
}
