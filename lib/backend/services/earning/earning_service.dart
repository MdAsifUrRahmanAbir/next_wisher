
import '../../model/common/common_success_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/logger.dart';
import '../api_endpoint.dart';
import 'earning_filter_model.dart';
import 'earning_model.dart';
import 'payout_info_model.dart';

final log = logger(EarningService);

mixin EarningService{

  ///* Get Earning api services
  Future<EarningModel?> earningProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.earningURL,
      );
      if (mapResponse != null) {
        EarningModel result = EarningModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from Earning api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Payment api services
  Future<CommonSuccessModel?> paymentProcessApi(
      {required Map<String, dynamic> body, required String endPoint}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        endPoint,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from Payment api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get PayoutInfo api services
  Future<PayoutInfoModel?> payoutInfoProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.talentPayoutInfoURL,
      );
      if (mapResponse != null) {
        PayoutInfoModel result = PayoutInfoModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from PayoutInfo api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* EarningFilter api services
  Future<EarningFilterModel?> earningFilterProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.earningFilterURL,
        body,
      );
      if (mapResponse != null) {
        EarningFilterModel result = EarningFilterModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from EarningFilter api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }



}