import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/utils/basic_screen_imports.dart';

import '../../controller/profile/earning_controller.dart';
import '../../routes/routes.dart';
import '../../utils/strings.dart';
import 'history_screen.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  EarningScreenState createState() => EarningScreenState();
}

class EarningScreenState extends State<EarningScreen> {
  final controller = Get.put(EarningController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.historyScreen);
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: Obx(() =>
          controller.isLoading ? const CustomLoadingAPI() : _bodyWidget()),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal,
          vertical: Dimensions.paddingSizeVertical * .2
        ),
        child: PrimaryButton(
            title: Strings.requestPayment,
            onPressed: () {
              Get.toNamed(Routes.paymentScreen);
            },
            backgroundColor: CustomColor.redColor),
      ),
    );
  }

  _bodyWidget() {
    var data = controller.earningModel.data;
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.only(
            top: Dimensions.paddingSizeVertical * .5,
            left: Dimensions.paddingSizeHorizontal * .5,
            right: Dimensions.paddingSizeHorizontal * .5,
            bottom: Dimensions.paddingSizeVertical * .1,
          ),
          child: ListView(
            children: [
              EarningCardWidget(
                  revenueAmount: data.revenue,
                  title: "Revenue",
                  color: Colors.green[400]!),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              EarningCardWidget(
                  revenueAmount: data.pending,
                  title: "Pending",
                  color: Colors.orange[400]!),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              EarningCardWidget(
                  revenueAmount: data.paid,
                  title: "Paid",
                  color: Colors.purple[400]!),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              EarningCardWidget(
                  revenueAmount: data.balance, title: "Balance", color: Colors.black),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              _filterWidget(context),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              EarningCardWidget(
                  revenueAmount: data.wishAmount,
                  title: "Wishes",
                  value: data.wishCount.toString(),
                  color: Colors.red[400]!),
              verticalSpace(Dimensions.paddingSizeVertical * .4),
              EarningCardWidget(
                  value: data.tipsCount.toString(),
                  revenueAmount: data.tipsAmount,
                  title: "Tips",
                  color: Colors.blue[400]!),
              verticalSpace(Dimensions.paddingSizeVertical * .8),
            ],
          )),
    );
  }



  _filterWidget(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: crossStart,
      children: [
        const Text('Start Date'),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => controller.selectDate(context, true),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.startDateSelect.value
                      ? controller.formatDate(controller.startDate.value)
                      : 'Select start date',
                  style: const TextStyle(color: Colors.black),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('End Date'),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => controller.selectDate(context, false),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.endDateSelect.value ? controller.formatDate(controller.endDate.value) : 'Select end date',
                  style: const TextStyle(color: Colors.black),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Filter'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: controller.selectedFilter.value,
          onChanged: (String? newValue) {
            setState(() {
              controller.selectedFilter.value = newValue!;
            });
          },
          items: controller.filterOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    ));
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
