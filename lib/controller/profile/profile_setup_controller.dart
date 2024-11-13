import 'package:next_wisher/backend/local_storage/local_storage.dart';
import 'package:next_wisher/backend/model/common/common_success_model.dart';

import '../../backend/services/profile/profile_service.dart';
import '../../utils/basic_screen_imports.dart';

class ProfileSetupController extends GetxController with ProfileService {
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
      'key': 'value',
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

  /// ------------------------------------- >>

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
