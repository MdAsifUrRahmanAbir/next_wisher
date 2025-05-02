import 'package:chewie/chewie.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:video_player/video_player.dart';
import 'package:next_wisher/widgets/tiktok_style_video_widget.dart';

import '../../../backend/download_file.dart';
import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/services/wish/mail_index_model.dart';
import '../../../controller/bottom_nav/message_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

class UserInboxScreen extends StatefulWidget with DownloadFile {
  const UserInboxScreen({super.key, required this.data});

  final Email data;

  @override
  State<UserInboxScreen> createState() => _UserInboxScreenState();
}

class _UserInboxScreenState extends State<UserInboxScreen> {
  @override
  void initState() {
    super.initState();
  }

  RxBool isDownloaded = false.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          appBar: PrimaryAppBar(onTap: (){
            Navigator.pop(context);
          },),
          body: SafeArea(
              child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              widget.data.fulfilledAt
                  ? TitleHeading3Widget(
                      text: "Request Fulfilled".toUpperCase(),
                      color: Colors.green)
                  : SizedBox.shrink(),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              TitleHeading3Widget(
                  text: widget.data.userName,
                  color: Theme.of(context).primaryColor),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              Container(
                height: MediaQuery.sizeOf(context).height * .6,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.6),
                  borderRadius: BorderRadius.circular(Dimensions.radius * .5),
                ),
                child: !widget.data.downloadStatus && LocalStorage.isUser()
                    ? Column(
                        mainAxisAlignment: mainCenter,
                        children: [
                          Icon(Icons.video_library_outlined,
                              size: Dimensions.iconSizeLarge * 2),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeHorizontal * .6,
                                vertical: Dimensions.paddingSizeVertical * .4),
                            child: Obx(() =>
                                Get.find<MessageController>().isDownloadLoading
                                    ? const CustomLoadingAPI()
                                    : PrimaryButton(
                                        title: Strings.download,
                                        onPressed: () {
                                          widget.downloadFile(
                                              url: widget.data.attachment,
                                              name: widget.data.attachment
                                                  .split("/")
                                                  .last,
                                              onSuccess: () {
                                                Get.find<MessageController>()
                                                    .downloadFileProcess(
                                                        widget.data.attachment,
                                                        widget.data.id.toString())
                                                    .then((value) {
                                                  isDownloaded.value = true;
                                                  Get.offAllNamed(Routes.btmScreen, arguments: true);
                                                });
                                              });
                                        })),
                          )
                        ],
                      )
                    : TikTokStyleVideoWidget(
                        videoUrl: widget.data.attachment,
                        thumbnailUrl: "https://placehold.co/600x400/000000/FFFFFF/png?text=Video",
                        height: MediaQuery.sizeOf(context).height * .6,
                        borderRadius: BorderRadius.circular(Dimensions.radius * .5),
                      ),
              ),
              verticalSpace(10),
              widget.data.mailName.isNotEmpty
                  ? Column(
                      children: [
                        _row(Strings.name, widget.data.name),
                        verticalSpace(Dimensions.paddingSizeVertical * .2),
                      ],
                    )
                  : Column(
                      children: [
                        _row(Strings.forText, widget.data.emailFor),
                        verticalSpace(Dimensions.paddingSizeVertical * .2),
                        _row(Strings.from, widget.data.from),
                        verticalSpace(Dimensions.paddingSizeVertical * .2),
                      ],
                    ),
              _row(Strings.gender, widget.data.genders),
              verticalSpace(Dimensions.paddingSizeVertical * .2),
              _row(Strings.occasion, widget.data.occasion),
              verticalSpace(Dimensions.paddingSizeVertical * .2),
              _row(Strings.message, widget.data.instructions),
              Visibility(
                visible: (widget.data.downloadStatus || isDownloaded.value) && LocalStorage.isUser(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeHorizontal * .6,
                      vertical: Dimensions.paddingSizeVertical * .4),
                  child: PrimaryButton(
                      title: Strings.download,
                      onPressed: () {
                        widget.downloadFile(
                            url: widget.data.attachment,
                            name: widget.data.attachment.split("/").last,
                            onSuccess: () {});
                      }),
                ),
              ),
              LocalStorage.isUser()
                  ? Obx(() => Get.find<MessageController>().isRattingCheckLoading
                      ? const SizedBox.shrink()
                      : Get.find<MessageController>()
                              .ratingCheckModelModel
                              .data
                              .ratingStatus
                          ? const SizedBox.shrink()
                          : Visibility(
                              visible: widget.data.downloadStatus ||
                                  isDownloaded.value,
                              child: Column(
                                crossAxisAlignment: crossStart,
                                children: [
                                  verticalSpace(
                                      Dimensions.paddingSizeVertical * .3),
                                  TitleHeading3Widget(text: Strings.yourRatting),
                                  verticalSpace(
                                      Dimensions.paddingSizeVertical * .2),
                                  Obx(() => StarRating(
                                        mainAxisAlignment: mainStart,
                                        rating: Get.find<MessageController>()
                                            .ratting
                                            .value,
                                        allowHalfRating: false,
                                        onRatingChanged: (double rating) {
                                          Get.find<MessageController>()
                                              .ratting
                                              .value = rating;
                                        },
                                      )),
                                  verticalSpace(
                                      Dimensions.paddingSizeVertical * .5),
                                  PrimaryTextInputWidget(
                                    controller: Get.find<MessageController>()
                                        .feedbackController,
                                    labelText: Strings.feedback,
                                    hint: Strings.writeYourFeedback,
                                    maxLine: 5,
                                  ),
                                  verticalSpace(
                                      Dimensions.paddingSizeVertical * .3),
                                  Row(
                                    mainAxisAlignment: mainEnd,
                                    children: [
                                      Obx(() => Get.find<MessageController>()
                                              .isSubmitLoading
                                          ? const CustomLoadingAPI()
                                          : OutlinedButton(
                                              onPressed: () {
                                                Get.find<MessageController>()
                                                    .ratingSubmitProcess(
                                                        talentId: widget
                                                            .data.talentId
                                                            .toString(),
                                                        userId: widget.data.userId
                                                            .toString(),
                                                        earningId: widget
                                                            .data.talentEarningId
                                                            .toString());
                                              },
                                              child: TitleHeading3Widget(
                                                  text: Strings.send)))
                                    ],
                                  ),
                                  verticalSpace(
                                      Dimensions.paddingSizeVertical * .3),
                                ],
                              ),
                            ))
                  : const SizedBox.shrink()
            ],
          ))),
    );
  }

  _row(String title, String value) {
    return Row(
      children: [
        TitleHeading4Widget(text: "$title: ", fontWeight: FontWeight.bold),
        horizontalSpace(Dimensions.paddingSizeHorizontal * .2),
        Expanded(
            child: TitleHeading5Widget(
          text: value,
          opacity: .7,
        )),
      ],
    );
  }
}
