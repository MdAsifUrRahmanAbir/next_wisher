import 'package:intl/intl.dart';
import 'package:next_wisher/backend/utils/custom_snackbar.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/services/earning/earning_filter_model.dart';
import '../../backend/services/earning/earning_model.dart';
import '../../backend/services/earning/earning_service.dart';
import '../../language/language_controller.dart';

class EarningController extends GetxController with EarningService {
  @override
  void onInit() {
    earningProcess();
    earningFilterProcess(inputBody: {});
    super.onInit();
  }

  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;

  RxBool startDateSelect = false.obs;
  RxBool endDateSelect = false.obs;

  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = isStartDate ? DateTime.now() : startDate.value;
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      if (isStartDate) {
        startDate.value = pickedDate;
        startDateSelect.value = true;
        endDateSelect.value = false;
        CustomSnackBar.error("Please Select End Date");
      } else {
        endDateSelect.value = true;
        endDate.value = pickedDate;
        debugPrint(startDate.value.isAfter(endDate.value).toString());
        if(startDate.value.isAfter(endDate.value)){
          CustomSnackBar.error("Invalid Date Selection");
        }
        else {
          earningFilterProcess(inputBody: {
            'start_date': DateFormat('yyyy-MM-dd').format(startDate.value.toUtc()),
            // 'start_date': DateFormat('dd MMMM, yyyy').format(startDate.value),
            'end_date': DateFormat('yyyy-MM-dd').format(endDate.value.toUtc()),
            // 'end_date': DateFormat('dd MMMM, yyyy').format(endDate.value),
          });
        }
      }
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MM/dd/yyyy').format(date);
  }

  RxString selectedFilter = 'All time'.obs;

  final List<String> filterOptions = [
    languageSettingController.getTranslation('All time'),
    languageSettingController.getTranslation('Today'),
    languageSettingController.getTranslation('Yesterday'),
    languageSettingController.getTranslation('Last 7Days'),
  languageSettingController.getTranslation('Last 30Days'),
  languageSettingController.getTranslation('Last 60Days'),
  languageSettingController.getTranslation('Last 90Days'),
  languageSettingController.getTranslation('Last 365Days'),
  ];

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late EarningModel _earningModel;
  EarningModel get earningModel => _earningModel;

  RxInt selectedIndex = (-1).obs;

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

  /// ------------------------------------- >>
  final _isFilterLoading = false.obs;
  bool get isFilterLoading => _isFilterLoading.value;

  late EarningFilterModel _earningFilterModel;
  EarningFilterModel get earningFilterModel => _earningFilterModel;

  ///* EarningFilter in process
  Future<EarningFilterModel> earningFilterProcess(
      {required Map<String, dynamic> inputBody}) async {
    _isFilterLoading.value = true;
    update();

    await earningFilterProcessApi(body: inputBody).then((value) {
      _earningFilterModel = value!;
      _isFilterLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isFilterLoading.value = false;
    update();
    return _earningFilterModel;
  }
}
