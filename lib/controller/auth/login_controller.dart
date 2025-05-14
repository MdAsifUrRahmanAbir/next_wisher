import 'package:firebase_messaging/firebase_messaging.dart';
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

  RxString deviceToken = "".obs;

  @override
  void onInit() {
    _getDeviceToken();
    super.onInit();
  }

  Future<void> _getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
        deviceToken.value = token!;
      debugPrint("Device Token: ${deviceToken.value}");
    } catch (e) {
      debugPrint("Error getting device token: $e");
    }
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      await loginProcess(true);
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
  Future<LoginModel> loginProcess(bool isVerified) async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'email': emailController.text,
      'password': passwordController.text,
      'fcm_token': deviceToken.value
    };
    await loginProcessApi(body: inputBody).then((value) {
      _loginModel = value!;

      debugPrint(_loginModel.data.userInfo.emailVerified.isNotEmpty.toString());
      LocalStorage.saveToken(token: _loginModel.data.token);
      if(_loginModel.data.userInfo.emailVerified.isNotEmpty){
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
        if(isVerified) {
          Get.toNamed(Routes.emailVerificationScreen);
        }
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

  final _isResendEmailLoading = false.obs;
  bool get isResendEmailLoading => _isResendEmailLoading.value;


  late CommonSuccessModel _resendEmailModel;
  CommonSuccessModel get resendEmailModel => _resendEmailModel;


  ///* ForgotPassword in process
  Future<CommonSuccessModel> resendEmailProcess() async {
    _isResendEmailLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {};

    await resendEmailApi(body: inputBody).then((value) {
      _resendEmailModel = value!;

      _isResendEmailLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isResendEmailLoading.value = false;
    update();
    return _resendEmailModel;
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
