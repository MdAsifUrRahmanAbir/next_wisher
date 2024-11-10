

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
          childAspectRatio: .9,
          mainAxisSpacing: 5,
          crossAxisSpacing: 12),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: const DecorationImage(fit: BoxFit.fill, image: NetworkImage("https://www.shutterstock.com/image-photo/full-body-little-small-fun-600nw-2110549943.jpg")),
                    borderRadius:
                    BorderRadius.circular(Dimensions.radius * 2)),
              ),
            ),
            verticalSpace(2),
            TitleHeading4Widget(
                text: controller.homeModel.data.categoriesWithChild[index].name,
                fontWeight: FontWeight.bold)
          ],
        );
      },
      itemCount: controller.homeModel.data.categoriesWithChild.length,
    );
  }
}
