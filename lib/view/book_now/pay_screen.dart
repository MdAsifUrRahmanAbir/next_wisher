import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../backend/services/wish/payment_info_model.dart';
import '../../controller/book_now/book_now_controller.dart';
import '../../controller/bottom_nav/dashboard_controller.dart';
import '../../utils/strings.dart';
import '../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';

class PayScreen extends StatelessWidget {
  PayScreen({super.key, required this.isBook});
  final bool isBook;
  final controller = Get.find<BookNowController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Obx(() => controller.isLoading ? const CustomLoadingAPI(): _bodyWidget()),
    );
  }

  _bodyWidget() {
    var model = controller.paymentInfoModel.data;
    var data = model.talent;

    double amount = isBook ? model.earning.amount: Get.find<DashboardController>().talentsModel.data.tips.amount;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            TitleHeading2Widget(
                text: data.name, fontWeight: FontWeight.bold),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            TitleHeading3Widget(
              text: "${data.category.name} / ${data.subcategory.name}",
              opacity: .5,
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .5),

            TitleHeading3Widget(
              textAlign: TextAlign.center,
                text:  Strings.selectPaymentMethod, fontWeight: FontWeight.bold),

            verticalSpace(Dimensions.paddingSizeVertical * .2),

            Obx(() => Row(
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
                    TitleHeading3Widget(text: Strings.creditCard, fontWeight: FontWeight.bold),
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
                    TitleHeading3Widget(text: Strings.mobilePayment, fontWeight: FontWeight.bold)
                  ],
                ),
              ],
            )),


            verticalSpace(Dimensions.paddingSizeVertical * .8),

            Visibility(
              visible: !isBook,
              child: PrimaryTextInputWidget(
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    if(value.isNotEmpty){
                      controller.tipsValue.value = double.parse(value);
                    }
                  },
                  controller: controller.tipsController, labelText: Strings.tip),
            ),
            // const Divider(),

            verticalSpace(Dimensions.paddingSizeVertical * .8),

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius),
                color: Theme.of(Get.context!).primaryColor.withOpacity(.2)
              ),
              child: Column(
                children: [


                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [

                      TitleHeading3Widget(
                          text: isBook ? Strings.book : Strings.tip, fontWeight: FontWeight.normal),

                      TitleHeading3Widget(
                          text: "€${isBook ? amount.toStringAsFixed(2) : controller.tipsValue.value.toStringAsFixed(2)}", fontWeight: FontWeight.bold),
                    ],
                  ),
                  verticalSpace(Dimensions.paddingSizeVertical * .1),

                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      TitleHeading3Widget(
                          text: Strings.serviceFee, fontWeight: FontWeight.normal),

                      TitleHeading3Widget(
                          text: "€${model.commission.toStringAsFixed(2)}", fontWeight: FontWeight.bold),
                    ],
                  ),
                ],
              ),
            ),

            Obx(() => controller.paymentType.value == "credit-card" ? const SizedBox.shrink(): Column(
              children: [
                verticalSpace(Dimensions.paddingSizeVertical * .8),

                Obx(() => CustomDropDown<PawapayCountry>(
                  items: controller.paymentInfoModel.data.pawapayCountries,
                  onChanged: (value) {
                    controller.selectedPawapayCountryDone.value = true;
                    controller.selectedPawapayCountry.value = value!;
                  },
                  hint: !controller.selectedPawapayCountryDone.value ? Strings.selectCountry: "${controller.selectedPawapayCountry.value.sim.first.country} (${controller.selectedPawapayCountry.value.sim.first.currency})",
                  title: Strings.selectCountry,
                )),
              ],
            )),



            verticalSpace(Dimensions.paddingSizeVertical * 1.5),
            Obx(() => controller.isPaymentLoading ? const CustomLoadingAPI(): PrimaryButton(
                title: Strings.pay,
                prefix: "💳",
                suffix: "€${((isBook ? amount : controller.tipsValue.value) + model.commission).toStringAsFixed(2)}",
                backgroundColor: CustomColor.secondaryLightColor,
                onPressed: (){
                  controller.payment(data.id.toString(), isBook ? "wish": "tips");
                }
            )),

            verticalSpace(Dimensions.paddingSizeVertical * 1),

          ],
        ),
      ),
    );
  }
}
