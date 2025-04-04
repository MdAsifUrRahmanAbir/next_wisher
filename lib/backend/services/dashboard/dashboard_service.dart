import 'package:next_wisher/backend/local_storage/local_storage.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/logger.dart';
import '../api_endpoint.dart';
import 'category_model.dart';
import 'guid_data_model.dart';
import 'home_model.dart';
import 'talents_model.dart';

final log = logger(DashboardService);

mixin DashboardService {
  ///* Get Home api services
  Future<HomeModel?> homeProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.homeURL,
      );
      if (mapResponse != null) {
        HomeModel result = HomeModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from Home api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get Talents api services
  Future<TalentsModel?> talentsProcessApi(String id) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        "${ApiEndpoint.talentsDetailsURL}/$id",
      );
      if (mapResponse != null) {
        TalentsModel result = TalentsModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from Talents api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get GuidData api services
  Future<GuidDataModel?> guidDataProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        LocalStorage.isUser()
            ? ApiEndpoint.userDashboardURL
            : ApiEndpoint.talentDashboardURL,
      );
      if (mapResponse != null) {
        GuidDataModel result = GuidDataModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from GuidData api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get CategoryModel api services
  Future<CategoryModel?> categoryModelProcessApi({required String tag}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.categoryURL}/$tag",
      );
      if (mapResponse != null) {
        CategoryModel result = CategoryModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from CategoryModel api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

}
