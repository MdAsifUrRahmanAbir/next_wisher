import 'dart:io';

import 'package:next_wisher/backend/services/api_endpoint.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';

import '../../backend/services/profile/talent_profile_model.dart';
import '../../controller/profile/profile_controller.dart';
import '../../controller/profile/profile_setup_controller.dart';
import '../../language/language_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../widgets/others/image_picker_dialog.dart';
// import '../../widgets/text_labels/title_heading5_widget.dart';
import '../../widgets/video_widget.dart';
// import '../web_video_widget.dart';
// import '../../widgets/inline_video_player.dart';
// import '../nav_pages/video_show_screen.dart';
import '../../widgets/tiktok_style_video_widget.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final controller = Get.put(ProfileSetupController());

  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _nextStep() {
    debugPrint(_currentStep.toString());
    if (_currentStep < 4) {
      setState(() {
        _currentStep++;
      });
      controller.uploadImage.value = false;
      controller.uploadVideo.value = false;

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
    debugPrint(_currentStep.toString());
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: TitleHeading3Widget(
                text: (_currentStep + 1).toString(),
                color: CustomColor.whiteColor),
          ),
        ),
        title: TitleHeading3Widget(
          text: _currentStep == 0
              ? languageSettingController.getTranslation("Add Profile Picture")
              : _currentStep == 1
                  ? languageSettingController
                      .getTranslation("Add Profile Video")
                  : _currentStep == 2
                      ? languageSettingController
                          .getTranslation("Add Biography")
                      : languageSettingController
                          .getTranslation("Select Languages"),
        ),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
                _buildStep4(),
              ],
            ),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentStep > 0) // Show Back button from Step 2 onward
              TextButton(
                onPressed: _previousStep,
                child: const TitleHeading4Widget(text: 'Back'),
              ),
            const Spacer(),
            if (_currentStep < 3) // Show Next button for all but last step
              Obx(() => Visibility(
                    visible: ((controller.uploadImage.value &&
                                _currentStep == 0) ||
                            Get.find<ProfileController>()
                                .talentProfileModelModel
                                .data
                                .userInfo
                                .profileImage
                                .isNotEmpty) ||
                        (controller.uploadVideo.value && _currentStep == 1) ||
                        _currentStep == 2 ||
                        _currentStep == 3,
                    child: TextButton(
                      onPressed: _nextStep,
                      child: TitleHeading4Widget(text: 'Next'),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  _buildStep1() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (controller.profileController.isLoading || controller.isLoading)
              ? const CustomLoadingAPI()
              : InkWell(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  onTap: () {
                    ImagePickerDialog.pickImage(context, onPicked: (File file) {
                      controller.imageFile.value = file.path;
                      controller.talentFileSetupProcess(
                          endPoint: ApiEndpoint.talentSetupImageURL,
                          filePath: file.path,
                          filedName: "image");
                    });
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * .7,
                    height: MediaQuery.sizeOf(context).height * .5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: controller.uploadImage.value
                            ? DecorationImage(
                                image:
                                    FileImage(File(controller.imageFile.value)))
                            : Get.find<ProfileController>()
                                    .talentProfileModelModel
                                    .data
                                    .userInfo
                                    .profileImage
                                    .isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(
                                        Get.find<ProfileController>()
                                            .talentProfileModelModel
                                            .data
                                            .userInfo
                                            .profileImage))
                                : null,
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                        color: Get.find<ProfileController>()
                                .talentProfileModelModel
                                .data
                                .userInfo
                                .profileImage
                                .isNotEmpty
                            ? Colors.black
                            : Theme.of(context).primaryColor),
                    child: TitleHeading3Widget(
                        text: controller.uploadImage.value
                            ? ""
                            : Get.find<ProfileController>()
                                    .talentProfileModelModel
                                    .data
                                    .userInfo
                                    .profileImage
                                    .isNotEmpty
                                ? ""
                                : Strings.selectProfilePicture,
                        color: CustomColor.whiteColor),
                  ),
                ),
          verticalSpace(Dimensions.paddingSizeVertical * .9),
          Get.find<ProfileController>()
                  .talentProfileModelModel
                  .data
                  .userInfo
                  .profileImage
                  .isNotEmpty
              ? PrimaryButton(
                  title: "Update",
                  onPressed: () {
                    ImagePickerDialog.pickImage(context, onPicked: (File file) {
                      controller.imageFile.value = file.path;
                      controller.talentFileSetupProcess(
                          endPoint: ApiEndpoint.talentSetupImageURL,
                          filePath: file.path,
                          filedName: "image");
                    });
                  },
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  _buildStep2() {
    debugPrint("VIDEO >>");
    debugPrint(Get.find<ProfileController>()
        .talentProfileModelModel
        .data
        .userInfo
        .videoPath);
    return Center(
      child: Obx(() => (controller.profileController.isLoading ||
              controller.isLoading)
          ? const CustomLoadingAPI()
          : ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TitleHeading3Widget(text: "Profile Video", color: Colors.red),
                TitleHeading4Widget(
                    text:
                        "Present yourself and always mention the platform (Nextwisher). Feel free to personalize your presentation message. The video should not exceed 50 MB"),
                verticalSpace(5),
                InkWell(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  onTap: () {
                    ImagePickerDialog.pickVideo(context, onPicked: (File file) {
                      controller.videoFile.value = file.path;
                      controller.talentFileSetupProcess(
                          endPoint: ApiEndpoint.talentSetupVideoURL,
                          filePath: file.path,
                          filedName: "video_file");
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeHorizontal),
                    width: double.infinity,
                    height: 400,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                        color: controller.uploadVideo.value
                            ? Colors.black
                            : Theme.of(context).primaryColor),
                    child: controller.uploadVideo.value
                        ? VideoWidget(
                            videoUrl: File(controller.videoFile.value))
                        : Get.find<ProfileController>()
                                .talentProfileModelModel
                                .data
                                .userInfo
                                .videoPath
                                .isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  // Tapping the container no longer needed with the TikTokStyleVideoWidget
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.7, // 70% of screen width
                                  height: MediaQuery.of(context).size.width * 1.3, // 16:9 portrait aspect ratio
                                  color: Colors.transparent,
                                  child: Center(
                                    child: TikTokStyleVideoWidget(
                                      videoUrl: Get.find<ProfileController>()
                                          .talentProfileModelModel
                                          .data
                                          .userInfo
                                          .videoPath,
                                      thumbnailUrl: Get.find<ProfileController>()
                                          .talentProfileModelModel
                                          .data
                                          .userInfo
                                          .profileImage.isNotEmpty 
                                              ? Get.find<ProfileController>()
                                                  .talentProfileModelModel
                                                  .data
                                                  .userInfo
                                                  .profileImage
                                              : "https://placehold.co/600x400/000000/FFFFFF/png?text=Video+Preview",
                                      width: MediaQuery.of(context).size.width * 0.7,
                                      height: MediaQuery.of(context).size.width * 1.3,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                ),
                              )
                            : TitleHeading3Widget(
                                text: controller.uploadVideo.value
                                    ? Strings.uploaded
                                    : Strings.selectProfileVideo,
                                color: CustomColor.whiteColor),
                  ),
                ),
                verticalSpace(Dimensions.paddingSizeVertical * .9),
                !controller.uploadVideo.value
                    ? PrimaryButton(
                        title: Strings.update,
                        onPressed: () {
                          ImagePickerDialog.pickVideo(context,
                              onPicked: (File file) {
                            controller.videoFile.value = file.path;
                            controller.talentFileSetupProcess(
                                endPoint: ApiEndpoint.talentSetupVideoURL,
                                filePath: file.path,
                                filedName: "video_file");
                          });
                        })
                    : const SizedBox.shrink()
              ],
            )),
    );
  }

  _buildStep3() {
    return Center(
      child: Obx(
          () => (controller.profileController.isLoading || controller.isLoading)
              ? const CustomLoadingAPI()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    PrimaryTextInputWidget(
                      maxLine: 8,
                      controller: controller.bioController,
                      labelText: Strings.biography,
                      hint: Strings.enterYourBiography,
                    ),
                    const SizedBox(height: 20),
                    CustomDropDown<Category>(
                      items: controller.profileController.categoryList,
                      onChanged: (value) {
                        controller.profileController.selectedCategory.value =
                            value!;
                        controller.profileController.subCategoryList.value =
                            controller
                                .profileController.selectedCategory.value.child;
                        controller.profileController.selectedSubCategory.value =
                            controller.profileController.selectedCategory.value
                                .child.first;
                      },
                      hint: controller
                          .profileController.selectedCategory.value.name,
                      title: Strings.selectCategory,
                    ),
                    verticalSpace(Dimensions.marginBetweenInputBox),
                    Obx(() => CustomDropDown<Child>(
                          items: controller.profileController.subCategoryList,
                          onChanged: (value) {
                            controller.profileController.selectedSubCategory
                                .value = value!;
                          },
                          hint: controller
                              .profileController.selectedSubCategory.value.name,
                          title: Strings.selectCategory,
                        )),
                    verticalSpace(Dimensions.marginBetweenInputBox),
                    PrimaryButton(
                        title: Strings.update,
                        onPressed: () {
                          controller.talentSetupProcess();
                        })
                  ],
                )),
    );
  }

  _buildStep4() {
    return Center(
      child: (controller.profileController.isLoading || controller.isLoading)
          ? const CustomLoadingAPI()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: crossStart,
              children: [
                const TitleHeading4Widget(
                    text:
                        'Please select all languages in which you can respond to a request'),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8.0,
                  children: controller.languages.map((language) {
                    return Obx(() => FilterChip(
                          label: TitleHeading4Widget(
                            text: language,
                            color: controller.selectedLanguages
                                    .toString()
                                    .contains(language)
                                ? Colors.green
                                : null,
                            fontWeight: controller.selectedLanguages
                                    .toString()
                                    .contains(language)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          selected: controller.selectedLanguages
                              .toString()
                              .contains(language),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                if (!controller.selectedLanguages
                                    .toString()
                                    .contains(language)) {
                                  controller.selectedLanguages.add(language);
                                }
                              } else {
                                controller.selectedLanguages.remove(language);
                              }
                              debugPrint(language);
                              debugPrint(selected.toString());
                              debugPrint(controller.selectedLanguages
                                  .toString()
                                  .contains(language)
                                  .toString());
                            });
                          },
                        ));
                  }).toList(),
                ),
                verticalSpace(Dimensions.marginBetweenInputBox),
                PrimaryButton(
                    title: Strings.update,
                    onPressed: () {
                      controller.talentSupportedLanguageProcess();
                    })
              ],
            ),
    );
  }
}
