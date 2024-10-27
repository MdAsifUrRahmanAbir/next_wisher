import 'package:flutter_rating/flutter_rating.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../utils/strings.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';
import '../book_now/book_now_screen.dart';
import '../book_now/pay_screen.dart';

class TalentProfile extends StatelessWidget {
  const TalentProfile({super.key});

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
            StarRating(
              mainAxisAlignment: mainStart,
              rating: 0,
              allowHalfRating: false,
              onRatingChanged: (rating) {},
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            const TitleHeading3Widget(
                text: "Biography", fontWeight: FontWeight.bold),
            verticalSpace(Dimensions.paddingSizeVertical * .2),
            const TitleHeading4Widget(
                text:
                    "Prezydent Veskaye est un humoriste de l’espace francophone toujours prêt à vous distiller de la bonne humeur.",
                fontWeight: FontWeight.bold),
            verticalSpace(Dimensions.paddingSizeVertical * .5),
            Image.network(
              "https://www.shutterstock.com/image-photo/full-body-little-small-fun-600nw-2110549943.jpg",
              fit: BoxFit.fill,
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .5),
            const TitleHeading3Widget(text: "Personalized video"),
            verticalSpace(Dimensions.paddingSizeVertical * .5),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal,
                vertical: Dimensions.paddingSizeVertical,
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(Dimensions.radius)),
              child: Column(
                children: [
                  const TitleHeading4Widget(
                      opacity: .8,
                      text:
                          "Book me for a personalized video for any occasion and let's make it memorable. "),
                  verticalSpace(Dimensions.paddingSizeVertical * .1),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeHorizontal,
                        vertical: Dimensions.paddingSizeVertical * .4),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius * 2),
                        color: Theme.of(context).primaryColor),
                    child: const TitleHeading4Widget(text: "€50", color: CustomColor.whiteColor),
                  )
                ],
              ),
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .5),
            PrimaryButton(title: Strings.book, onPressed: () {
              Get.to(const BookNowScreen());
            }),
            verticalSpace(Dimensions.paddingSizeVertical * .5),
            PrimaryButton(
                title: Strings.sendTip,
                backgroundColor: CustomColor.secondaryLightColor,
                onPressed: () {
                  Get.to(const PayScreen(isBook: false));
                }),
            verticalSpace(Dimensions.paddingSizeVertical * .5),

            Card(
              color: CustomColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    verticalSpace(Dimensions.paddingSizeVertical * .2),
                    Row(
                      children: [
                        const Icon(Icons.check_box_outlined, color: Colors.green),
                        horizontalSpace(Dimensions.paddingSizeHorizontal * .4),
                        TitleHeading4Widget(text: Strings.moneyBackGuarantee, fontWeight: FontWeight.bold),
                      ],
                    ),

                    verticalSpace(Dimensions.paddingSizeVertical * .2),

                    TitleHeading5Widget(text: Strings.moneyBackGuaranteeDetails),
                    verticalSpace(Dimensions.paddingSizeVertical * .2),

                    // Row(
                    //   children: [
                    //
                    //   ],
                    // )
                  ],
                ),
              ),
            ),

            verticalSpace(Dimensions.paddingSizeVertical * 1),

          ],
        ),
      ),
    );
  }
}
