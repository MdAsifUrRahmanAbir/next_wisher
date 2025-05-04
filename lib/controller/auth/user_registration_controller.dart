import '../../../routes/routes.dart';
import '../../backend/services/auth/auth_service.dart';
import '../../backend/services/auth/register_model.dart';
import '../../backend/utils/custom_snackbar.dart';
import '../../utils/basic_screen_imports.dart';

class UserRegistrationController extends GetxController with AuthService{
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
    if (formKey.currentState!.validate()) {
      if(passwordController.text == confirmPasswordController.text) {
        if(isChecked.value) {
          await registerProcess();
        } else{
        CustomSnackBar.error("Agree with privacy policy");
      }
      }else{
        CustomSnackBar.error("The password confirmation does not match");
      }
    }
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



  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  late RegisterModel _registerModel;
  RegisterModel get registerModel => _registerModel;


  ///* Register in process
  Future<RegisterModel> registerProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'role': 'user',
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': confirmPasswordController.text,
    };
    await registerProcessApi(body: inputBody).then((value) {
      _registerModel = value!;
      Get.offAllNamed(Routes.welcomeScreen);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _registerModel;
  }



}
