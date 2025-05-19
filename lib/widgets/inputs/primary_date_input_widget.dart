import '../../utils/basic_widget_imports.dart';
import 'package:intl/intl.dart';

import '../../utils/strings.dart';

class PrimaryDateInputWidget extends StatefulWidget {
  final String labelText, optional;
  final bool? readOnly;
  final Function(DateTime) onChanged;
  final DateTime? initialDate;
  final Color color;

  const PrimaryDateInputWidget({
    super.key,
    required this.labelText,
    this.readOnly = false,
    this.optional = "",
    this.color = Colors.transparent,
    required this.onChanged,
    this.initialDate,
  });

  @override
  State<PrimaryDateInputWidget> createState() => _PrimaryDateInputWidgetState();
}

class _PrimaryDateInputWidgetState extends State<PrimaryDateInputWidget> {
  DateTime? _selectedDate;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    debugPrint("✔️✍️ PrimaryDateInput -> initialDate: ${widget.initialDate} ✉");
    if(widget.initialDate == null) {
      controller.text = Strings.selectDate;
      _selectedDate = DateTime.now();
    }
    else{
      _selectedDate = widget.initialDate;
      controller.text = _filterDateOnly(widget.initialDate!);
    }
  }

  String _filterDateOnly(DateTime value){
    return DateFormat('dd-MM-yyyy').format(value);
  }

  List<DateTime> disabledDates = [
    DateTime(2024, 9, 25),
    DateTime(2024, 9, 26),
    DateTime(2024, 9, 27),
  ];

  DateTime? checkSelectedDate(DateTime selectedDate, List<DateTime> disabledDates) {
    // Check if selectedDate is in the disabledDates list
    bool isDisabled = disabledDates.any((disabledDate) =>
    selectedDate.year == disabledDate.year &&
        selectedDate.month == disabledDate.month &&
        selectedDate.day == disabledDate.day);

    // Return null if the date is disabled, otherwise return the selected date
    return isDisabled ? null : selectedDate;
  }

  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: checkSelectedDate(_selectedDate!, disabledDates),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      // Here you define the predicate to disable specific dates
      selectableDayPredicate: (DateTime date) {
        // Disable the dates in the disabledDates list
        return !disabledDates.contains(DateTime(date.year, date.month, date.day));
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.text = _filterDateOnly(picked);
        widget.onChanged(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleHeading4Widget(
              text: widget.labelText,
              fontWeight: FontWeight.w600,
            ),
            horizontalSpace(Dimensions.widthSize * 0.5),
            Visibility(
              visible: widget.optional.isNotEmpty,
              child: TitleHeading4Widget(
                text: widget.optional,
                opacity: .4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox * 1),
        TextFormField(
          autofocus: widget.initialDate != null,
          cursorColor: Theme.of(context).primaryColor,
          style: CustomStyle.lightHeading4TextStyle
              .copyWith(color: Theme.of(context).primaryColor),
          readOnly: true,
          onTap: () {
            _selectDate(context);
          },
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            filled: true,
            fillColor: widget.color,
            contentPadding:
                const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
            hintText: "",
            hintStyle: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle.copyWith(
                    color: CustomColor.primaryDarkTextColor.withValues(alpha: 0.2),
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.headingTextSize3,
                  )
                : CustomStyle.lightHeading3TextStyle.copyWith(
                    color: CustomColor.primaryLightTextColor.withValues(alpha: 0.2),
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.headingTextSize3,
                  ),
            // suffixIcon: suffixIcon,
            // prefixIcon: prefixIcon,
          ),
        )
      ],
    );
  }
}
