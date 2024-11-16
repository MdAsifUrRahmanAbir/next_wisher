
import 'package:next_wisher/backend/local_storage/local_storage.dart';
import 'package:next_wisher/backend/model/common/common_success_model.dart';

import '../../backend/services/profile/profile_service.dart';
import '../../backend/services/profile/talent_profile_model.dart';
import '../../backend/services/profile/user_profile_model.dart';
import '../../utils/basic_screen_imports.dart';

class ProfileController extends GetxController with ProfileService{
  final updateFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();


  final changeFormKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    LocalStorage.isUser() ? userProfileProcess() : talentProfileModelProcess();
    super.onInit();
  }

  void updateProfile() {
    if(updateFormKey.currentState!.validate()){
      updateAccountProcess();
    }
  }

  void changePassword() {
    if(changeFormKey.currentState!.validate()){
      changePasswordProcess();
    }
  }



  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  late UserProfileModel _userProfileModel;
  UserProfileModel get userProfileModel => _userProfileModel;


  ///* Get UserProfile in process
  Future<UserProfileModel> userProfileProcess() async {
    _isLoading.value = true;
    update();
    await userProfileProcessApi().then((value) {
      _userProfileModel = value!;
      nameController.text = _userProfileModel.data.userInfo.name;
      emailController.text = _userProfileModel.data.userInfo.email;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _userProfileModel;
  }



  /// ------------------------------------- >>
  List<Category> categoryList = [];
  late Rx<Category> selectedCategory;

  RxList<Child> subCategoryList = <Child>[].obs;
  late Rx<Child> selectedSubCategory;

  bool subCategoryFound = false;

  late TalentProfileModel _talentProfileModelModel;
  TalentProfileModel get talentProfileModelModel => _talentProfileModelModel;


  ///* Get TalentProfileModel in process
  Future<TalentProfileModel> talentProfileModelProcess() async {
    _isLoading.value = true;
    update();
    await talentProfileModelProcessApi().then((value) {
      _talentProfileModelModel = value!;
      nameController.text = _talentProfileModelModel.data.userInfo.name;
      emailController.text = _talentProfileModelModel.data.userInfo.email;

      bool found = false;

      for (var e in _talentProfileModelModel.data.category) {
        if(e.child.isNotEmpty){
          categoryList.add(e);
          if(e.id == _talentProfileModelModel.data.userInfo.categoryId){
            selectedCategory = e.obs;
            subCategoryList.value = e.child;
            found = true;
          }
        }
      }

      if(!found) {
        selectedCategory = categoryList.first.obs;
      }

      // subCategoryList.value = _talentProfileModelModel.data.category.first.child;

      if(subCategoryList.isNotEmpty){
        subCategoryFound = true;
        selectedSubCategory = subCategoryList.first.obs;
        for (var e in subCategoryList) {
          if(_talentProfileModelModel.data.userInfo.subCategoryId == e.id) {
            selectedSubCategory = subCategoryList.first.obs;
          }
        }
      }

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _talentProfileModelModel;
  }



  /// ------------------------------------- >>
  final _isChangeLoading = false.obs;
  bool get isChangeLoading => _isChangeLoading.value;


  late CommonSuccessModel _changePasswordModel;
  CommonSuccessModel get changePasswordModel => _changePasswordModel;


  ///* ChangePassword in process
  Future<CommonSuccessModel> changePasswordProcess() async {
    _isChangeLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'current_password': currentPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text,
    };
    await changePasswordProcessApi(body: inputBody).then((value) {
      _changePasswordModel = value!;
      _isChangeLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isChangeLoading.value = false;
    update();
    return _changePasswordModel;
  }


  /// ------------------------------------- >>
  final _isDeleteLoading = false.obs;
  bool get isDeleteLoading => _isDeleteLoading.value;


  late CommonSuccessModel _deleteAccountModel;
  CommonSuccessModel get deleteAccountModel => _deleteAccountModel;


  ///* Get DeleteAccount in process
  Future<CommonSuccessModel> deleteAccountProcess() async {
    _isDeleteLoading.value = true;
    update();
    await deleteAccountProcessApi().then((value) {
      _deleteAccountModel = value!;
      _isDeleteLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isDeleteLoading.value = false;
    update();
    return _deleteAccountModel;
  }




  /// ------------------------------------- >>
  final _isUpdateLoading = false.obs;
  bool get isUpdateLoading => _isUpdateLoading.value;


  late CommonSuccessModel _updateAccountModel;
  CommonSuccessModel get updateAccountModel => _updateAccountModel;


  ///* UpdateAccount in process
  Future<CommonSuccessModel> updateAccountProcess() async {
    _isUpdateLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'name': nameController.text,
    };
    await updateAccountProcessApi(body: inputBody).then((value) {
      _updateAccountModel = value!;
      _isUpdateLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isUpdateLoading.value = false;
    update();
    return _updateAccountModel;
  }


}
