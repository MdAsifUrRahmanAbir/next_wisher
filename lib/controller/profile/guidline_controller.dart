
import 'package:get/state_manager.dart';

import '../../backend/services/dashboard/dashboard_service.dart';
import '../../backend/services/dashboard/guid_data_model.dart';

class GuidelineController extends GetxController with DashboardService{


@override
  void onInit() {
  guidDataProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  late GuidDataModel _guidDataModel;
  GuidDataModel get guidDataModel => _guidDataModel;


  ///* Get GuidData in process
  Future<GuidDataModel> guidDataProcess() async {
    _isLoading.value = true;
    update();
    await guidDataProcessApi().then((value) {
      _guidDataModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _guidDataModel;
  }

}