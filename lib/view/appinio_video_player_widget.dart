

import 'package:appinio_video_player/appinio_video_player.dart';

import '../utils/basic_screen_imports.dart';

class AppionioVideoPlayerWidget extends StatefulWidget {
  const AppionioVideoPlayerWidget({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<AppionioVideoPlayerWidget> createState() => _AppionioVideoPlayerWidgetState();
}

class _AppionioVideoPlayerWidgetState extends State<AppionioVideoPlayerWidget> {

  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  // String videoUrl =
  //     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
    setState(() {

    });
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController
      ),
    );
  }
}