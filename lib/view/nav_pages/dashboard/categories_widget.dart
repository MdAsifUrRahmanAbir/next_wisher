

import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../utils/basic_screen_imports.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.controller});
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate:
      const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 140,
          childAspectRatio: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:
              BorderRadius.circular(Dimensions.radius * 2)),
          child: Column(
            mainAxisAlignment: mainCenter,
            children: [
              Icon(controller.category[index]["icon"],
                  shadows: const [
                    Shadow(
                        blurRadius: 2,
                        offset: Offset(1, 1),
                        color: CustomColor.whiteColor)
                  ],
                  size: 28,
                  color: CustomColor.whiteColor),
              verticalSpace(2),
              TitleHeading4Widget(
                  text: controller.category[index]["name"],
                  fontWeight: FontWeight.bold,
                  color: CustomColor.whiteColor)
            ],
          ),
        );
      },
      itemCount: controller.category.length,
    );
  }
}
