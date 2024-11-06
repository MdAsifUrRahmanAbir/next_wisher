
import 'package:next_wisher/backend/utils/custom_loading_api.dart';

import '../../controller/auth/login_controller.dart';
import '../../utils/assets.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/inputs/password_input_widget.dart';
import '../../widgets/others/rich_text_widget.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';
import 'forgot_password_dialog.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: Strings.login,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal,
          vertical: Dimensions.paddingSizeVertical,
        ),
        child: Form(
          key: controller.formKey,
          child: ListView(
            // crossAxisAlignment: crossStart,
            children: [
              // Image.asset(Assets.appBasicLogo),
              // verticalSpace(Dimensions.marginSizeVertical),
              // TitleHeading3Widget(
              //   text: Strings.login,
              //   color: Theme.of(context).primaryColor,
              // ),
              verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
              TitleHeading5Widget(
                text: Strings.loginTitle,
              ),
              verticalSpace(Dimensions.marginSizeVertical),
              PrimaryTextInputWidget(
                controller: controller.emailController,
                labelText: Strings.email,
                hint: Strings.enterEmail,
              ),
              verticalSpace(Dimensions.marginBetweenInputBox),
              PasswordInputWidget(
                controller: controller.passwordController,
                hint: Strings.enterPassword,
                labelText: Strings.password,
              ),
              _rememberMeWidget(context),
              verticalSpace(Dimensions.marginSizeVertical),
               Obx(() => controller.isLoading ? const CustomLoadingAPI(): PrimaryButton(title: Strings.loginNow, onPressed: controller.login)),
              verticalSpace(Dimensions.marginSizeVertical),
              _richTextWidget()
            ],
          ),
        ),
      ),
    );
  }

  _richTextWidget() {
    return Row(
      mainAxisAlignment: mainCenter,
      children: [
        RichTextWidget(
            textAlign: TextAlign.center,
            preText: Strings.dontHaveAnAccount,
            postText: Strings.signUpNow,
            onPressed: controller.clickOnRichText),
      ],
    );
  }

  _rememberMeWidget(BuildContext context) {
    return Obx(() => Row(
          children: [
            Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: controller.rememberMe.value,
                    onChanged: controller.onChangedInRememberMe)
                .paddingZero,
            TitleHeading5Widget(
              text: Strings.rememberMe,
              opacity: .8,
              fontWeight: FontWeight.bold,
            ),
            const Spacer(),
            SecondaryButton(
                onTap: () {
                  ForgotPasswordDialog.show();
                },
                text: Strings.forgotPassword)
          ],
        ));
  }
}
