
import 'package:next_wisher/backend/model/common/common_success_model.dart';

import '../../backend/services/profile/tips_status_model.dart';
import '../../backend/services/profile/wish_and_tips_service.dart';
import '../../backend/services/profile/wish_status_model.dart';
import '../../utils/basic_screen_imports.dart';

class WishAnTipsController extends GetxController with WishAndTipsService{

  final amountController = TextEditingController();
  RxDouble amount = 0.0.obs;
  RxBool wishIsActivated = true.obs;
  RxBool tipsIsActivated = true.obs;


  @override
  void onInit() {
    wishStatusProcess();
    tipsStatusProcess();
    super.onInit();
  }
  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  late WishStatusModel _wishStatusModel;
  WishStatusModel get wishStatusModel => _wishStatusModel;


  ///* Get WishStatus in process
  Future<WishStatusModel> wishStatusProcess() async {
    _isLoading.value = true;
    update();
    await wishStatusProcessApi().then((value) {
      _wishStatusModel = value!;

      wishIsActivated.value = _wishStatusModel.data.wish.status == 1 ? true: false;
      amountController.text = _wishStatusModel.data.wish.amount.toStringAsFixed(2);
      amount.value = _wishStatusModel.data.wish.amount;

      debugPrint("WISH");
      debugPrint(_wishStatusModel.data.wish.status.toString());
      debugPrint(wishIsActivated.value.toString());

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _wishStatusModel;
  }


  /// ------------------------------------- >>
  late TipsStatusModel _tipsStatusModel;
  TipsStatusModel get tipsStatusModel => _tipsStatusModel;


  ///* Get TipsStatus in process
  Future<TipsStatusModel> tipsStatusProcess() async {
    _isLoading.value = true;
    update();
    await tipsStatusProcessApi().then((value) {
      _tipsStatusModel = value!;

      debugPrint("TIPS");
      tipsIsActivated.value = _tipsStatusModel.data.tips.status == 1 ? true: false;
      debugPrint(_tipsStatusModel.data.tips.status.toString());
      debugPrint(tipsIsActivated.value.toString());

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _tipsStatusModel;
  }


  /// ------------------------------------- >>
  late CommonSuccessModel _wishSaveModel;
  CommonSuccessModel get wishSaveModel => _wishSaveModel;


  ///* WishSave in process
  Future<CommonSuccessModel> wishSaveProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'amount': amountController.text,
      'status': wishIsActivated.value ? 1 : 0,
    };
    await wishSaveProcessApi(body: inputBody).then((value) {
      _wishSaveModel = value!;
      wishStatusProcess();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _wishSaveModel;
  }



  /// ------------------------------------- >>

  late CommonSuccessModel _tipsSaveModel;
  CommonSuccessModel get tipsSaveModel => _tipsSaveModel;


  ///* TipsSave in process
  Future<CommonSuccessModel> tipsSaveProcess() async {
    _isLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'status': tipsIsActivated.value ? 1 : 0,
    };
    await tipsSaveProcessApi(body: inputBody).then((value) {
      _tipsSaveModel = value!;
      tipsStatusProcess();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _tipsSaveModel;
  }

}