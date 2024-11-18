import '../../../backend/services/dashboard/home_model.dart';
import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';
import '../video_show_screen.dart';
import 'featured_videos_screen.dart';

class FeaturedVideosWidget extends StatelessWidget {
  const FeaturedVideosWidget({super.key, required this.controller});
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            TitleHeading3Widget(
                text: Strings.featuredVideos, padding: const EdgeInsets.all(2)),

          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .3,
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              FeaturedVideo data = controller.homeModel.data.featuredVideos[index];
              return GestureDetector(
                onTap: () {
                  Get.to(VideoShowScreen(url: data.path));
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).height * .2,
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
            separatorBuilder: (BuildContext context, int index) {
              return horizontalSpace(5);
            },
          ),
        ),
      ],
    );
  }
}