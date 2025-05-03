import 'package:flutter_animate/flutter_animate.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/controller/bottom_nav/dashboard_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../../utils/strings.dart';
import '../../view/more_screen/more_screen.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius * 2))),
      child: Drawer(
        child: Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : _allItemListView(context)),
      ),
    );
  }

  _drawerItems(BuildContext context) {
    return Column(
      children: AnimateList(children: [
        verticalSpace(Dimensions.marginSizeVertical * 1),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ExpansionTile(
              dense: true,
              title: TextButton(
                onPressed: () {
                  controller.categoryModelProcess(controller.categoriesList[index].slug, controller.categoriesList[index].name);
                },
                child: TitleHeading3Widget(
                    text: controller.categoriesList[index].name),
              ),
              children: [
                ...List.generate(
                    controller.categoriesList[index].child.length,
                    (i) => TextButton(
                        onPressed: () {
                          controller.categoryModelProcess(controller.categoriesList[index].child[i].slug, controller.categoriesList[index].child[i].name);
                        },
                        child: TitleHeading3Widget(
                            text: controller
                                .categoriesList[index].child[i].name)))
              ],
            );
          },
          itemCount: controller.categoriesList.length,
        ),
        verticalSpace(Dimensions.marginSizeVertical * .2),
      ]),
    );
  }

  _allItemListView(BuildContext context) {
    return ListView(shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        // verticalSpace(Dimensions.heightSize * .2),
        Container(
          alignment: Alignment.center,
          height: Dimensions.buttonHeight * .7,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              SizedBox(width: 20,),
              TitleHeading3Widget(text: Strings.menu, color: Colors.white),
              IconButton(onPressed: (){
                Get.to(MoreScreen());
              }, icon: Icon(Icons.info_outline, color: Colors.white)),
            ],
          ),
        ),
        // SizedBox(
        //   height: MediaQuery.sizeOf(context).height * .07,
        //   child: Stack(
        //     children: [
        //       Align(
        //         alignment: Alignment.centerLeft,
        //         child: IconButton(
        //           onPressed: () => Get.close(1),
        //           icon: Icon(
        //             Icons.arrow_back,
        //             size: Dimensions.iconSizeDefault * 1.2,
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        _drawerItems(context),
      ],
    );
  }
}
