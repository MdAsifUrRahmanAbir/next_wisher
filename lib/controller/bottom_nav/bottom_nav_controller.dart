import 'package:next_wisher/backend/model/common/common_success_model.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/services/auth/auth_service.dart';
import '../../view/nav_pages/dashboard/dashboard_page.dart';
import '../../view/nav_pages/message/messages_page.dart';
import '../../view/nav_pages/profile/profile_page.dart';

class BottomNavController extends GetxController with AuthService{
  RxInt selectedIndex = 0.obs;
  RxBool isDark = false.obs;

  void onItemTapped(int index) {
      selectedIndex.value = index;
  }

  List body = [
    DashboardPage(),
    const Center(child: Text("Language")),
    const Center(child: Text("Menu")),
    MessagePage(),
    ProfilePage()
  ];

  // List bodyTitle = [
  //   "How To Order",
  //   "Prices",
  //   "Shopping Cart",
  //   "Profile"
  // ];


  /// ------------------------------------- >>
  final _isLogoutLoading = false.obs;
  bool get isLogoutLoading => _isLogoutLoading.value;


  late CommonSuccessModel _logoutModel;
  CommonSuccessModel get logoutModel => _logoutModel;


  ///* Logout in process
  Future<CommonSuccessModel> logoutProcess() async {
    _isLogoutLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
    };
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