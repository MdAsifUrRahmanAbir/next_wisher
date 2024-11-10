import '../../../backend/services/dashboard/home_model.dart';
import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../utils/basic_screen_imports.dart';

class FeaturedVideosScreen extends StatelessWidget {
   FeaturedVideosScreen({super.key});
  final controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: .65,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15),
          itemBuilder: (context, index) {
            FeaturedVideo data = controller.homeModel.data.featuredVideos[index];
            return GestureDetector(
              onTap: () {
                // Get.to(const TalentProfile());
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(data.thumbnail),
                        fit: BoxFit.cover),
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                    BorderRadius.circular(Dimensions.radius * .4)),
              ),
            );
          },
          itemCount: controller.homeModel.data.featuredVideos.length,
        ),
      ),
    );
  }
}