import '../../utils/basic_screen_imports.dart';

class ResetPasswordController extends GetxController{
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  void changePassword() async{
    if(formKey.currentState!.validate()){
    }
  }
}