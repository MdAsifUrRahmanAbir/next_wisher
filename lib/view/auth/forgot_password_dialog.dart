import 'package:next_wisher/backend/utils/custom_loading_api.dart';

import '../../controller/auth/login_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/buttons/primary_button.dart';

class ForgotPasswordDialog {
  static show() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        title: TitleHeading3Widget(text: "Forgot password?"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              // Text(Strings.forgotPasswordSubTitle),
              // verticalSpace(
              //     Dimensions.heightSize * 1.8), // Dimensions.marginSizeVertical
              PrimaryTextInputWidget(
                controller: Get.find<LoginController>().resetEmailController,
                labelText: Strings.email,
                hint: "",
              ),
            ],
          ),
        ),
        actions: <Widget>[
           PrimaryButton(
                  title: "Send",
                  onPressed: Get.find<LoginController>().forgotPasswordSendLink,
                )
        ],
      ),
    );
  }
}
