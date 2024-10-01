import '../../utils/basic_widget_imports.dart';
import 'bottom_nav_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

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
                  icon: Icons.mail_outline,
                  isSelected: selectedIndex == 0,
                  onTap: () => onItemTapped(0),
                ),
                BottomNavItem(
                  icon: Icons.dashboard_outlined,
                  isSelected: selectedIndex == 1,
                  onTap: () => onItemTapped(1),
                ),
                BottomNavItem(
                  icon: Icons.menu,
                  isSelected: selectedIndex == 2,
                  onTap: () => onItemTapped(2),
                ),
                BottomNavItem(
                  icon: Icons.energy_savings_leaf_outlined,
                  isSelected: selectedIndex == 3,
                  onTap: () => onItemTapped(3),
                ),
                BottomNavItem(
                  icon: Icons.person,
                  isSelected: selectedIndex == 4,
                  onTap: () => onItemTapped(4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}