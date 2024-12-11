import 'package:next_wisher/backend/utils/custom_snackbar.dart';
import 'package:next_wisher/controller/bottom_nav/bottom_nav_controller.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/services/wish/mobile_payment_model.dart';
import '../../backend/services/wish/payment_info_model.dart';
import '../../backend/services/wish/stripe_payment_model.dart';
import '../../backend/services/wish/wish_service.dart';
import '../../utils/strings.dart';
import '../../view/book_now/pay_screen.dart';
import '../../view/dynamic_webview_screen.dart';
import '../bottom_nav/message_controller.dart';

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
  RxBool isOccasionSelect = false.obs;
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
      selectedPawapayCountry =
          _paymentInfoModel.data.pawapayCountries.first.obs;
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
      'amount': type == "tips"
          ? tipsController.text
          : paymentInfoModel.data.earning.amount,
    };
    if (type == "wish") {
      inputBody.addAll({
        'dedicated_to': selectedOption.value,
        'occasion_id': selectedOcasion.value.id,
        'name': nameController.text,
        'from': fromController.text,
        'for': forController.text,
        'gender': selectedGender.value,
        'instructions': instructionsController.text,
      });
    }

    await stripePaymentProcessApi(body: inputBody, idType: '/$id/$type')
        .then((value) {
      _stripePaymentModel = value!;
      Get.to(WebViewScreen(
        appTitle: "",
        link: _stripePaymentModel.data.redirectUrl,
        onFinished: (url) async {
          if (url.toString() ==
              _stripePaymentModel.data.redirectionResponse.successUrl) {
            try {
              if (type == "tips") {
                Get.close(2);
              }else{
                Get.find<MessageController>().mailIndexProcess();
                Get.find<MessageController>().selectedType.value = 2;
                Get.close(4);
                Get.find<BottomNavController>().selectedIndex.value = 3;
              }
            } finally {
              openDialog(type, id);
            }

            // Get.offAllNamed(Routes.btmScreen);
            // CustomSnackBar.success(Strings.successfullyPaymentDone);
          }else if (url.toString().contains("/payment/stripe/cancel")) {
            Get.close(2);
            CustomSnackBar.error("Payment is not Done!");
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
  Future<MobilePaymentModel> mobilePaymentProcess(
      String id, String type) async {
    _isPaymentLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'talent_id': id,
      'type': type,
      'amount': type == "tips"
          ? tipsController.text
          : paymentInfoModel.data.earning.amount,
      'payment-type': "mobile-payment",
      'currency': "eur",
      'correspondent': selectedPawapayCountry.value.sim.first.correspondent,
      'phone_number': selectedPawapayCountry.value.sim.first.prefix,
      'country': selectedPawapayCountry.value.sim.first.country,
    };
    if (type == "wish") {
      inputBody.addAll({
        'dedicated_to': selectedOption.value,
        'occasion_id': selectedOcasion.value.id,
        'name': nameController.text,
        'from': fromController.text,
        'for': forController.text,
        'gender': selectedGender.value,
        'instructions': instructionsController.text,
      });
    }

    await mobilePaymentProcessApi(body: inputBody, idType: '/$id/$type')
        .then((value) {
      _mobilePaymentModel = value!;

      Get.to(WebViewScreen(
        appTitle: "",
        link: _mobilePaymentModel.data.redirectUrl,
        onFinished: (url) async {
          if (url.toString().contains("/success")) {
            try {
              if (type == "tips") {
                Get.close(2);
              }else{
                Get.close(3);
              }
            } finally {
              openDialog(type, id);
            }
          }
          else if (url.toString().contains("cancel=true")) {
            Get.close(2);
            CustomSnackBar.error("Payment is not Done!");
          }
          else if ( url.toString().contains("failure?token")) {
            Get.close(2);
            CustomSnackBar.error("Payment is not Done!");
          }
          else if ( url.toString().contains("/final-status-callback-api?depositId")) {
            Get.close(2);
            CustomSnackBar.error("Payment is not Done!");
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

  openDialog(String type, String id) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Get.close(1);
                      if (type == "tips") {

                        Get.find<MessageController>().mailIndexProcess();
                      } else {
                        // Get.find<MessageController>().mailIndexProcess();
                        // Get.find<MessageController>().selectedType.value = 2;
                        // Get.find<BottomNavController>().selectedIndex.value = 3;
                        // Get.offAllNamed(Routes.btmScreen, arguments: true);
                      }
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Payment successful',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                type == "tips"
                    ? Strings.successfullyPaymentDone
                    : 'Your order has been placed. We\'ll send you an email with your order details.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
