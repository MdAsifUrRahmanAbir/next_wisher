import '../../controller/profile/change_password_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/inputs/password_input_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final controller = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimaryAppBar(
          title: Strings.changePassword,
        ),
        body: SafeArea(
            child: Form(
          key: controller.formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeHorizontal,
              vertical: Dimensions.paddingSizeVertical,
            ),
            children: [
              PasswordInputWidget(
                controller: controller.oldPassword,
                labelText: Strings.oldPassword,
                hint: Strings.enterPassword,
              ),
              verticalSpace(Dimensions.marginBetweenInputBox),
              PasswordInputWidget(
                controller: controller.newPassword,
                hint: Strings.enterPassword,
                labelText: Strings.newPassword,
              ),
              verticalSpace(Dimensions.marginBetweenInputBox),
              PasswordInputWidget(
                controller: controller.confirmPassword,
                hint: Strings.enterPassword,
                labelText: Strings.confirmPassword,
              ),
              verticalSpace(Dimensions.marginSizeVertical), PrimaryButton(
                      title: Strings.confirm,
                      onPressed: controller.changePassword),
            ],
          ),
        )));
  }
}
