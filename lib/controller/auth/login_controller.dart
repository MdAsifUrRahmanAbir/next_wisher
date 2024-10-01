
import '../../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';

class LoginController extends GetxController{
  /// text controllers
  final resetEmailController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// formKeys
  final formKey = GlobalKey<FormState>();
  RxBool rememberMe = false.obs;

  @override
  void dispose() {
    resetEmailController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async{
    Get.offAllNamed(Routes.btmScreen);
    // if(formKey.currentState!.validate()){
    //   // await loginProcess();
    // }
  }

  void onChangedInRememberMe(bool? value) {
    rememberMe.value = value!;
    debugPrint("${rememberMe.value} - $value");
    update();
  }

  void clickOnRichText() {
    Get.toNamed(Routes.userTypeScreen);
  }

  void forgotPasswordSendLink() {
    // forgotPasswordProcess();
  }
}