

import 'package:next_wisher/backend/model/common/common_success_model.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/services/earning/earning_service.dart';

class PaymentController extends GetxController with EarningService{

  /// paypal
  RxString selectedMethod = 'PayPal'.obs; // Default selected method
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();


  /// mobile
  RxString selectedNetwork = 'MTN'.obs; // Default network selection
  final TextEditingController payoutAmountController = TextEditingController();

  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController swiftController = TextEditingController();

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;



  /// ------------------------------------- >>
  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;


  late CommonSuccessModel _paymentModel;
  CommonSuccessModel get paymentModel => _paymentModel;


  ///* Payment in process
  Future<CommonSuccessModel> paymentProcess({
    required String endpoint,
    required Map<String, dynamic> inputBody,
    required VoidCallback onConfirm
}) async {
    _isSubmitLoading.value = true;
    update();
    // Map<String, dynamic> inputBody = {
    //   'key': 'value',
    // };
    await paymentProcessApi(body: inputBody, endPoint: endpoint).then((value) {
      _paymentModel = value!;
      onConfirm();
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _paymentModel;
  }


}