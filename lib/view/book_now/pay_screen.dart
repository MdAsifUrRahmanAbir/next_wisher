import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../utils/strings.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key, required this.isBook});

  final bool isBook;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const TitleHeading2Widget(
                text: "PREZYDENT VESKAYE", fontWeight: FontWeight.bold),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            const TitleHeading3Widget(
              text: "Actors / Comedian",
              opacity: .5,
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .5),

            TitleHeading3Widget(
              textAlign: TextAlign.center,
                text: isBook ? "Book" : "Tip", fontWeight: FontWeight.bold),

            verticalSpace(Dimensions.paddingSizeVertical * .2),

            Row(
              mainAxisAlignment: mainSpaceBet,
              children: const [
                TitleHeading3Widget(
                    text: "Tip", fontWeight: FontWeight.normal),

                TitleHeading3Widget(
                    text: "€20", fontWeight: FontWeight.bold),
              ],
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .1),

            Row(
              mainAxisAlignment: mainSpaceBet,
              children: const [
                TitleHeading3Widget(
                    text: "Service Fee", fontWeight: FontWeight.normal),

                TitleHeading3Widget(
                    text: "€2.5", fontWeight: FontWeight.bold),
              ],
            ),

            verticalSpace(Dimensions.paddingSizeVertical * 1.5),
            PrimaryButton(
                title: Strings.pay,
                prefix: "💳",
                suffix: "€22.5",
                backgroundColor: CustomColor.secondaryLightColor,
                onPressed: () {}),

            verticalSpace(Dimensions.paddingSizeVertical * 1),

          ],
        ),
      ),
    );
  }
}
