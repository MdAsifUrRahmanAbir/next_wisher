import 'package:chewie/chewie.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:next_wisher/widgets/appbar/back_button.dart';
import 'package:video_player/video_player.dart';

import '../../utils/basic_screen_imports.dart';

class VideoShowScreen extends StatefulWidget {
  const VideoShowScreen({super.key, required this.url});

  final String url;

  @override
  State<VideoShowScreen> createState() => _VideoShowScreenState();
}

class _VideoShowScreenState extends State<VideoShowScreen> {
  RxBool loading = true.obs;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const PrimaryAppBar(
      //
      // ),
      body: Obx(() => loading.value
          ? const CustomLoadingAPI()
          : Stack(
              children: [
                Container(
                  // height: MediaQuery.sizeOf(context).height * .3,
                  color: Theme.of(context).primaryColor.withOpacity(.6),
                  child: Chewie(
                    controller: chewieController,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: BackButtonWidget(onTap: () {
                    Navigator.pop(context);
                  }),
                )
              ],
            )),
    );
  }

  void _initVideo() {
      loading.value = true;

    videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.url)
        // Uri.parse("https://next-wisher.skyflightbd.com/public/uploads/1730566102.mp4"),
        )
      ..initialize();

    chewieController = ChewieController(
      // aspectRatio: 1,
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
    );

      loading.value = false;
  }
}
