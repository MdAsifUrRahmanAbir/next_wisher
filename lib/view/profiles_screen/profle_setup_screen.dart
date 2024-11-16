import 'dart:io';

import 'package:next_wisher/backend/services/api_endpoint.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';

import '../../backend/services/profile/talent_profile_model.dart';
import '../../controller/profile/profile_setup_controller.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../widgets/others/image_picker_dialog.dart';

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
              ? "Add Profile Picture"
              : _currentStep == 1
                  ? "Add Profile Video"
                  : _currentStep == 2
                      ? "Add Biography"
                      : "Select Languages",
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
                child: const Text('Back'),
              ),
            const Spacer(),
            if (_currentStep < 3) // Show Next button for all but last step
              Obx(() => Visibility(
                    visible: (controller.uploadImage.value &&
                            _currentStep == 0) ||
                        (controller.uploadVideo.value && _currentStep == 1) ||
                        _currentStep == 2 ||
                        _currentStep == 3,
                    child: TextButton(
                      onPressed: _nextStep,
                      child: const Text('Next'),
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
          controller.isLoading
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
                            : null,
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                        color: Theme.of(context).primaryColor),
                    child: TitleHeading3Widget(
                        text: controller.uploadImage.value
                            ? ""
                            : Strings.selectProfilePicture,
                        color: CustomColor.whiteColor),
                  ),
                )
        ],
      ),
    );
  }

  _buildStep2() {
    return Center(
      child: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                    width: MediaQuery.sizeOf(context).width * .7,
                    height: controller.uploadVideo.value
                        ? MediaQuery.sizeOf(context).height * .1
                        : MediaQuery.sizeOf(context).height * .5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                        color: controller.uploadVideo.value
                            ? Colors.green
                            : Theme.of(context).primaryColor),
                    child: TitleHeading3Widget(
                        text: controller.uploadVideo.value
                            ? Strings.uploaded
                            : Strings.selectProfileVideo,
                        color: CustomColor.whiteColor),
                  ),
                )
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
                    PrimaryButton(title: Strings.update, onPressed: () {
                      controller.talentSetupProcess();
                    })
                  ],
                )),
    );
  }

  _buildStep4() {
    List<String> languages = ['English', 'Spanish', 'French', 'Portuguese'];
    List<String> selectedLanguages = [];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: crossStart,
        children: [
          const TitleHeading4Widget(
              text:
                  'Please select all languages in which you can respond to a request'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8.0,
            children: languages.map((language) {
              bool isSelected = selectedLanguages.contains(language);
              return FilterChip(
                label: Text(
                  language,
                  style: TextStyle(
                    color: isSelected ? Colors.green : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedLanguages.add(language);
                    } else {
                      selectedLanguages.remove(language);
                    }
                    debugPrint(language);
                    debugPrint(selected.toString());
                    debugPrint(isSelected.toString());
                  });
                },
              );
            }).toList(),
          ),

          verticalSpace(Dimensions.marginBetweenInputBox),
          PrimaryButton(title: Strings.update, onPressed: () {
            Get.offAllNamed(Routes.btmScreen);
            // controller.talentSetupProcess();
          })
        ],
      ),
    );
  }
}
