import 'dart:convert';

import 'package:next_wisher/backend/model/common/common_success_model.dart';

import '../../backend/services/profile/profile_service.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import 'profile_controller.dart';

class ProfileSetupController extends GetxController with ProfileService {

  RxList<String> languages = ['English', 'Spanish', 'French', 'Portuguese'].obs;
  RxList<String> selectedLanguages = <String>[].obs;


  final bioController = TextEditingController(text: Get.find<ProfileController>()
      .talentProfileModelModel
      .data
      .userInfo
      .bio);

  @override
  void onInit() {
    // add supported language
    selectedLanguages.value = [...castToList(Get.find<ProfileController>()
        .talentProfileModelModel
        .data
        .userInfo.supportedLanguages)];

    super.onInit();
  }

  castToList(String list){
    // Convert single quotes to double quotes for JSON compatibility
    String value = list.replaceAll("'", '"');

    // Decode the JSON string into a list
    return jsonDecode(value).cast<String>();
  }


  final profileController = Get.find<ProfileController>();


  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _talentSetupModel;
  CommonSuccessModel get talentSetupModel => _talentSetupModel;

  ///* TalentSetup in process
  Future<CommonSuccessModel> talentSetupProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'bio': bioController.text,
      'category_id': profileController.selectedCategory.value.id,
      'sub_category_id': profileController.selectedSubCategory.value.id,
    };
    await talentSetupProcessApi(body: inputBody).then((value) {
      _talentSetupModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _talentSetupModel;
  }

  /// Supported Language

  ///* TalentSetup in process
  Future<CommonSuccessModel> talentSupportedLanguageProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'supported_languages': selectedLanguages,
    };
    await supportedLanguageProcessApi(body: inputBody).then((value) {
      _talentSetupModel = value!;

      Get.offAllNamed(Routes.btmScreen);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _talentSetupModel;
  }

  /// ------------------------------------- >>

  RxString imageFile = "".obs;
  RxString videoFile = "".obs;
  RxBool uploadImage = false.obs;
  RxBool uploadVideo = false.obs;

  late CommonSuccessModel _talentImageSetupModel;
  CommonSuccessModel get talentImageSetupModel => _talentImageSetupModel;

  ///* TalentImageSetup in process
  Future<CommonSuccessModel> talentFileSetupProcess({
    required String endPoint,
    required String filePath,
    required String filedName,
  }) async {
    _isLoading.value = true;
    update();

    await talentFileSetupProcessApi(
            endPoint: endPoint, filePath: filePath, filedName: filedName)
        .then((value) {
      _talentImageSetupModel = value!;

      if(filedName == "image") {
        uploadImage.value = true;
      }else{
        uploadVideo.value = true;
      }
      debugPrint(uploadImage.value.toString());
      debugPrint(uploadVideo.value.toString());
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _talentImageSetupModel;
  }
}
