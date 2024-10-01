import 'package:next_wisher/widgets/inputs/password_input_widget.dart';

import '../../controller/auth/user_registration_controller.dart';
import '../../utils/assets.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

class UserRegistrationScreen extends StatelessWidget {
  UserRegistrationScreen({super.key});

  final controller = Get.put(UserRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
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
              Image.asset(Assets.appBasicLogo),
              verticalSpace(Dimensions.marginSizeVertical),
              TitleHeading3Widget(
                text: Strings.createUserAccount,
                color: Theme.of(context).primaryColor,
              ),
              verticalSpace(Dimensions.marginSizeVertical),
              PrimaryTextInputWidget(
                controller: controller.nameController,
                labelText: Strings.name,
                hint: Strings.enterName,
              ),
      
              verticalSpace(Dimensions.marginBetweenInputBox),
              PrimaryTextInputWidget(
                controller: controller.emailController,
                hint: Strings.enterEmail,
                labelText: Strings.email,
              ),
      
              verticalSpace(Dimensions.marginBetweenInputBox),
              PasswordInputWidget(
                controller: controller.passwordController,
                hint: Strings.enterPassword,
                labelText: Strings.password,
              ),

              verticalSpace(Dimensions.marginBetweenInputBox),
              PasswordInputWidget(
                controller: controller.confirmPasswordController,
                hint: Strings.enterPassword,
                labelText: Strings.confirmPassword,
              ),

              _checkBoxWidget(context),
      
              verticalSpace(Dimensions.marginSizeVertical),
              PrimaryButton(title: Strings.signUp, onPressed: controller.register),
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
          child: TitleHeading5Widget(
            padding: const EdgeInsets.only(
                top: 10
            ),
            text: Strings.userRichText,
            opacity: .8,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ));
  }
}
