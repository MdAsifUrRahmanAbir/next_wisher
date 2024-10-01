
import '../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';

class DropDownUseModel extends DropdownModel {
  @override
  final String title;

  DropDownUseModel(this.title);
}

List<DropDownUseModel> areYouData = [
  DropDownUseModel("Tenant"),
  DropDownUseModel("Landlord"),
  DropDownUseModel("Property Manager"),
];

List<DropDownUseModel> selectService = [
  DropDownUseModel("Linen hire only"),
  DropDownUseModel("Cleaning + Linen hire"),
];

List<DropDownUseModel> propertyType = [
  DropDownUseModel("Studio flat"),
  DropDownUseModel("1 bed (flat)"),
  DropDownUseModel("1 bed (house)"),
  DropDownUseModel("2 bed 1bath (flat)"),
  DropDownUseModel("2 bed 1bath (house)"),
  DropDownUseModel("2 bed 2 bath (flat)"),
  DropDownUseModel("2 bed 2 bath (house)"),
  DropDownUseModel("3 bed 1 bath (flat)"),
  DropDownUseModel("3 bed 1 bath (house)"),
  DropDownUseModel("3 bed 2 bath (flat)"),
  DropDownUseModel("3 bed 2 bath (house)")
];

List<DropDownUseModel> propertyAccess = [
  DropDownUseModel("Keynest/Keysafe"),
  DropDownUseModel("Lock Box/Digital Lock"),
  DropDownUseModel("Concierge/Porter"),
  DropDownUseModel("Someone on site")
];

List<String> numberOfProperties = ["1", "2-5", "5-10", "10-20", "20-50", "50+"];

List<String> require = [
  "2",
  "3-5",
  "5-10",
  "10+",
];
