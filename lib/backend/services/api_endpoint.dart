import 'package:next_wisher/backend/extensions/custom_extensions.dart';

class ApiEndpoint {
  static String mainDomain = "https://next-wisher.skyflightbd.com";
  static String baseUrl = "$mainDomain/public/api/v1";

  ///-> Auth for both user and talent
  static String loginURL = '/login'.addBaseURl();
  static String registerURL = '/register'.addBaseURl();
  static String logoutURL = '/logout'.addBaseURl();
  static String signupInfoURL = '/signup-info'.addBaseURl();

  ///-> Common
  static String homeURL = '/index'.addBaseURl();
  static String talentsDetailsURL = '/talents'.addBaseURl();

  static String mailIndexURL = '/user/mail-index'.addBaseURl();
  static String mailCountURL = '/user/mail-count'.addBaseURl();
  static String mailSeenURL = '/user/mail-seen'.addBaseURl();
  static String downloadURL = '/user/mail-media-api'.addBaseURl();
  static String ratingSubmitURL = '/user/rating-submit'.addBaseURl();
  static String mailReplyURL = '/talent/mail-replay'.addBaseURl();


  ///-> User
  static String userDashboardURL = '/user/dashboard'.addBaseURl();
  static String userProfileURL = '/user/profile'.addBaseURl();
  static String userProfileUpdateURL = '/user/profile-update'.addBaseURl();
  static String userProfileDeleteURL = '/user/profile-delete'.addBaseURl(); /// for both user and talent
  static String userChangePasswordURL = '/user/change-password'.addBaseURl();

  static String wishPaymentInfoURL = '/user/wish-payment-info'.addBaseURl();
  static String mobilePayURL = '/user/mobile-pay/pay'.addBaseURl();
  static String stripePayURL = '/user/payment/pay'.addBaseURl();

  ///-> Talent
  static String talentDashboardURL = '/talent/dashboard'.addBaseURl();
  static String talentProfileURL = '/talent/profile'.addBaseURl();
  static String talentProfileUpdateURL = '/talent/profile-update'.addBaseURl();
  // static String talentProfileDeleteURL = '/talent/profile-delete'.addBaseURl();
  static String talentChangePasswordURL = '/talent/change-password'.addBaseURl();


}