import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../controller/book_now/book_now_controller.dart';
import '../../utils/strings.dart';

class PayScreen extends StatelessWidget {
  PayScreen({super.key, required this.isBook});
  final bool isBook;
  final controller = Get.find<BookNowController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    var data = controller.paymentInfoModel.data.talent;
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

                      const TitleHeading3Widget(
                          text: "€20", fontWeight: FontWeight.bold),
                    ],
                  ),
                  verticalSpace(Dimensions.paddingSizeVertical * .1),

                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      TitleHeading3Widget(
                          text: Strings.serviceFee, fontWeight: FontWeight.normal),

                      const TitleHeading3Widget(
                          text: "€2.5", fontWeight: FontWeight.bold),
                    ],
                  ),
                ],
              ),
            ),

            verticalSpace(Dimensions.paddingSizeVertical * 1.5),
            PrimaryButton(
                title: Strings.pay,
                prefix: "💳",
                suffix: "€22.5",
                backgroundColor: CustomColor.secondaryLightColor,
                onPressed: controller.payment
            ),

            verticalSpace(Dimensions.paddingSizeVertical * 1),

          ],
        ),
      ),
    );
  }
}
