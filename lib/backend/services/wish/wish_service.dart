import 'package:next_wisher/backend/services/wish/stripe_payment_model.dart';

import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/logger.dart';
import '../api_endpoint.dart';
import 'mobile_payment_model.dart';
import 'payment_info_model.dart';


final log = logger(WishService);

mixin WishService {
  ///* Get PaymentInfo api services
  Future<PaymentInfoModel?> paymentInfoProcessApi(String id) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.wishPaymentInfoURL}/$id",
      );
      if (mapResponse != null) {
        PaymentInfoModel result = PaymentInfoModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from PaymentInfo api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* StripePayment api services
  Future<StripePaymentModel?> stripePaymentProcessApi(
      {required Map<String, dynamic> body, required String idType}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.stripePayURL + idType ,
        body,
      );
      if (mapResponse != null) {
        StripePaymentModel result = StripePaymentModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from StripePayment api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* MobilePayment api services
  Future<MobilePaymentModel?> mobilePaymentProcessApi(
      {required Map<String, dynamic> body, required String idType}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.mobilePayURL+ idType ,
        body,
      );
      if (mapResponse != null) {
        MobilePaymentModel result = MobilePaymentModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from MobilePayment api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
