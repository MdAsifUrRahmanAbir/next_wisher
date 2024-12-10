import 'package:flutter/gestures.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/widgets/inputs/password_input_widget.dart';

import '../../backend/services/auth/register_info_model.dart';
import '../../controller/auth/talent_registration_controller.dart';
import '../../language/language_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../widgets/others/custom_video_picker_widget.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';
import '../dynamic_webview_screen.dart';

class TalentRegistrationScreen extends StatelessWidget {
  TalentRegistrationScreen({super.key});

  final controller = Get.put(TalentRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: Strings.createTalentAccount,
      ),
      body: Obx(() =>
          controller.isLoading ? const CustomLoadingAPI() : _body(context)),
    );
  }

  _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.paddingSizeHorizontal,
          right: Dimensions.paddingSizeHorizontal,
          bottom: Dimensions.paddingSizeVertical,
        ),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              verticalSpace(Dimensions.marginSizeVertical),
              PrimaryTextInputWidget(
                controller: controller.nameController,
                labelText: Strings.name,
                hint: "",
                error: "Username cannot be empty",
                // hint: Strings.enterName,
              ),
              verticalSpace(Dimensions.marginBetweenInputBox),
              PrimaryTextInputWidget(
                controller: controller.emailController,
                // hint: Strings.enterEmail,
                hint: "",
                error: "Email cannot be empty",
                labelText: Strings.email,
              ),
              verticalSpace(Dimensions.marginBetweenInputBox),
              CustomDropDown<Country>(
                items: controller.signupInfoModel.data.country,
                onChanged: (value) {
                  controller.firstCountry.value = false;
                  controller.selectedCountry.value = value!;
                },
                hint: controller.firstCountry.value
                    ? ""
                    : controller.selectedCountry.value.name,
                title: Strings.selectCountry,
              ),
              verticalSpace(Dimensions.marginBetweenInputBox),
              CustomDropDown<Category>(
                items: controller.categoryList,
                onChanged: (value) {
                  controller.firstCategory.value = false;
                  controller.selectedCategory.value = value!;
                  controller.subCategoryList.value =
                      controller.selectedCategory.value.child;
                  debugPrint(controller.subCategoryList.isNotEmpty.toString());
                  if (controller.subCategoryList.isNotEmpty) {
                    controller.selectedSubCategory.value =
                        controller.selectedCategory.value.child.first;
                  }
                },
                hint: controller.firstCategory.value
                    ? ""
                    : controller.selectedCategory.value.name,
                title: Strings.selectCategory,
              ),
              verticalSpace(Dimensions.marginBetweenInputBox),
              Obx(() => controller.subCategoryList.isEmpty
                  ? const SizedBox.shrink()
                  : CustomDropDown<Child>(
                      items: controller.subCategoryList,
                      onChanged: (value) {
                        controller.firstSubcategory.value = false;
                        controller.selectedSubCategory.value = value!;
                      },
                      hint: controller.firstSubcategory.value
                          ? ""
                          : controller.selectedSubCategory.value.name,
                      title: Strings.selectSubcategory,
                    )),
              verticalSpace(Dimensions.marginBetweenInputBox),
              PrimaryTextInputWidget(
                controller: controller.linkController,
                // hint: Strings.enterSocialLink,
                hint: "",
                error: "Link cannot be empty",
                labelText: "https://",
              ),
              TitleHeading5Widget(
                  text: Strings.enterSocialLinkHint,
                  color: CustomColor.redColor),
              verticalSpace(Dimensions.marginBetweenInputBox),
              CustomVideoPicketWidget(
                onPicked: (value) {
                  controller.filePath = value;
                },
              ),
              verticalSpace(Dimensions.marginBetweenInputBox),
              PasswordInputWidget(
                controller: controller.passwordController,
                hint: "",
                error: "The password field is required.",
                labelText: Strings.password,
              ),
              verticalSpace(Dimensions.marginBetweenInputBox),
              PasswordInputWidget(
                controller: controller.confirmPasswordController,
                hint: "",
                error: "The password field is required.",
                labelText: Strings.confirmPassword,
              ),
              _checkBoxWidget(context),
              verticalSpace(Dimensions.marginSizeVertical),
              Obx(() => controller.isRegisterLoading
                  ? const CustomLoadingAPI()
                  : PrimaryButton(
                      title: "Go", onPressed: controller.register)),
              verticalSpace(Dimensions.marginSizeVertical),
            ],
          ),
        ),
      ),
    );
  }

  _checkBoxWidget(BuildContext context) {
    return Obx(() => Row(
          crossAxisAlignment: crossStart,
          children: [
            Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: controller.isChecked.value,
                    onChanged: controller.onChangedInRememberMe)
                .paddingZero,
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: languageSettingController
                          .getTranslation('I certify that I am at least 18 years old. I have read and agree to the'),
                      style: TextStyle(fontSize: 14),
                      children: [
                        TextSpan(
                          text: ' ', // Add spaces here for the gap
                        ),
                        TextSpan(
                          text: languageSettingController
                              .getTranslation('Terms of service'),
                          style: TextStyle(color: Colors.orange, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              debugPrint('Terms of Service clicked');
                              Get.to(WebViewScreen(
                                  link:
                                  'https://nextwisher.com/pages/terms-of-service',
                                  appTitle: '',
                                  homeIconShow: false));
                            },
                        ),
                        TextSpan(
                          text: ' ', // Add spaces here for the gap
                        ),
                        TextSpan(
                          text: languageSettingController.getTranslation('and'),
                          style: TextStyle(fontSize: 14),
                        ),
                        TextSpan(
                          text: ' ', // Add spaces here for the gap
                        ),
                        TextSpan(
                          text: languageSettingController
                              .getTranslation('Privacy Policy'),
                          style: TextStyle(color: Colors.orange, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              debugPrint('Privacy Policy clicked');
                              Get.to(WebViewScreen(
                                link: 'https://nextwisher.com/pages/privacy-policy',
                                appTitle: '',
                                homeIconShow: false,
                              ));
                            },
                        ),
                        TextSpan(
                          text: '.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}
