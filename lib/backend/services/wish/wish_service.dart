import 'package:next_wisher/backend/services/wish/stripe_payment_model.dart';

import '../../model/common/common_success_model.dart';
import '../../utils/api_method.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/logger.dart';
import '../api_endpoint.dart';
import 'mail_count_model.dart';
import 'mail_index_model.dart';
import 'mobile_payment_model.dart';
import 'payment_info_model.dart';
import 'ratting_check_model.dart';


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


  ///* Get MailIndex api services
  Future<MailIndexModel?> mailIndexProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.mailIndexURL,
      );
      if (mapResponse != null) {
        MailIndexModel result = MailIndexModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from MailIndex api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get MailCount api services
  Future<MailCountModel?> mailCountProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.mailCountURL,
      );
      if (mapResponse != null) {
        MailCountModel result = MailCountModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from MailCount api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get MailSeen api services
  Future<CommonSuccessModel?> mailSeenProcessApi(String id) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.mailSeenURL}/$id",
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from MailSeen api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* MailReply api services
  Future<CommonSuccessModel?> mailReplyProcessApi(
      {required Map<String, String> body, required String filePath}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipart(
        ApiEndpoint.mailReplyURL,
        body,
        filePath,
        "attachment"
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from MailReply api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* RatingSubmit api services
  Future<CommonSuccessModel?> ratingSubmitProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.ratingSubmitURL,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from RatingSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get DownloadFile api services
  Future<CommonSuccessModel?> downloadFileProcessApi(String suffix) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.downloadURL}/$suffix",
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from DownloadFile api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get RatingCheckModel api services
  Future<RatingCheckModel?> ratingCheckModelProcessApi({required String userId, required String earningId}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.rattingCheckURL}/$userId/$earningId",
      );
      if (mapResponse != null) {
        RatingCheckModel result = RatingCheckModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from RatingCheckModel api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


}
