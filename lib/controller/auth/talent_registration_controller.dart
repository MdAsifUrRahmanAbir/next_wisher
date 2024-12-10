import '../../../routes/routes.dart';
import '../../backend/services/auth/auth_service.dart';
import '../../backend/services/auth/register_info_model.dart';
import '../../backend/services/auth/register_model.dart';
import '../../backend/utils/custom_snackbar.dart';
import '../../utils/basic_screen_imports.dart';

class TalentRegistrationController extends GetxController with AuthService{
  /// text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final linkController = TextEditingController();
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
    if(!firstCountry.value) {
      if( !firstCategory.value){

        if(!firstSubcategory.value) {
          if (passwordController.text == confirmPasswordController.text) {
            if (isChecked.value) {
              if (filePath.isNotEmpty) {
                await registerProcess();
              } else {
                CustomSnackBar.error("Select a video.");
              }
            } else {
              CustomSnackBar.error("Agree with privacy policy.");
            }
          }
          else {
            CustomSnackBar.error("The password confirmation does not match.");
          }
        }else{
          CustomSnackBar.error("Category cannot be empty");
        }

      }else{
        CustomSnackBar.error("Sub category cannot be empty");
      }

    }else{
      CustomSnackBar.error("Country cannot be empty");
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


  @override
  void onInit() {
    signupInfoProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late Rx<Country> selectedCountry;
  RxBool firstCountry = true.obs;
  String filePath = "";

  List<Category> categoryList = [];
  RxBool firstCategory = true.obs;
  late Rx<Category> selectedCategory;

  RxList<Child> subCategoryList = <Child>[].obs;
  RxBool firstSubcategory = true.obs;
  late Rx<Child> selectedSubCategory;

  bool subCategoryFound = false;

  late SignupInfoModel _signupInfoModel;
  SignupInfoModel get signupInfoModel => _signupInfoModel;


  ///* Get SignupInfo in process
  Future<SignupInfoModel> signupInfoProcess() async {
    _isLoading.value = true;
    update();
    await signupInfoProcessApi().then((value) {
      _signupInfoModel = value!;
      selectedCountry = _signupInfoModel.data.country.first.obs;

      for (var e in _signupInfoModel.data.category) {
        if(e.child.isNotEmpty){
          categoryList.add(e);
        }
      }
      selectedCategory = categoryList.first.obs;

      subCategoryList.value = _signupInfoModel.data.category.first.child;
      if(subCategoryList.isNotEmpty){
        subCategoryFound = true;
        selectedSubCategory = subCategoryList.first.obs;
      }
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _signupInfoModel;
  }




  /// ------------------------------------- >>
  final _isRegisterLoading = false.obs;
  bool get isRegisterLoading => _isRegisterLoading.value;


  late RegisterModel _registerModel;
  RegisterModel get registerModel => _registerModel;


  ///* Register in process
  Future<RegisterModel> registerProcess() async {
    _isRegisterLoading.value = true;
    update();
    Map<String, String> inputBody = {
      'role': 'talent',
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': confirmPasswordController.text,
      'country_id': selectedCountry.value.id.toString(),
      'category_id': selectedCategory.value.id.toString(),
      'sub_category_id': selectedSubCategory.value.id.toString(),
      'link': linkController.text,
    };

    await registerProcessWithVideoApi(body: inputBody, filePath: filePath).then((value) {
      _registerModel = value!;
      Get.offAllNamed(Routes.welcomeScreen);
      _isRegisterLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isRegisterLoading.value = false;
    update();
    return _registerModel;
  }



}