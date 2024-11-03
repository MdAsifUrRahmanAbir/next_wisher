import 'package:next_wisher/utils/basic_screen_imports.dart';

import 'history_screen.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  EarningScreenState createState() => EarningScreenState();
}

class EarningScreenState extends State<EarningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: "Earnings",
        actions: [IconButton(onPressed: () {
          Get.to(const HistoryScreen());
        }, icon: const Icon(Icons.history))],
      ),
      body: _bodyWidget(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButton(
            title: "Request Payment",
            onPressed: () {},
            backgroundColor: CustomColor.redColor),
      ),
    );
  }

  _bodyWidget() {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              EarningCardWidget(
                  revenueAmount: 67.5,
                  title: "Revenue",
                  color: Colors.green[400]!),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              EarningCardWidget(
                  revenueAmount: 0,
                  title: "Pending",
                  color: Colors.orange[400]!),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              EarningCardWidget(
                  revenueAmount: 0, title: "Paid", color: Colors.purple[400]!),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              const EarningCardWidget(
                  revenueAmount: 67.5, title: "Balance", color: Colors.black),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              EarningCardWidget(
                  revenueAmount: 37.5,
                  title: "Wishes",
                  value: "1",
                  color: Colors.red[400]!),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              EarningCardWidget(
                  value: "2",
                  revenueAmount: 30,
                  title: "Tips",
                  color: Colors.blue[400]!),
              verticalSpace(Dimensions.paddingSizeVertical * .8),

            ],
          )),
    );
  }
}

class EarningCardWidget extends StatelessWidget {
  final double revenueAmount;
  final String title, value;
  final Color color;

  const EarningCardWidget(
      {super.key,
      required this.revenueAmount,
      required this.title,
      required this.color,
      this.value = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 150, // Adjust the width as needed
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(.5),
            blurRadius: 1,
            spreadRadius: .1,
          )
        ],
        borderRadius: BorderRadius.circular(Dimensions.radius * .8),
        color: color,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeVertical * .4,
                horizontal: Dimensions.paddingSizeHorizontal),
            child: Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                const SizedBox(),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value.isNotEmpty
                    ? Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
            ),
            child: Text(
              '€${revenueAmount.toStringAsFixed(1)}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
