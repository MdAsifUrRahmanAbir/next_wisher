import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/backend/utils/custom_snackbar.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/services/wish/payment_info_model.dart';
import '../../controller/book_now/book_now_controller.dart';
import '../../controller/bottom_nav/dashboard_controller.dart';
import '../../language/language_controller.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

class PayScreen extends StatelessWidget {
  PayScreen({super.key, required this.isBook});
  final bool isBook;
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
    var model = controller.paymentInfoModel.data;
    var data = model.talent;

    double amount = isBook
        ? model.earning.amount
        : Get.find<DashboardController>().talentsModel.data.tips.amount;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            TitleHeading2Widget(text: data.name, fontWeight: FontWeight.bold),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            TitleHeading3Widget(
              text:
                  "${languageSettingController.getTranslation(data.category.name)}/${languageSettingController.getTranslation(data.subcategory.name)}",
              opacity: .5,
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .5),

            Visibility(
              visible: !isBook,
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  TitleHeading5Widget(
                    text: Strings.enterAmount,
                    opacity: .5,
                  ),
                  verticalSpace(Dimensions.paddingSizeVertical * .3),
                  PrimaryTextInputWidget(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.tipsValue.value = double.parse(value);
                        }
                      },
                      controller: controller.tipsController,
                      labelText: Strings.tip),
                  verticalSpace(Dimensions.paddingSizeVertical * .8),
                ],
              ),
            ),
            // const Divider(),

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  color: Theme.of(Get.context!).primaryColor.withOpacity(.2)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      TitleHeading3Widget(
                          text: isBook ? Strings.book : Strings.tip,
                          fontWeight: FontWeight.normal),
                      TitleHeading3Widget(
                          text:
                              "€${isBook ? amount.toStringAsFixed(2) : controller.tipsValue.value.toStringAsFixed(2)}",
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  verticalSpace(Dimensions.paddingSizeVertical * .1),
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      TitleHeading3Widget(
                          text: Strings.serviceFee,
                          fontWeight: FontWeight.normal),
                      TitleHeading3Widget(
                          text:
                              "€${((isBook ? amount : controller.tipsValue.value) * (model.maintainanceCharge / 100)).toStringAsFixed(2)}",
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ],
              ),
            ),

            verticalSpace(Dimensions.paddingSizeVertical * .8),

            TitleHeading3Widget(
                textAlign: TextAlign.center,
                text: "Select payment method",
                fontWeight: FontWeight.bold),

            verticalSpace(Dimensions.paddingSizeVertical * .2),

            Obx(() => Column(
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: "credit-card",
                          groupValue: controller.paymentType.value,
                          onChanged: (String? value) {
                            controller.paymentType.value = value!;
                          },
                        ),
                        TitleHeading3Widget(
                            text: "Credit card", fontWeight: FontWeight.bold),
                      ],
                    ),
                    horizontalSpace(Dimensions.paddingSizeHorizontal * .5),
                    Row(
                      children: [
                        Radio<String>(
                          value: "mobile-bank",
                          groupValue: controller.paymentType.value,
                          onChanged: (String? value) {
                            controller.paymentType.value = value!;
                          },
                        ),
                        TitleHeading3Widget(
                            text: "Mobile payment", fontWeight: FontWeight.bold)
                      ],
                    ),
                  ],
                )),

            // verticalSpace(Dimensions.paddingSizeVertical * .8),

            Obx(() => controller.paymentType.value == "credit-card"
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      verticalSpace(Dimensions.paddingSizeVertical * .8),
                      Obx(() => CustomDropDown<PawapayCountry>(
                            items: controller
                                .paymentInfoModel.data.pawapayCountries,
                            onChanged: (value) {
                              controller.selectedPawapayCountryDone.value =
                                  true;
                              controller.selectedPawapayCountry.value = value!;
                            },
                            hint: !controller.selectedPawapayCountryDone.value
                                ? Strings.selectCountry
                                : "${controller.selectedPawapayCountry.value.name} (${controller.selectedPawapayCountry.value.sim.first.currency})",
                            title: Strings.selectCountry,
                          )),
                    ],
                  )),

            verticalSpace(Dimensions.paddingSizeVertical * 1.5),
            Obx(() => controller.isPaymentLoading
                ? const CustomLoadingAPI()
                : PrimaryButton(
                    title: "Continue to payment",
                    prefix: "💳",
                    suffix: "€${(

                        ///   tipsValue.value + (tipsValue.value * (paymentInfoModel.data.commission / 100))
                        (isBook ? amount : controller.tipsValue.value) + ((isBook ? amount : controller.tipsValue.value) * (model.maintainanceCharge / 100))).toStringAsFixed(2)}",
                    backgroundColor: CustomColor.secondaryLightColor,
                    onPressed: () {
                      debugPrint(">> $isBook");
                      debugPrint(">> ${controller.tipsValue.value}");
                      debugPrint(
                          ">> ${((!isBook) && (controller.tipsValue.value.isGreaterThan(500) || controller.tipsValue.value.isLowerThan(10)))}");
                      debugPrint(
                          ">> ${(controller.tipsValue.value.isGreaterThan(500) || controller.tipsValue.value.isLowerThan(10))}");

                      if ((!isBook) &&
                          (controller.tipsValue.value.isGreaterThan(500) ||
                              controller.tipsValue.value.isLowerThan(10))) {
                        debugPrint("00000");
                        CustomSnackBar.error(Strings.tipsLimit);
                        return;
                      }
                      debugPrint("1111111");

                      /// tipsValue.value + (tipsValue.value * (paymentInfoModel.data.commission / 100))
                      if (controller.paymentType.value == "credit-card") {
                        controller.payment(
                            data.id.toString(), isBook ? "wish" : "tips");
                      } else {
                        showConversionBottomSheet(
                          Get.context!,
                          currencyCode: controller.selectedPawapayCountry.value
                              .sim.first.currency, // Example Currency Code
                          currencyRate: controller.selectedPawapayCountry.value
                              .rate, // Example Conversion Rate
                          data: data,
                          amount: (isBook
                                  ? amount
                                  : controller.tipsValue.value) +
                              ((isBook ? amount : controller.tipsValue.value) *
                                  (model.maintainanceCharge /
                                      100)), // Example Amount
                        );
                      }
                    })),

            verticalSpace(Dimensions.paddingSizeVertical * 1),
          ],
        ),
      ),
    );
  }

  void showConversionBottomSheet(BuildContext context,
      {required String currencyCode,
      required double currencyRate,
      required data,
      required double amount}) {
    final double convertedAmount = amount * currencyRate;
    final double conversionFee = convertedAmount * 0.035;
    final double totalAmount = convertedAmount + conversionFee;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.warning, size: 50, color: Colors.orange),
              const SizedBox(height: 16),
              TitleHeading3Widget(
                text:
                    "The payment amount will be converted and processed in $currencyCode at the following rate:",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TitleHeading3Widget(
                  text: "€1 = $currencyRate $currencyCode",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              const SizedBox(height: 8),
              TitleHeading3Widget(
                  text: "We also charge a 3.5% conversion fee", fontSize: 14),
              const SizedBox(height: 16),
              Text(
                "€$amount = ${convertedAmount.toStringAsFixed(2)} $currencyCode",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const TitleHeading3Widget(
                text: "All amounts are rounded up to the nearest decimal",
                fontSize: 12,
                color: Colors.red,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: mainCenter,
                children: [
                  TitleHeading3Widget(
                    text: "You will be charged",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  TitleHeading3Widget(
                    text: " $currencyCode ${totalAmount.toStringAsFixed(2)}",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              TitleHeading3Widget(
                  text:
                      "${convertedAmount.toStringAsFixed(2)} + ${conversionFee.toStringAsFixed(2)} conversion fee",
                  fontSize: 14,
                  color: Colors.black54),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.payment(
                      data.id.toString(), isBook ? "wish" : "tips");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: mainCenter,
                  children: [
                    TitleHeading3Widget(
                        text: "Pay Now", fontSize: 16, color: Colors.white),
                    TitleHeading3Widget(
                        text:
                            ": $currencyCode ${totalAmount.toStringAsFixed(2)}",
                        fontSize: 16,
                        color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
