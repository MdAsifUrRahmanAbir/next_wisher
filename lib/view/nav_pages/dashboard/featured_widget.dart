

import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../talent_profile/talent_profile.dart';

class FeaturedWidget extends StatelessWidget {
  const FeaturedWidget({super.key, required this.controller});
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleHeading3Widget(text: "Featured",padding: EdgeInsets.all(2)),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate:
          const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: .65,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Get.to(TalentProfile());
              },
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                  "https://www.shutterstock.com/image-photo/full-body-little-small-fun-600nw-2110549943.jpg"
                              ),
                              fit: BoxFit.cover
                          ),
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius * .4)),
                    ),
                  ),
                  const TitleHeading3Widget(text: "Guehi Veh"),
                  const TitleHeading3Widget(text: "\$50", fontWeight: FontWeight.bold),
                ],
              ),
            );
          },
          itemCount: controller.category.length,
        ),
      ],
    );
  }
}
