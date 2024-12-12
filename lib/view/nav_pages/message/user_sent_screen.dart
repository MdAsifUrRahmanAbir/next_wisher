import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/backend/utils/custom_snackbar.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/services/wish/mail_index_model.dart';
import '../../../controller/bottom_nav/message_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';

class UserSentScreen extends StatefulWidget {
  const UserSentScreen({super.key, required this.data});

  final Email data;

  @override
  State<UserSentScreen> createState() => _UserSentScreenState();
}

class _UserSentScreenState extends State<UserSentScreen> {
  File? file;

  @override
  Widget build(BuildContext context) {
    debugPrint("Attachment >> ${widget.data.attachment}");
    return Scaffold(
        appBar: const PrimaryAppBar(),
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TitleHeading3Widget(
                text: widget.data.userName,
                color: Theme.of(context).primaryColor),
            verticalSpace(Dimensions.paddingSizeVertical * .4),
            widget.data.name.isNotEmpty
                ? Column(
                    children: [
                      widget.data.from.isNotEmpty
                          ? SizedBox.shrink()
                          : _row(Strings.name, widget.data.mailName),
                      widget.data.from.isEmpty
                          ? SizedBox.shrink()
                          : _row(Strings.from, widget.data.from),
                      widget.data.from.isEmpty
                          ? SizedBox.shrink()
                          : _row(Strings.forText, widget.data.emailFor),
                      verticalSpace(Dimensions.paddingSizeVertical * .2),
                    ],
                  )
                : Column(
                    children: [
                      _row(Strings.forText, widget.data.emailFor),
                      verticalSpace(Dimensions.paddingSizeVertical * .2),
                      verticalSpace(Dimensions.paddingSizeVertical * .2),
                    ],
                  ),
            _row(Strings.gender, widget.data.genders),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            _row(Strings.occasion, widget.data.occasion),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            _row(Strings.instruction, widget.data.instructions),
            verticalSpace(Dimensions.paddingSizeVertical * .8),
            Visibility(
                visible: (!LocalStorage.isUser() && widget.data.attachment.isEmpty),
                child: Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    PrimaryTextInputWidget(
                      controller: Get.find<MessageController>().inboxController,
                      labelText: Strings.message,
                      hint: Strings.writeYourMessage,
                      maxLine: 5,
                    ),
                    verticalSpace(Dimensions.paddingSizeVertical * .3),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                              if (result != null) {
                                setState(() {
                                  file = File(result.files.single.path!);
                                  debugPrint("Picked ${file!.path}");
                                });
                              } else {
                                // User canceled the picker
                              }
                            },
                            icon: Transform.rotate(
                                angle: 45 * pi / 180,
                                child: Icon(
                                  Icons.attach_file_outlined,
                                  color: Theme.of(context).primaryColor,
                                ))),
                        horizontalSpace(Dimensions.paddingSizeHorizontal * 4),
                        Expanded(
                            child: Obx(() =>
                                Get.find<MessageController>().isReplyLoading
                                    ? const CustomLoadingAPI()
                                    : PrimaryButton(
                                        title: Strings.send,
                                        onPressed: () {
                                          if (file != null &&
                                              isVideoFile(file!.path)) {
                                            Get.find<MessageController>()
                                                .mailReplyProcess(
                                                    widget.data.id.toString(),
                                                    file!.path);
                                          } else {
                                            CustomSnackBar.error(
                                                Strings.selectVideoFile);
                                          }
                                        }))),
                      ],
                    ),
                    verticalSpace(Dimensions.paddingSizeVertical * .3),
                    TitleHeading5Widget(
                      text: file != null ? file!.path : Strings.selectVideoFile,
                      opacity: .7,
                      color: CustomColor.redColor,
                    )
                  ],
                ))
          ],
        )));
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

bool isVideoFile(String fileName) {
  List<String> videoExtensions = ['mp4', 'avi', 'mkv', 'mov', 'flv'];
  String extension = fileName.split('.').last.toLowerCase();
  return videoExtensions.contains(extension);
}
