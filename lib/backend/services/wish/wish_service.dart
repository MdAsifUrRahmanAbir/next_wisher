import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/logger.dart';
import '../api_endpoint.dart';
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

}
