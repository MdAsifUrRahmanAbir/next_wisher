
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';

import '../../controller/auth/login_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/inputs/password_input_widget.dart';
import '../../widgets/others/rich_text_widget.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';
import 'forgot_password_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());
  String? _deviceToken;

  @override
  void initState() {
    super.initState();
    _getDeviceToken();
  }
  Future<void> _getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      setState(() {
        _deviceToken = token;
      });
      debugPrint("Device Token: $_deviceToken");
    } catch (e) {
      debugPrint("Error getting device token: $e");
    }
  }

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
              verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
              TitleHeading5Widget(
                text: Strings.loginTitle,
              ),
              verticalSpace(Dimensions.marginSizeVertical),
              PrimaryTextInputWidget(
                controller: controller.emailController,
                labelText: Strings.email,
                hint: "",
              ),
              verticalSpace(Dimensions.marginBetweenInputBox),
              PasswordInputWidget(
                controller: controller.passwordController,
                hint: "",
                labelText: Strings.password,
              ),
              _rememberMeWidget(context),
              verticalSpace(Dimensions.marginSizeVertical),
               Obx(() => controller.isLoading ? const CustomLoadingAPI(): PrimaryButton(title: Strings.loginNow, onPressed: (){
                 controller.login(_deviceToken ?? "");
               })),
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
