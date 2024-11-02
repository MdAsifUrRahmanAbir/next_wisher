import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../utils/strings.dart';
import 'pay_screen.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({super.key});

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  String _selectedOption = "myself";
  String? _selectedGender;

  final nameController = TextEditingController();
  final fromController = TextEditingController();
  final forController = TextEditingController();
  final occasionController = TextEditingController();
  final instructionsController = TextEditingController();


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

            Row(
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: "myself",

                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    const TitleHeading3Widget(text: "Myself", fontWeight: FontWeight.bold),
                  ],
                ),

                horizontalSpace(Dimensions.paddingSizeHorizontal * .5),
                Row(
                  children: [
                    Radio<String>(
                      value: "else",
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    const TitleHeading3Widget(text: "Someone Else", fontWeight: FontWeight.bold)
                  ],
                ), 
              ],
            ),

            verticalSpace(Dimensions.paddingSizeVertical * .5),

            Visibility(
              visible: _selectedOption == "else",
              child: Column(
                children: [
                  PrimaryTextInputWidget(controller: fromController, labelText: Strings.from, hint: Strings.enterName),
                  verticalSpace(Dimensions.paddingSizeVertical * .5),
                  PrimaryTextInputWidget(controller: forController, labelText: Strings.forText, hint: Strings.enterName),
                ],
              ),
            ),

            Visibility(
                visible: _selectedOption == "myself",
                child: PrimaryTextInputWidget(controller: nameController, labelText: Strings.name, hint: Strings.enterName)),

            verticalSpace(Dimensions.paddingSizeVertical * .5),

            TitleHeading3Widget(text: Strings.gender, fontWeight: FontWeight.bold),

            Row(
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: "Female",
                      groupValue: _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    const TitleHeading3Widget(text: "Female", fontWeight: FontWeight.bold),
                  ],
                ),

                horizontalSpace(Dimensions.paddingSizeHorizontal * .5),
                Row(
                  children: [
                    Radio<String>(
                      value: "Male",
                      groupValue: _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    const TitleHeading3Widget(text: "Male", fontWeight: FontWeight.bold)
                  ],
                ),
              ],
            ),

            verticalSpace(Dimensions.paddingSizeVertical * .5),

            PrimaryTextInputWidget(controller: occasionController, labelText: "Occasion", hint: ""),


            verticalSpace(Dimensions.paddingSizeVertical * .5),

            PrimaryTextInputWidget(controller: instructionsController, labelText: "Instruction", hint: "", maxLine: 3,),


            verticalSpace(Dimensions.paddingSizeVertical * 1.5),
            PrimaryButton(
                title: Strings.continueToPayment,
                backgroundColor: CustomColor.redColor    ,
                onPressed: () {
                  Get.to(const PayScreen(isBook: true));
                }),

            verticalSpace(Dimensions.paddingSizeVertical * 1),

          ],
        ),
      ),
    );
  }
}
