import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/backend/utils/custom_snackbar.dart';
import 'package:next_wisher/language/language_controller.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/services/wish/payment_info_model.dart';
import '../../controller/book_now/book_now_controller.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

class BookNowScreen extends StatelessWidget {
  BookNowScreen({super.key});

  final controller = Get.find<BookNowController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Obx(() =>
          controller.isLoading ? const CustomLoadingAPI() : _bodyWidget()),
    );
  }

  _bodyWidget() {

    var data = controller.paymentInfoModel.data.talent;
    return SafeArea(
      child: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            TitleHeading2Widget(text: data.name, fontWeight: FontWeight.bold),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            TitleHeading3Widget(
              text: "${languageSettingController.getTranslation(data.category.name)} / ${languageSettingController.getTranslation(data.subcategory.name)}",
              opacity: .5,
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .5),
            Row(
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: "myself",
                      groupValue: controller.selectedOption.value,
                      onChanged: (String? value) {
                        controller.nameController.text = "";
                        controller.fromController.text = "";
                        controller.forController.text = "";
                        controller.selectedOption.value = value!;
                      },
                    ),
                    TitleHeading3Widget(
                        text: "Myself", fontWeight: FontWeight.bold),
                  ],
                ),
                horizontalSpace(Dimensions.paddingSizeHorizontal * .5),
                Row(
                  children: [
                    Radio<String>(
                      value: "else",
                      groupValue: controller.selectedOption.value,
                      onChanged: (String? value) {
                        controller.nameController.text = "";
                        controller.fromController.text = "";
                        controller.forController.text = "";

                        controller.selectedOption.value = value!;
                      },
                    ),
                    TitleHeading3Widget(
                        text: "Someone else", fontWeight: FontWeight.bold)
                  ],
                ),
              ],
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .5),
            Visibility(
              visible: controller.selectedOption.value == "else",
              child: Column(
                children: [
                  PrimaryTextInputWidget(
                      controller: controller.fromController,
                      labelText: Strings.from,
                      hint: ""),
                  verticalSpace(Dimensions.paddingSizeVertical * .5),
                  PrimaryTextInputWidget(
                      controller: controller.forController,
                      labelText: Strings.forText,
                      hint: ""),
                ],
              ),
            ),
            Visibility(
                visible: controller.selectedOption.value == "myself",
                child: PrimaryTextInputWidget(
                    controller: controller.nameController,
                    labelText: "Enter your name",
                    error: "name is required",
                    hint: "")),
            verticalSpace(Dimensions.paddingSizeVertical * .5),
            TitleHeading3Widget(
                text: Strings.gender, fontWeight: FontWeight.bold),
            Column(
              crossAxisAlignment: crossStart,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: "Female",
                          groupValue: controller.selectedGender.value,
                          onChanged: (String? value) {
                            controller.gender.value = true;
                            controller.selectedGender.value = value!;
                          },
                        ),
                        TitleHeading3Widget(
                            text: Strings.female, fontWeight: FontWeight.bold),
                      ],
                    ),
                    horizontalSpace(Dimensions.paddingSizeHorizontal * .5),
                    Row(
                      children: [
                        Radio<String>(
                          value: "Male",
                          groupValue: controller.selectedGender.value,
                          onChanged: (String? value) {
                            controller.gender.value = true;
                            controller.selectedGender.value = value!;
                          },
                        ),
                        TitleHeading3Widget(
                            text: Strings.male, fontWeight: FontWeight.bold)
                      ],
                    ),
                  ],
                ),
                // Obx(() => controller.gender.value ? SizedBox.shrink(): controller.alertEnable.value ? TitleHeading5Widget(text: "gender is required", color: Colors.red): SizedBox.shrink())
                ],
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .5),
            TitleHeading3Widget(
                text: "Occasion", fontWeight: FontWeight.bold),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            Obx(() => Column(
              crossAxisAlignment: crossStart,
              children: [
                CustomDropDown<Ocasion>(
                      items: controller.paymentInfoModel.data.ocasions,
                      onChanged: (value) {
                        controller.isOccasionSelect.value = true;
                        controller.occassion.value = true;
                        controller.selectedOcasion.value = value!;
                      },
                      hint: controller.isOccasionSelect.value ? controller.selectedOcasion.value.name : "Select Occasion",
                      title: "Select Occasion",
                    ),
                // controller.occassion.value ? SizedBox.shrink(): TitleHeading5Widget(text: "occassion id is required", color: Colors.red)
              ],
            )),
            verticalSpace(Dimensions.paddingSizeVertical * .5),

            TitleHeading3Widget(
                text: "Instructions", fontWeight: FontWeight.bold),
            verticalSpace(Dimensions.paddingSizeVertical * .2),

            PrimaryTextInputWidget(
              controller: controller.instructionsController,
              labelText: "Write Instructions",
              hint: "",
              maxLine: 3,
              error: "instruction is required",
            ),
            verticalSpace(Dimensions.paddingSizeVertical * 1.5),
            PrimaryButton(
                title: "Continue to payment",
                backgroundColor: CustomColor.redColor,
                onPressed: () {
                  if(controller.formKey.currentState!.validate()){
                    controller.alertEnable.value = true;
                    if (controller.selectedGender.value.isNotEmpty) {
                      debugPrint(controller.isOccasionSelect.value.toString());
                      if(controller.isOccasionSelect.value){
                        controller.pay();
                      }else{
                        CustomSnackBar.error("occassion id is required");
                      }
                    } else {
                      CustomSnackBar.error("gender is required");

                    }
                  }

                }),
            verticalSpace(Dimensions.paddingSizeVertical * 1),
          ],
        ),
      ),
    );
  }
}
