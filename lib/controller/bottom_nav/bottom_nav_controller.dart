import 'package:next_wisher/backend/model/common/common_success_model.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/services/auth/auth_service.dart';
import '../../backend/services/wish/mail_count_model.dart';
import '../../backend/services/wish/wish_service.dart' as wish;
import '../../view/nav_pages/dashboard/dashboard_page.dart';
import '../../view/nav_pages/message/messages_page.dart';
import '../../view/nav_pages/profile/profile_page.dart';
import 'message_controller.dart';

class BottomNavController extends GetxController
    with AuthService, wish.WishService {
  RxInt selectedIndex = 0.obs;
  RxBool isDark = false.obs;

  dynamic argument = Get.arguments;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  List body = [
    DashboardPage(),
    const Center(child: Text("Language")),
    const Center(child: Text("Menu")),
    LocalStorage.isUser() ? MessagePage() : MessagePage(),
    ProfilePage(),
    const Center(child: Text("NextWisher")),
  ];

  // List bodyTitle = [
  //   "How To Order",
  //   "Prices",
  //   "Shopping Cart",
  //   "Profile"
  // ];

  // RxBool isFirst = true.obs;
  // Stream<MailCountModel> getDashboardDataStream() async* {
  //   while (true) {
  //     await Future.delayed(Duration(seconds: isFirst.value ? 1 : 4));
  //     MailCountModel data = await mailCountProcess();
  //     isFirst.value = false;
  //     yield data;
  //   }
  // }

  @override
  void onInit() {
    debugPrint(" >> ARGUMENTS : $argument");
    debugPrint(argument.toString());
    if (argument is bool) {
      if(argument) {
        onItemTapped(3);
      }
    } else if (argument is String) {
      Get.find<MessageController>().mailSeenProcess(argument);
    }
    mailCountProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isCountLoading = false.obs;
  bool get isCountLoading => _isCountLoading.value;

  late MailCountModel _mailCountModel;
  MailCountModel get mailCountModel => _mailCountModel;

  ///* Get MailCount in process
  Future<MailCountModel> mailCountProcess() async {
    _isCountLoading.value = true;
    update();
    await mailCountProcessApi().then((value) {
      _mailCountModel = value!;
      _isCountLoading.value = false;
      update();
    }).catchError((onError) {
      wish.log.e(onError);
    });
    _isCountLoading.value = false;
    update();
    return _mailCountModel;
  }

  /// ------------------------------------- >>
  final _isLogoutLoading = false.obs;
  bool get isLogoutLoading => _isLogoutLoading.value;

  late CommonSuccessModel _logoutModel;
  CommonSuccessModel get logoutModel => _logoutModel;

  ///* Logout in process
  Future<CommonSuccessModel> logoutProcess() async {
    _isLogoutLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {};
    await logoutProcessApi(body: inputBody).then((value) {
      _logoutModel = value!;
      LocalStorage.logout();
      _isLogoutLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLogoutLoading.value = false;
    update();
    return _logoutModel;
  }
}
