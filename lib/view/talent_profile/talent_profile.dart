import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:intl/intl.dart';
import 'package:next_wisher/backend/local_storage/local_storage.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/backend/utils/custom_snackbar.dart';
import 'package:next_wisher/language/language_controller.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';
import 'package:shimmer/shimmer.dart';

import '../../backend/services/dashboard/talents_model.dart';
import '../../controller/book_now/book_now_controller.dart';
import '../../controller/bottom_nav/bottom_nav_controller.dart';
import '../../controller/bottom_nav/dashboard_controller.dart';
import '../../routes/routes.dart';
import '../../utils/strings.dart';
import '../../widgets/drawer/drawer_widget.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';
import '../book_now/pay_screen.dart';
import '../bottom_nav/custom_bottom_nav_bar.dart';
import '../web_video_widget.dart';

class TalentProfile extends StatelessWidget {
  TalentProfile({super.key, this.showBTM = true});

  final bool showBTM;
  final controller = Get.find<DashboardController>();
  final bookNowController = Get.put(BookNowController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<BottomNavController>().selectedIndex.value = showBTM ? 0 : 4;
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
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
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.talentsModel.data;
    return SafeArea(
      child: Column(
        children: [
          // Expanded(
          //   flex: 5,
          //   child: Chewie(
          //     controller: controller.chewieController,
          //   ),
          // ),
          Expanded(
            flex: 7,
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                TitleHeading2Widget(
                    text: data.talent.name, fontWeight: FontWeight.bold),
                verticalSpace(Dimensions.paddingSizeVertical * .2),
                TitleHeading3Widget(
                  text:
                      "${languageSettingController.getTranslation(data.talent.category.name)} / ${languageSettingController.getTranslation(data.talent.subcategory.name)}",
                  opacity: .5,
                ),
                verticalSpace(Dimensions.paddingSizeVertical * .5),
                Row(
                  children: [
                    StarRating(
                      mainAxisAlignment: mainStart,
                      rating: controller.talentsModel.data.talent.ratingPercent,
                      allowHalfRating: false,
                      onRatingChanged: (rating) {
                        showRatingsDialog(context,
                            controller.talentsModel.data.talent.rating);
                      },
                    ),
                    InkWell(
                      onTap: () {
                        showRatingsDialog(context,
                            controller.talentsModel.data.talent.rating);
                      },
                      child: TitleHeading3Widget(
                          text:
                              " ${controller.talentsModel.data.talent.ratingPercent.toStringAsFixed(1)} ",
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        showRatingsDialog(context,
                            controller.talentsModel.data.talent.rating);
                      },
                      child: TitleHeading5Widget(
                        text:
                            "(${controller.talentsModel.data.talent.totalRating})",
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                verticalSpace(Dimensions.paddingSizeVertical * .2),
                TitleHeading3Widget(
                    text: Strings.biography, fontWeight: FontWeight.bold),
                verticalSpace(Dimensions.paddingSizeVertical * .2),
                TitleHeading4Widget(
                    text: data.talent.bio, fontWeight: FontWeight.bold),
                verticalSpace(Dimensions.paddingSizeVertical * .5),
                // !controller.talentsModel.data.talent.videoPath.contains("mov") ? VideoPlayerScreen(
                //   videoUrl: controller.talentsModel.data.talent.videoPath,
                // ) :

                // InkWell(
                //   onTap: () {
                //     Get.to(WebVideoWidget(
                //         link:
                //             controller.talentsModel.data.talent.videoPathWeb));
                //   },
                //   child: Container(
                //     height: 250,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         image: DecorationImage(
                //             image: NetworkImage(data.talent.profileImage))),
                //     child: CircleAvatar(
                //         radius: 25,
                //         backgroundColor: Colors.red,
                //         child: Icon(Icons.play_arrow_outlined,
                //             size: 44, color: Colors.white)),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    Get.to(WebVideoWidget(
                        link:
                            controller.talentsModel.data.talent.videoPathWeb));
                  },
                  child: SizedBox(
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          // width: double.infinity,
                          height: double.infinity,
                          imageUrl: data.talent.profileImage,
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
                        CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.play_arrow_outlined,
                                size: 44, color: Colors.white))
                      ],
                    ),
                  )
                ),

                verticalSpace(Dimensions.paddingSizeVertical * .5),
                data.talent.supportedLanguages.isEmpty
                    ? SizedBox.shrink()
                    : Row(
                        children: [
                          TitleHeading4Widget(text: Strings.spokenLanguage),
                          horizontalSpace(2),
                          TitleHeading4Widget(
                              text: jsonDecode(data.talent.supportedLanguages)
                                  .join(", ")),
                        ],
                      ),
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
                Column(
                  children: [
                    Visibility(
                      visible: data.wish.status,
                      child: PrimaryButton(
                          title: Strings.book,
                          onPressed: () {
                            // controller.chewieController.pause();
                            if (LocalStorage.isUser()) {
                              bookNowController
                                  .paymentInfoProcess(data.talent.id);
                              Get.toNamed(Routes.bookNowScreen);
                            } else {
                              CustomSnackBar.error(Strings.errorTalentUser);
                            }
                          }),
                    ),
                    verticalSpace(Dimensions.paddingSizeVertical * .5),
                    Visibility(
                      visible: data.tips.status,
                      child: PrimaryButton(
                          title: Strings.sendTip,
                          backgroundColor: CustomColor.secondaryLightColor,
                          onPressed: () {
                            // controller.chewieController.pause();
                            if (LocalStorage.isUser()) {
                              bookNowController
                                  .paymentInfoProcess(data.talent.id);
                              Get.to(PayScreen(isBook: false));
                            } else {
                              CustomSnackBar.error(Strings.errorTalentUser);
                            }
                          }),
                    ),
                    verticalSpace(Dimensions.paddingSizeVertical * .5),
                  ],
                ),
                Card(
                  color: Get.isDarkMode ? Colors.black : CustomColor.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        verticalSpace(Dimensions.paddingSizeVertical * .2),
                        Row(
                          children: [
                            const Icon(Icons.check_box_outlined,
                                color: Colors.green),
                            horizontalSpace(
                                Dimensions.paddingSizeHorizontal * .4),
                            TitleHeading4Widget(
                                text: Strings.moneyBackGuarantee,
                                fontWeight: FontWeight.bold),
                          ],
                        ),

                        verticalSpace(Dimensions.paddingSizeVertical * .2),

                        TitleHeading5Widget(
                            text: Strings.moneyBackGuaranteeDetails),
                        TitleHeading5Widget(
                            text: Strings.moneyBackGuaranteeDetails2),
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
          ),
        ],
      ),
    );
  }

  // Dialog Widget
  void showRatingsDialog(BuildContext context, List<Rating> ratings) {
    double averageRating = ratings.isNotEmpty
        ? ratings.map((r) => r.rating).reduce((a, b) => a + b) / ratings.length
        : 0;

    // Group ratings by stars
    Map<int, int> ratingsCount = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var r in ratings) {
      ratingsCount[r.rating.toInt()] = (ratingsCount[r.rating] ?? 0) + 1;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ratings"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Average Rating Display
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.yellow,
                      child: Text(
                        averageRating.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text("Out of 5", style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 16),
                // Star Ratings Summary
                ...ratingsCount.entries.map((entry) {
                  return Row(
                    children: [
                      Text("${entry.key} ★", style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: ratings.isNotEmpty
                              ? entry.value / ratings.length
                              : 0,
                          backgroundColor: Colors.grey.shade300,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.yellow),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(entry.value.toString(),
                          style: TextStyle(fontSize: 16)),
                    ],
                  );
                }),
                SizedBox(height: 16),
                // Individual Ratings
                Text("User Reviews",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                ...ratings.map((r) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                color: index < r.rating
                                    ? Colors.yellow
                                    : Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text("${r.rating}/5"),
                        ],
                      ),
                      Text(
                        r.feedback,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        DateFormat.yMMMd().format(r.createdAt),
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
