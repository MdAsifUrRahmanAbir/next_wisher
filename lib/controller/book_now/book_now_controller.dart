

import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/services/wish/payment_info_model.dart';
import '../../backend/services/wish/wish_service.dart';
import '../../view/book_now/pay_screen.dart';

class BookNowController extends GetxController with WishService{
  final formKey = GlobalKey<FormState>();

  RxString paymentType = 'mobile-bank'.obs;
  RxString selectedOption = "myself".obs;
  RxString selectedGender = "".obs;

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

  late PaymentInfoModel _paymentInfoModel;
  PaymentInfoModel get paymentInfoModel => _paymentInfoModel;


  ///* Get PaymentInfo in process
  Future<PaymentInfoModel> paymentInfoProcess(int id) async {
    _isLoading.value = true;
    update();
    await paymentInfoProcessApi(id.toString()).then((value) {
      _paymentInfoModel = value!;
      selectedOcasion = _paymentInfoModel.data.ocasions.first.obs;
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
    if(!formKey.currentState!.validate()){
      Get.to(PayScreen(isBook: true));
    }
  }



  void payment() {
    if(paymentType.value == "stripe"){

    }
    else{

    }
  }
}