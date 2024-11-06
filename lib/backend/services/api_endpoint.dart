import 'package:next_wisher/backend/extensions/custom_extensions.dart';

class ApiEndpoint {
  static String mainDomain = "https://next-wisher.skyflightbd.com";
  static String baseUrl = "$mainDomain/public/api/v1";

  ///-> Auth for both user and talent
  static String loginURL = '/login'.addBaseURl();
  static String registerURL = '/register'.addBaseURl();
  static String logoutURL = '/logout'.addBaseURl();
  static String signupInfoURL = '/signup-info'.addBaseURl();
  /// auth-check

  ///-> Common
  static String homeURL = '/index'.addBaseURl();
  static String talentsDetailsURL = '/talents'.addBaseURl();

  ///-> User
  static String userDashboardURL = '/user/dashboard'.addBaseURl();
  static String userProfileURL = '/user/profile'.addBaseURl();
  static String userProfileUpdateURL = '/user/profile-update'.addBaseURl();
  static String userProfileDeleteURL = '/user/profile-delete'.addBaseURl();
  static String userChangePasswordURL = '/user/change-password'.addBaseURl();


}