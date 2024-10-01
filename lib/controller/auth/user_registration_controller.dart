import '../../../routes/routes.dart';
import '../../backend/utils/custom_snackbar.dart';
import '../../utils/basic_screen_imports.dart';

class UserRegistrationController extends GetxController {
  /// text controllers
  final nameController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// formKeys
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void register() async {
    Get.offAllNamed(Routes.btmScreen);
    // if (formKey.currentState!.validate()) {
    //   if(passwordController.text == confirmPasswordController.text) {
    //     // await registrationProcess();
    //   }else{
    //     CustomSnackBar.error("The password confirmation does not match.");
    //   }
    // }
  }

  void clickOnRichText() {
    Get.offAllNamed(Routes.loginScreen);
  }


  RxBool isChecked = false.obs;

  void onChangedInRememberMe(bool? value) {
    isChecked.value = value!;
    debugPrint("${isChecked.value} - $value");
    update();
  }
}
