import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../backend/services/dashboard/home_model.dart';
import '../../../controller/bottom_nav/dashboard_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/strings.dart';
import '../../../widgets/tiktok_style_video_widget.dart';
import '../../web_video_widget.dart';

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
              return SizedBox(
                width: MediaQuery.sizeOf(context).height * .2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radius * .4),
                  child: Stack(
                    children: [
                      // TikTok style video widget - plays inline
                      TikTokStyleVideoWidget(
                        videoUrl: data.path,
                        thumbnailUrl: data.thumbnail,
                        width: MediaQuery.sizeOf(context).height * .2,
                        height: double.infinity,
                        borderRadius: BorderRadius.circular(Dimensions.radius * .4),
                      ),
                    ],
                  ),
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