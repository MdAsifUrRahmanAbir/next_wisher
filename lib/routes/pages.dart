import 'package:get/get.dart';
import '../binding/dashboard_binding.dart';
import '../binding/splash_binding.dart';
import '../view/auth/login_screen.dart';
import '../view/auth/talent_registration_screen.dart';
import '../view/auth/user_registration_screen.dart';
import '../view/auth/reset_password_screen.dart';
import '../view/auth/user_type_screen.dart';
import '../view/befor_auth/splash_screen.dart';
import '../view/befor_auth/welcome_screen.dart';
import '../view/book_now/book_now_screen.dart';
import '../view/bottom_nav/bottom_nav_screen.dart';
import '../view/drawer_screens/change_password_screen.dart';
import '../view/profiles_screen/account_screen.dart';
import '../view/profiles_screen/guidline_screen.dart';
import '../view/profiles_screen/history_screen.dart';
import '../view/profiles_screen/payment_screen.dart';
import '../view/profiles_screen/profle_setup_screen.dart';
import '../view/profiles_screen/theme_change_screen.dart';
import '../view/profiles_screen/tips_screen.dart';
import '../view/profiles_screen/wish_request_screen.dart';
import '../view/talent_profile/talent_profile.dart';
import '../view/talent_profile/talent_profile_next.dart';
import 'routes.dart';

class Pages{
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.welcomeScreen,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: Routes.userTypeScreen,
      page: () => const UserTypeScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.userRegistrationScreen,
      page: () => UserRegistrationScreen(),
    ),
    GetPage(
      name: Routes.talentRegistrationScreen,
      page: () => TalentRegistrationScreen(),
    ),

    GetPage(
      name: Routes.btmScreen,
      page: () => BottomNavScreen(),
      binding: DashboardBinding()
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => ResetPasswordScreen(),
    ),

    GetPage(
      name: Routes.guidelineScreen,
      page: () => GuidelineScreen(),
    ),
    GetPage(
      name: Routes.accountScreen,
      page: () =>  AccountScreen(),
    ),
    GetPage(
      name: Routes.talentProfile,
      page: () =>  TalentProfile(),
    ),
    GetPage(
      name: Routes.talentProfileNext,
      page: () =>  TalentProfileNext(),
    ),
    GetPage(
      name: Routes.bookNowScreen,
      page: () =>  BookNowScreen(),
    ),
    GetPage(
      name: Routes.profileSetupScreen,
      page: () =>  const ProfileSetupScreen(),
    ),
    GetPage(
      name: Routes.wishRequest,
      page: () =>  const WishRequest(),
    ),
    GetPage(
      name: Routes.tipsScreen,
      page: () =>  const TipsScreen(),
    ),
    GetPage(
      name: Routes.paymentScreen,
      page: () =>  const PaymentScreen(),
    ),
    GetPage(
      name: Routes.historyScreen,
      page: () =>  const HistoryScreen(),
    ),
    GetPage(
      name: Routes.themeChangeScreen,
      page: () =>  const ThemeChangeScreen(),
    ),
  ];
}
