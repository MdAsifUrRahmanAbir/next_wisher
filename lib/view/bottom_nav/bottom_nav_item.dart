import '../../controller/bottom_nav/dashboard_controller.dart';
import '../../utils/basic_widget_imports.dart';

class BottomNavItem extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final bool isSelected;
  final bool isMain;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    this.icon,
    required this.isSelected,
    required this.onTap,
    this.text,
    required this.isMain,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(!isMain){
          Get.find<DashboardController>().searchController.clear();
          Get.find<DashboardController>().talentList.value =
              Get.find<DashboardController>().homeModel.data.homeTalents;
          Navigator.pop(context);
        }
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon == null
                ? TitleHeading3Widget(
                    text: text ?? "",
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .color!
                            .withValues(alpha: .5),
                  )
                : Icon(
                    icon,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .color!
                            .withValues(alpha: .5),
                  ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4.0),
                width: 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
