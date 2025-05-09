import 'package:next_wisher/backend/services/profile/talent_profile_model.dart';

import '../../local_storage/local_storage.dart';
import '../../model/common/common_success_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/logger.dart';
import '../api_endpoint.dart';
import 'user_profile_model.dart';

final log = logger(ProfileService);

mixin ProfileService {
  ///* Get UserProfile api services
  Future<UserProfileModel?> userProfileProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.userProfileURL,
      );
      if (mapResponse != null) {
        UserProfileModel result = UserProfileModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from UserProfile api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get TalentProfileModel api services
  Future<TalentProfileModel?> talentProfileModelProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.talentProfileURL,
      );
      if (mapResponse != null) {
        TalentProfileModel result = TalentProfileModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from TalentProfileModel api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* ChangePassword api services
  Future<CommonSuccessModel?> changePasswordProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        LocalStorage.isUser()
            ? ApiEndpoint.userChangePasswordURL
            : ApiEndpoint.talentChangePasswordURL,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success("Password changed successfully");
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from ChangePassword api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get DeleteAccount api services
  Future<CommonSuccessModel?> deleteAccountProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).delete(
        ApiEndpoint.userProfileDeleteURL,

      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from DeleteAccount api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* UpdateAccount api services
  Future<CommonSuccessModel?> updateAccountProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        LocalStorage.isUser()
            ? ApiEndpoint.userProfileUpdateURL
            : ApiEndpoint.talentProfileUpdateURL,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success("Profile successfully updated");
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from UpdateAccount api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* TalentSetup api services
  Future<CommonSuccessModel?> talentSetupProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.talentSetupURL,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from TalentSetup api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* TalentSetup api services
  Future<CommonSuccessModel?> supportedLanguageProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.languageSupportURL,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from TalentSetup api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* TalentImageSetup api services
  Future<CommonSuccessModel?> talentFileSetupProcessApi({
    required String endPoint,
    required String filePath,
    required String filedName,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .multipart(endPoint, {}, filePath, filedName);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from TalentImageSetup api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
