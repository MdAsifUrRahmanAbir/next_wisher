
import '../../utils/basic_widget_imports.dart';

class CustomRadioSelectWidget extends StatefulWidget {
  const CustomRadioSelectWidget({super.key, required this.list, required this.onChanged, required this.title});
  
  final List<String> list;
  final ValueChanged onChanged;
  final String title;

  @override
  State<CustomRadioSelectWidget> createState() => _CustomRadioSelectWidgetState();
}

class _CustomRadioSelectWidgetState extends State<CustomRadioSelectWidget> {
  late String _selectedProperty;

  @override
  void initState() {
    _selectedProperty = widget.list.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: crossStart,
      children: [
        TitleHeading4Widget(
          text: widget.title,
          fontWeight: FontWeight.w600,
        ),
        horizontalSpace(Dimensions.widthSize * 0.5),
        Wrap(
          spacing: 10.0, // Horizontal space between radio buttons
          runSpacing: 10.0, // Vertical space between radio buttons
          children: widget.list.map((String property) {
            return ChoiceChip(
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              label: Text(property),
              selected: _selectedProperty == property,
              onSelected: (bool selected) {
                setState(() {
                  _selectedProperty = property;
                  widget.onChanged(property);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
