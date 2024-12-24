import 'package:next_wisher/backend/extensions/custom_extensions.dart';

class ApiEndpoint {
  // static String mainDomain = "https://next-wisher.skyflightbd.com/public";
  static String mainDomain = "https://nextwisher.com";
  static String baseUrl = "$mainDomain/api/v1";

  ///-> Auth for both user and talent
  static String languageURL = '/languages'.addBaseURl();
  static String loginURL = '/login'.addBaseURl();
  static String resendEmail = '/email-verification'.addBaseURl();
  static String forgotPasswordURL = '/forgot-password-api'.addBaseURl();
  static String registerURL = '/register'.addBaseURl();
  static String logoutURL = '/logout'.addBaseURl();
  static String signupInfoURL = '/signup-info'.addBaseURl();

  ///-> Common
  static String homeURL = '/index'.addBaseURl();
  static String talentsDetailsURL = '/talents'.addBaseURl();
  static String categoryURL = '/category'.addBaseURl();

  static String mailIndexURL = '/user/mail-index'.addBaseURl();
  static String mailCountURL = '/user/mail-count'.addBaseURl();
  static String mailSeenURL = '/user/mail-seen'.addBaseURl();
  static String downloadURL = '/user/mail-media-api'.addBaseURl();
  static String rattingCheckURL = '/user/rating-check'.addBaseURl();
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
  static String talentChangePasswordURL = '/talent/change-password'.addBaseURl();

  ///-> Talent Profile Set up
  static String talentSetupImageURL = '/talent/profile-setup-image'.addBaseURl();
  static String talentSetupVideoURL = '/talent/profile-setup-video'.addBaseURl();
  static String talentSetupURL = '/talent/profile-setup'.addBaseURl();
  static String languageSupportURL = '/talent/supported-languages'.addBaseURl();

  ///-> Talent Wish & Tips Request Set Up
  static String talentWishRequestURL = '/talent/wish-request'.addBaseURl();
  static String saveWishRequestURL = '/talent/save-wish-request'.addBaseURl();
  static String talentTipsRequestURL = '/talent/tips-request'.addBaseURl();
  static String saveTipsRequestURL = '/talent/save-tips-request'.addBaseURl();

  ///-> earning and payout
  static String earningURL = '/talent/earnings'.addBaseURl();
  static String earningFilterURL = '/talent/earning-filter'.addBaseURl();

  static String talentPayoutInfoURL = '/talent/payout-info'.addBaseURl();

  static String talentPayoutRequestURL = '/talent/payout-request'.addBaseURl();
  static String mobilePayoutRequestURL = '/talent/mobile-payout-request'.addBaseURl();

  static String bankPayoutCanadaURL = '/talent/bank-payout-canada'.addBaseURl();
  static String bankPayoutEuropeURL = '/talent/bank-payout-europe'.addBaseURl();
  static String bankPayoutOutsideURL = '/talent/bank-payout-outside'.addBaseURl();
}