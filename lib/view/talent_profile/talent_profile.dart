import 'package:chewie/chewie.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:next_wisher/backend/local_storage/local_storage.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../controller/book_now/book_now_controller.dart';
import '../../controller/bottom_nav/bottom_nav_controller.dart';
import '../../controller/bottom_nav/dashboard_controller.dart';
import '../../routes/routes.dart';
import '../../utils/strings.dart';
import '../../widgets/drawer/drawer_widget.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';
import '../book_now/pay_screen.dart';
import '../bottom_nav/custom_bottom_nav_bar.dart';

class TalentProfile extends StatelessWidget {
  TalentProfile({super.key, this.showBTM = true});

  final bool showBTM;
  final controller = Get.find<DashboardController>();
  final bookNowController = Get.put(BookNowController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const PrimaryAppBar(),

      //    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: PrimaryAppBar(onTap: () {
        Get.find<BottomNavController>().selectedIndex.value = showBTM ? 0 : 4;
        Navigator.pop(context);
      }),
      body: Obx(() => controller.isTalentLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
      bottomNavigationBar: !showBTM
          ? const SizedBox.shrink()
          : Obx(() => CustomBottomNavBar(
                selectedIndex:
                    Get.find<BottomNavController>().selectedIndex.value,
                onItemTapped: Get.find<BottomNavController>().onItemTapped,
                controller: Get.find<BottomNavController>(),
                scaffoldKey: _scaffoldKey,
              )),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.talentsModel.data;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TitleHeading2Widget(
              text: data.talent.name, fontWeight: FontWeight.bold),
          verticalSpace(Dimensions.paddingSizeVertical * .2),
          TitleHeading3Widget(
            text:
                "${data.talent.category.name} / ${data.talent.subcategory.name}",
            opacity: .5,
          ),
          verticalSpace(Dimensions.paddingSizeVertical * .5),
          StarRating(
            mainAxisAlignment: mainStart,
            rating: 0,
            allowHalfRating: false,
            onRatingChanged: (rating) {},
          ),
          verticalSpace(Dimensions.paddingSizeVertical * .2),
          TitleHeading3Widget(
              text: Strings.biography, fontWeight: FontWeight.bold),
          verticalSpace(Dimensions.paddingSizeVertical * .2),
          TitleHeading4Widget(
              text: data.talent.bio, fontWeight: FontWeight.bold),
          verticalSpace(Dimensions.paddingSizeVertical * .5),
          Container(
            height: 500,
            width: 300,
            color: Colors.black,
            child: Chewie(
              controller: controller.chewieController,
            ),
          ),
          verticalSpace(Dimensions.paddingSizeVertical * .5),
          TitleHeading4Widget(text: Strings.spokenLanguage),
          verticalSpace(Dimensions.paddingSizeVertical * .3),
          TitleHeading3Widget(text: Strings.personalizedVideo),
          verticalSpace(Dimensions.paddingSizeVertical * .5),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeHorizontal,
              vertical: Dimensions.paddingSizeVertical,
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(Dimensions.radius)),
            child: Column(
              children: [
                TitleHeading4Widget(opacity: .8, text: Strings.videoHint),
                verticalSpace(Dimensions.paddingSizeVertical * .1),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeHorizontal,
                      vertical: Dimensions.paddingSizeVertical * .4),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius * 2),
                      color: Theme.of(context).primaryColor),
                  child: TitleHeading4Widget(
                      text: "€${data.wish.amount.toStringAsFixed(2)}",
                      color: CustomColor.whiteColor),
                )
              ],
            ),
          ),
          verticalSpace(Dimensions.paddingSizeVertical * .5),
          Visibility(
            visible: LocalStorage.isUser(),
            child: Column(
              children: [
                PrimaryButton(
                    title: Strings.book,
                    onPressed: () {
                      bookNowController.paymentInfoProcess(data.talent.id);
                      Get.toNamed(Routes.bookNowScreen);
                    }),
                verticalSpace(Dimensions.paddingSizeVertical * .5),
                PrimaryButton(
                    title: Strings.sendTip,
                    backgroundColor: CustomColor.secondaryLightColor,
                    onPressed: () {
                      bookNowController.paymentInfoProcess(data.talent.id);
                      Get.to(PayScreen(isBook: false));
                    }),
                verticalSpace(Dimensions.paddingSizeVertical * .5),
              ],
            ),
          ),
          Card(
            color: CustomColor.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  verticalSpace(Dimensions.paddingSizeVertical * .2),
                  Row(
                    children: [
                      const Icon(Icons.check_box_outlined, color: Colors.green),
                      horizontalSpace(Dimensions.paddingSizeHorizontal * .4),
                      TitleHeading4Widget(
                          text: Strings.moneyBackGuarantee,
                          fontWeight: FontWeight.bold),
                    ],
                  ),

                  verticalSpace(Dimensions.paddingSizeVertical * .2),

                  TitleHeading5Widget(text: Strings.moneyBackGuaranteeDetails),
                  verticalSpace(Dimensions.paddingSizeVertical * .2),

                  // Row(
                  //   children: [
                  //
                  //   ],
                  // )
                ],
              ),
            ),
          ),
          verticalSpace(Dimensions.paddingSizeVertical * 1),
        ],
      ),
    );
  }
}
