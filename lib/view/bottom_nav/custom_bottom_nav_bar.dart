import '../../utils/basic_widget_imports.dart';
import '../profiles_screen/guidline_screen.dart';
import 'bottom_nav_item.dart';
import 'language_selection_bottom_sheet.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {

  String _selectedLanguage = "English"; // Default language

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LanguageSelectionBottomSheet(
          selectedLanguage: _selectedLanguage,
          onLanguageSelected: (String language) {
            setState(() {
              _selectedLanguage = language;
            });
            Navigator.pop(context); // Close the bottom sheet
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      elevation: 10,
      color: CustomColor.whiteColor,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const Divider(height: 1),
          verticalSpace(5),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Dimensions.radius),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                BottomNavItem(
                  icon: Icons.dashboard_outlined,
                  isSelected: widget.selectedIndex == 0,
                  onTap: () => widget.onItemTapped(0),
                ),
                BottomNavItem(
                  text: "EN",
                  isSelected: widget.selectedIndex == 1,
                  onTap: _showLanguageBottomSheet,
                ),
                BottomNavItem(
                  icon: Icons.menu,
                  isSelected: widget.selectedIndex == 2,
                  onTap: (){
                    Get.to(const GuidelineScreen());
                  },
                ),
                BottomNavItem(
                  icon: Icons.mail_outline,
                  isSelected: widget.selectedIndex == 3,
                  onTap: () => widget.onItemTapped(3),
                ),
                BottomNavItem(
                  icon: Icons.person,
                  isSelected: widget.selectedIndex == 4,
                  onTap: () => widget.onItemTapped(4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}