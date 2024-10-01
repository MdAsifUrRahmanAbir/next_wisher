
import '../../utils/basic_screen_imports.dart';

class ProfileController extends GetxController {
  final fullNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final postalCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final additionalInformationController = TextEditingController();

  final emailController = TextEditingController();

  @override
  void onInit() {
    // profileProcess();
    super.onInit();
  }

  void updateProfile() {
    // updateProfileProcess();
  }


}
