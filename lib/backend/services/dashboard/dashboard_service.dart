

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/logger.dart';
import '../api_endpoint.dart';
import 'home_model.dart';


final log = logger(DashboardService);

mixin DashboardService{


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
      log.e(':ladybug::ladybug::ladybug: err from Home api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


}