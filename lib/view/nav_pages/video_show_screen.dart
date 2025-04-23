import 'package:flutter/material.dart';
import 'package:next_wisher/widgets/tiktok_style_video_widget.dart';

class VideoShowScreen extends StatefulWidget {
  const VideoShowScreen({super.key, required this.url});

  final String url;

  @override
  State<VideoShowScreen> createState() => _VideoShowScreenState();
}

class _VideoShowScreenState extends State<VideoShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: TikTokStyleVideoWidget(
          videoUrl: widget.url,
          thumbnailUrl: "https://placehold.co/600x400/000000/FFFFFF/png?text=Video",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          borderRadius: BorderRadius.zero,
          showFullscreenOption: false,
        ),
      ),
    );
  }
}
