
import 'package:next_wisher/backend/extensions/custom_extensions.dart';

class ApiEndpoint {
  static String mainDomain = "";
  static String baseUrl = "$mainDomain/api";

  ///-> Auth
  static String loginURL = '/login'.addBaseURl();
  static String registerURL = '/register'.addBaseURl();
}