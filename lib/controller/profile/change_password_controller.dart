
import '../../utils/basic_screen_imports.dart';

class ChangePasswordController extends GetxController {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  void changePassword() async{
    if(formKey.currentState!.validate()){
      // await changePasswordProcess();
    }
  }

}