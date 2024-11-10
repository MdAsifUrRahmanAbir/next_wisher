import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/widgets/dialog_helper.dart';
import 'package:next_wisher/widgets/inputs/password_input_widget.dart';

import '../../controller/profile/profile_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Obx(() =>
          controller.isLoading ? const CustomLoadingAPI() : _bodyWidget()),
    );
  }

  _bodyWidget() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal Information Section
              _updateProfileWidget(),
              const SizedBox(height: 24),

              // Change Password Section
              _changePassword(),
              const SizedBox(height: 24),

              _deleteProfileWidget(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  _changePassword() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Form(
        key: controller.changeFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleHeading2Widget(text: Strings.changePassword),
            const SizedBox(height: 16),
            PasswordInputWidget(
                controller: controller.currentPasswordController,
                hint: Strings.enterPassword,
                labelText: Strings.oldPassword),
            SizedBox(height: Dimensions.paddingSizeVertical * .6),
            PasswordInputWidget(
                controller: controller.newPasswordController,
                hint: Strings.enterPassword,
                labelText: Strings.newPassword),
            SizedBox(height: Dimensions.paddingSizeVertical * .6),
            PasswordInputWidget(
                controller: controller.confirmPasswordController,
                hint: Strings.enterPassword,
                labelText: Strings.confirmPassword),
            const SizedBox(height: 16),
        Obx(() => controller.isChangeLoading ? const CustomLoadingAPI(): PrimaryButton(
              onPressed: () {
                controller.changePassword();
              },
              title: Strings.changePassword,
            )),
          ],
        ),
      ),
    );
  }

  _updateProfileWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Form(
        key: controller.updateFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleHeading2Widget(text: Strings.personalInformation),
            const SizedBox(height: 16),
            PrimaryTextInputWidget(
                controller: controller.nameController,
                labelText: Strings.name,
                hint: Strings.enterName),
            SizedBox(height: Dimensions.paddingSizeVertical * .6),
            PrimaryTextInputWidget(
                controller: controller.emailController,
                readOnly: true,
                labelText: Strings.email,
                hint: ""),
            const SizedBox(height: 16),
        Obx(() => controller.isUpdateLoading ? const CustomLoadingAPI(): PrimaryButton(
                title: Strings.update,
                onPressed: () {
                  controller.updateProfile();
                }))
          ],
        ),
      ),
    );
  }

  _deleteProfileWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => controller.isDeleteLoading ? const CustomLoadingAPI(): PrimaryButton(
              backgroundColor: CustomColor.redColor,
              title: Strings.delete,
              onPressed: () {
                DialogHelper.showAlertDialog(Get.context!,
                    title: Strings.delete,
                    content: Strings.areYouSure,
                    onTap: () {
                  Get.close(1);
                  controller.deleteAccountProcess();
                    });
              }))
        ],
      ),
    );
  }
}
