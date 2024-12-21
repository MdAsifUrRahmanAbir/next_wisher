

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
        return GestureDetector(
          onTap: (){
            controller.categoryModelProcess(controller.categoriesList[index].slug, controller.categoriesList[index].name);
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      image: DecorationImage(fit: BoxFit.cover, image: AssetImage(controller.category[index]["icon"]), alignment: Alignment.topCenter),
                      borderRadius:
                      BorderRadius.circular(Dimensions.radius * 2)),
                ),
              ),
              verticalSpace(2),
              TitleHeading4Widget(
                  text: controller.categoriesList[index].name,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold)
            ],
          ),
        );
      },
      itemCount: controller.categoriesList.length,
    );
  }
}
