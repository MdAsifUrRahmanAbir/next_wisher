import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/controller/auth/login_controller.dart';

import '../../utils/basic_screen_imports.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: mainCenter,
          children: [
            Image.asset("assets/email_verification.png"),
            TitleHeading3Widget(text: "Please verify your email"),
            verticalSpace(4),
            TitleHeading4Widget(
                textAlign: TextAlign.center,
                text:
                    "Just click on the verification button in that email to complete your signup. If you do not see it, you should check your spam folder."),
            verticalSpace(18),
            Obx(() => Row(
                  children: [
                    Expanded(
                        child: Get.find<LoginController>().isResendEmailLoading
                            ? CustomLoadingAPI()
                            : PrimaryButton(
                                title: "Resend Email", onPressed: () {
                          Get.find<LoginController>()
                              .resendEmailProcess();
                        })),
                    horizontalSpace(Dimensions.paddingSizeHorizontal * .4),
                    Expanded(
                        child: Get.find<LoginController>().isLoading
                            ? CustomLoadingAPI()
                            : PrimaryButton(
                                title: "Verified?",
                                backgroundColor: CustomColor.redColor,
                                onPressed: () {
                                  Get.find<LoginController>()
                                      .loginProcess(false);
                                })),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
