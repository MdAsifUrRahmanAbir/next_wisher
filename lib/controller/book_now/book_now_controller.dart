import 'package:next_wisher/backend/utils/custom_snackbar.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/services/wish/mobile_payment_model.dart';
import '../../backend/services/wish/payment_info_model.dart';
import '../../backend/services/wish/stripe_payment_model.dart';
import '../../backend/services/wish/wish_service.dart';
import '../../routes/routes.dart';
import '../../utils/strings.dart';
import '../../view/book_now/pay_screen.dart';
import '../../view/dynamic_webview_screen.dart';

class BookNowController extends GetxController with WishService {
  final formKey = GlobalKey<FormState>();

  RxString paymentType = 'credit-card'.obs;
  RxString selectedOption = "myself".obs;
  RxString selectedGender = "".obs;

  final tipsController = TextEditingController(text: "10");
  RxDouble tipsValue = 10.0.obs;


  final nameController = TextEditingController();
  final fromController = TextEditingController();
  final forController = TextEditingController();
  final occasionController = TextEditingController();
  final instructionsController = TextEditingController();

  // @override
  // void onInit() {
  //   // paymentInfoProcess();
  //   super.onInit();
  // }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late Rx<Ocasion> selectedOcasion;
  late Rx<PawapayCountry> selectedPawapayCountry;
  RxBool selectedPawapayCountryDone = false.obs;

  late PaymentInfoModel _paymentInfoModel;
  PaymentInfoModel get paymentInfoModel => _paymentInfoModel;

  ///* Get PaymentInfo in process
  Future<PaymentInfoModel> paymentInfoProcess(int id) async {
    _isLoading.value = true;
    update();
    await paymentInfoProcessApi(id.toString()).then((value) {
      _paymentInfoModel = value!;
      selectedOcasion = _paymentInfoModel.data.ocasions.first.obs;
      selectedPawapayCountry = _paymentInfoModel.data.pawapayCountries.first.obs;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _paymentInfoModel;
  }

  void pay() {
    if (formKey.currentState!.validate()) {
      Get.to(PayScreen(isBook: true));
    }
  }

  void payment(String id, String type) {
    debugPrint(paymentType.value);
    if (paymentType.value == "credit-card") {
      stripePaymentProcess(id, type);
    } else {
      mobilePaymentProcess(id, type);
    }
  }

  /// ------------------------------------- >>
  final _isPaymentLoading = false.obs;
  bool get isPaymentLoading => _isPaymentLoading.value;

  late StripePaymentModel _stripePaymentModel;
  StripePaymentModel get stripePaymentModel => _stripePaymentModel;

  ///* StripePayment in process
  Future<StripePaymentModel> stripePaymentProcess(
      String id, String type) async {
    _isPaymentLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'talent_id': id,
      'type': type,
      'amount': type == "tips" ? tipsController.text : paymentInfoModel.data.earning.amount,
    };
    if (type == "wish") {
      inputBody.addAll(
        {
          'dedicated_to': selectedOption.value,
          'occasion_id': selectedOcasion.value.id,
          'name': nameController.text,
          'from': fromController.text,
          'to': forController.text,
          'gender': selectedGender.value,
          'instruction': instructionsController.text,
        }
      );
    }

    await stripePaymentProcessApi(body: inputBody, idType: '/$id/$type')
        .then((value) {
      _stripePaymentModel = value!;
      Get.to(WebViewScreen(
        appTitle: "",
        link: _stripePaymentModel.data.redirectUrl,
        onFinished: (url) {
          if(url.toString() == _stripePaymentModel.data.redirectionResponse.successUrl){
            Get.offAllNamed(Routes.btmScreen);
            CustomSnackBar.success(Strings.successfullyPaymentDone);
          }
        },
      ));
      _isPaymentLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isPaymentLoading.value = false;
    update();
    return _stripePaymentModel;
  }


  late MobilePaymentModel _mobilePaymentModel;
  MobilePaymentModel get mobilePaymentModel => _mobilePaymentModel;


  ///* MobilePayment in process
  Future<MobilePaymentModel> mobilePaymentProcess(String id, String type) async {
    _isPaymentLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'talent_id': id,
      'type': type,
      'amount': type == "tips" ? tipsController.text : paymentInfoModel.data.earning.amount,
      'payment-type': "mobile-payment",
      'currency': "eur",
      'correspondent': selectedPawapayCountry.value.sim.first.correspondent,
      'phone_number': selectedPawapayCountry.value.sim.first.prefix,
      'country': selectedPawapayCountry.value.sim.first.country,
    };
    if (type == "wish") {
      inputBody.addAll(
          {
            'dedicated_to': selectedOption.value,
            'occasion_id': selectedOcasion.value.id,
            'name': nameController.text,
            'from': fromController.text,
            'to': forController.text,
            'gender': selectedGender.value,
            'instruction': instructionsController.text,
          }
      );
    }

    await mobilePaymentProcessApi(body: inputBody,  idType: '/$id/$type').then((value) {
      _mobilePaymentModel = value!;

      Get.to(WebViewScreen(
        appTitle: "",
        link: _mobilePaymentModel.data.redirectUrl,
        onFinished: (url) {
          if(url.toString().contains("/success")){
            Get.offAllNamed(Routes.btmScreen);
            CustomSnackBar.success(Strings.successfullyPaymentDone);
          }
        },
      ));

      _isPaymentLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isPaymentLoading.value = false;
    update();
    return _mobilePaymentModel;
  }


}
