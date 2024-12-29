// For File handling
import 'package:flutter/material.dart';
import 'package:next_wisher/backend/utils/custom_loading_api.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoWidget extends StatefulWidget {
  final dynamic videoUrl; // URL of the network video (nullable)
  // final File? videoFile;  // File for local video (nullable)

  const VideoWidget({super.key, required this.videoUrl});

  @override
  VideoWidgetState createState() => VideoWidgetState();
}

class VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    // Initialize the appropriate VideoPlayerController
    if (widget.videoUrl is String) {
      // Network video
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!));
    } else {
      // File-based video
      _videoPlayerController = VideoPlayerController.file(widget.videoUrl);
    }

    // Initialize ChewieController with additional options
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false, // Auto-play the video
      looping: false, // Disable looping by default
      placeholder: CustomLoadingAPI(),
      errorBuilder: (context, url) => Icon(Icons.error),

      allowFullScreen: true,
      zoomAndPan: false,
      fullScreenByDefault: true,
      aspectRatio: 16 / 9, // Adjust the aspect ratio
    );

    setState(() {

    });
  }

  @override
  void dispose() {
    // Dispose of controllers when no longer needed
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null
        ? Chewie(controller: _chewieController!)
        : const CustomLoadingAPI(); // Show loader while initializing
  }
}