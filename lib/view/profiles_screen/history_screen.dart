
import '../../controller/profile/earning_controller.dart';
import '../../utils/basic_screen_imports.dart';
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
      appBar: const PrimaryAppBar(title: "History"),
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
            _filterWidget(context),
            verticalSpace(Dimensions.paddingSizeVertical * .4),
            _historyWidget(context),
          ],
        ),
      ),
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

  _historyWidget(BuildContext context){
    return Expanded(
      child: ListView.separated(shrinkWrap: true, itemBuilder: (context, index){
        return Column(
          children: [
            ListTile(
              leading: Container(
                // padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
                child: const Column(
                  children: [
                    TitleHeading2Widget(text: "12", color: CustomColor.whiteColor),
                    TitleHeading5Widget(text: "09/2024", color: CustomColor.whiteColor),
                  ],
                ),
              ),
              title: const TitleHeading3Widget(text: "ID 0000219"),
              subtitle: const TitleHeading5Widget(text: "Mobile / Orange"),
              trailing: const TitleHeading4Widget(text: "€30"),
            )
          ],
        );
      }, separatorBuilder: (_,i) => verticalSpace(5), itemCount: 8),
    );
  }
}
