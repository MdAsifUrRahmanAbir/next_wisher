import '../../backend/services/earning/earning_model.dart';
import '../../controller/profile/earning_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/strings.dart';
import '../../widgets/text_labels/title_heading5_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  final controller = Get.find<EarningController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title:  Strings.history),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _filterWidget(context),
            verticalSpace(Dimensions.paddingSizeVertical * .4),
            _historyWidget(context),
          ],
        ),
      ),
    );
  }

  _historyWidget(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            PaymentRequest data =
                controller.earningModel.data.paymentRequests[index];
            debugPrint("Amount:: ${data.amount.toStringAsFixed(2)}   >>   ${data.status}");
            return Column(
              children: [
                ListTile(
                  // onTap: () {
                  //   controller.selectedIndex.value = index;
                  // },
                  leading: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                    child: Column(
                      children: [
                        TitleHeading2Widget(
                            text: data.createdAt.day.toString(),
                            color: CustomColor.whiteColor),
                        TitleHeading5Widget(
                            text:
                                "${data.createdAt.month.toString()}/${data.createdAt.year.toString().substring(2)}",
                            color: CustomColor.whiteColor),
                      ],
                    ),
                  ),
                  title: TitleHeading3Widget(text: "ID ${data.invoice}"),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: crossStart,
                          children: [
                            data.stripeEmail.isEmpty
                                ? const SizedBox.shrink()
                                : TitleHeading5Widget(text: data.stripeEmail),
                            Row(
                              children: [
                                TitleHeading5Widget(text: data.bankType),
                                TitleHeading5Widget(text: " / "),
                                TitleHeading5Widget(text: data.bankType),

                              ],
                            ),
                          ],
                        ),
                      ),
                      data.stripeEmail.isEmpty
                          ? InkWell(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius * 4),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      BankInfoDialog(data: data),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.remove_red_eye),
                              ))
                          : const SizedBox.shrink()
                    ],
                  ),
                  trailing: Column(
                    children: [
                      TitleHeading4Widget(
                          text: "€${data.amount.toStringAsFixed(2)}"),
                      verticalSpace(3),
                      TitleHeading4Widget(
                          text: data.status == 1 ? Strings.accepted: data.status == 0 ? "Pending": Strings.declined,
                        color: data.status == 1 ? Colors.green : data.status == 0 ? Colors.orange: Colors.red,
                      ),
                    ]
                  )
                ),
                Obx(() => Visibility(
                    visible: controller.selectedIndex.value == index,
                    child: const Column(
                      children: [],
                    ))),
                Divider(),
              ],
            );
          },
          separatorBuilder: (_, i) => verticalSpace(5),
          itemCount: controller.earningModel.data.paymentRequests.length),
    );
  }
}

class BankInfoDialog extends StatelessWidget {
  const BankInfoDialog({super.key, required this.data});

  final PaymentRequest data;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Bank info", style: TextStyle(fontSize: 18)),
          GestureDetector(
            onTap: () => Navigator.pop(context), // Close the dialog
            child: const Icon(Icons.close, color: Colors.red),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(label: "Area:", value: data.bankInfo.area),
          const SizedBox(height: 8),
          InfoRow(label: "Account holder name:", value: data.bankInfo.fullName),
          const SizedBox(height: 8),
          InfoRow(label: "SWIFT / BIC CODE:", value: data.bankInfo.swift),
          const SizedBox(height: 8),
          InfoRow(label: "Account number:", value: data.bankInfo.swift),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: mainStart,
      children: [
        TitleHeading4Widget(
          text: label,
            fontWeight: FontWeight.bold
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TitleHeading4Widget(
            text: value,
            textAlign: TextAlign.end,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
