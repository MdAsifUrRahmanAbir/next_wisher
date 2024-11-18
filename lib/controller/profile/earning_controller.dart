

import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/services/earning/earning_model.dart';
import '../../backend/services/earning/earning_service.dart';

class EarningController extends GetxController with EarningService{

@override
  void onInit() {
  earningProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  late EarningModel _earningModel;
  EarningModel get earningModel => _earningModel;


  ///* Get Earning in process
  Future<EarningModel> earningProcess() async {
    _isLoading.value = true;
    update();
    await earningProcessApi().then((value) {
      _earningModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _earningModel;
  }


}