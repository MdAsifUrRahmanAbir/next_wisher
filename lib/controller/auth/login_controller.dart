import 'package:next_wisher/backend/local_storage/local_storage.dart';
import 'package:next_wisher/backend/model/common/common_success_model.dart';
import 'package:next_wisher/backend/utils/custom_snackbar.dart';

import '../../../routes/routes.dart';
import '../../backend/services/auth/auth_service.dart';
import '../../backend/services/auth/login_model.dart';
import '../../utils/basic_screen_imports.dart';

class LoginController extends GetxController with AuthService {
  /// text controllers
  final resetEmailController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// formKeys
  final formKey = GlobalKey<FormState>();
  RxBool rememberMe = true.obs;

  @override
  void dispose() {
    resetEmailController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(String deviceToken) async {
    if (formKey.currentState!.validate()) {
      await loginProcess(deviceToken);
    }
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
    Get.close(1);
    forgotPasswordProcess();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late LoginModel _loginModel;
  LoginModel get loginModel => _loginModel;

  ///* Login in process
  Future<LoginModel> loginProcess(String deviceToken) async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'email': emailController.text,
      'password': passwordController.text,
      'fcm_token': deviceToken
    };
    await loginProcessApi(body: inputBody).then((value) {
      _loginModel = value!;
      if(_loginModel.data.userInfo.status == 1){
        LocalStorage.saveToken(token: _loginModel.data.token);
        LocalStorage.saveId(id: _loginModel.data.userInfo.id.toString());
        LocalStorage.isLoginSuccess(isLoggedIn: rememberMe.value);
        LocalStorage.isUserSave(
            isUser: _loginModel.data.userInfo.role == "talent" ? false : true);
        debugPrint(" - >> Login Done");
        debugPrint(" - >> Token ${LocalStorage.getToken()}");
        debugPrint(" - >> Remembered ${LocalStorage.isLoggedIn()}");
        debugPrint(" - >> Role is user? ${LocalStorage.isUser()}");
        Get.offAllNamed(Routes.btmScreen);
      }else{
        CustomSnackBar.error("You need to verify email first.");
      }
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _loginModel;
  }






  /// ------------------------------------- >>
  final _isForgotLoading = false.obs;
  bool get isForgotLoading => _isForgotLoading.value;


  late CommonSuccessModel _forgotPasswordModel;
  CommonSuccessModel get forgotPasswordModel => _forgotPasswordModel;


  ///* ForgotPassword in process
  Future<CommonSuccessModel> forgotPasswordProcess() async {
    _isForgotLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'email': resetEmailController.text,
    };
    await forgotPasswordProcessApi(body: inputBody).then((value) {
      _forgotPasswordModel = value!;
      _isForgotLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isForgotLoading.value = false;
    update();
    return _forgotPasswordModel;
  }


}
