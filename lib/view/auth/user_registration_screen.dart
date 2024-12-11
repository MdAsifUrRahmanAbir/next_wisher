import 'package:flutter/gestures.dart';
import 'package:next_wisher/widgets/inputs/password_input_widget.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../controller/auth/user_registration_controller.dart';
import '../../language/language_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../dynamic_webview_screen.dart';

class UserRegistrationScreen extends StatelessWidget {
  UserRegistrationScreen({super.key});

  final controller = Get.put(UserRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: "Create Your Account",
      ),
      body: _body(context),
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
              ),

              verticalSpace(Dimensions.marginBetweenInputBox),
              PrimaryTextInputWidget(
                controller: controller.emailController,
                hint: "",
                error: "Email cannot be empty",
                labelText: Strings.email,
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
              Obx(() => controller.isLoading ? CustomLoadingAPI(): PrimaryButton(title: "Register", onPressed: controller.register)),
              verticalSpace(Dimensions.marginSizeVertical),

              // Row(
              //   mainAxisAlignment: mainCenter,
              //   children: [
              //     RichTextWidget(
              //       textAlign: TextAlign.center,
              //       preText: Strings.alreadyHaveAnAccount, postText: Strings.loginNow, onPressed: controller.clickOnRichText),
              //   ],
              // )

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
                      .getTranslation('By signing up, you agree to our'),
                  style: TextStyle(fontSize: 14, color: Get.isDarkMode ? Colors.white : Colors.black),
                  children: [
                    TextSpan(
                      text: ' ', // Add spaces here for the gap
                    ),
                    TextSpan(
                      text: languageSettingController
                          .getTranslation('Terms of service'),
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
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
                      style: TextStyle(fontSize: 14, color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    TextSpan(
                      text: ' ', // Add spaces here for the gap
                    ),
                    TextSpan(
                      text: languageSettingController
                          .getTranslation('Privacy Policy'),
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
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
                      style: TextStyle(fontSize: 14, color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ));
  }
}
