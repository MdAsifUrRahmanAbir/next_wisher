import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../backend/utils/custom_loading_api.dart';

class InlineVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final bool autoPlay;
  final bool fullScreenByDefault;

  const InlineVideoPlayer({
    Key? key, 
    required this.videoUrl,
    required this.thumbnailUrl,
    this.autoPlay = false,
    this.fullScreenByDefault = false,
  }) : super(key: key);

  @override
  State<InlineVideoPlayer> createState() => _InlineVideoPlayerState();
}

class _InlineVideoPlayerState extends State<InlineVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVideoInitialized = false;
  bool _isPlaying = false;
  bool _showThumbnail = true;

  @override
  void initState() {
    super.initState();
    // Defer initialization to reduce buffer consumption
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeVideo();
    });
  }

  void _initializeVideo() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      // Add listeners before initializing to catch early events
      _videoPlayerController!.addListener(_videoPlayerListener);

      // Initialize with a timeout to prevent hanging
      await _videoPlayerController!.initialize().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // On timeout, we'll still show the thumbnail
          debugPrint("Video initialization timed out: ${widget.videoUrl}");
          return;
        },
      );

      if (mounted) {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: widget.autoPlay,
          looping: false,
          showControls: true,
          aspectRatio: _videoPlayerController!.value.aspectRatio,
          allowFullScreen: false, // Disable full screen to prevent more buffer issues
          fullScreenByDefault: false,
          placeholder: Container(
            color: Colors.black,
            child: const Center(child: CustomLoadingAPI()),
          ),
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );

        setState(() {
          _isVideoInitialized = true;
        });
      }
    } catch (e) {
      debugPrint("Error initializing video: $e");
    }
  }

  void _videoPlayerListener() {
    if (_videoPlayerController != null) {
      final isPlaying = _videoPlayerController!.value.isPlaying;
      
      if (_isPlaying != isPlaying && mounted) {
        setState(() {
          _isPlaying = isPlaying;
          if (_isPlaying) {
            _showThumbnail = false;
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.removeListener(_videoPlayerListener);
    _videoPlayerController?.pause();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVideoInitialized || _showThumbnail) {
      return GestureDetector(
        onTap: () {
          if (_isVideoInitialized) {
            setState(() {
              _showThumbnail = false;
              _videoPlayerController?.play();
            });
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Show thumbnail
            widget.thumbnailUrl.isNotEmpty
                ? Image.network(
                    widget.thumbnailUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.black,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.white,
                          size: 50,
                        ),
                      );
                    },
                  )
                : Container(color: Colors.black),
                
            // Show play button
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ),
            
            // Show loading indicator if initializing
            if (!_isVideoInitialized)
              const Positioned(
                bottom: 10,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // The video player
        _chewieController != null
            ? Chewie(controller: _chewieController!)
            : Container(color: Colors.black),
        
        // Play/Pause button overlay - shows only when video is not playing
        if (!_isPlaying)
          GestureDetector(
            onTap: () {
              _videoPlayerController?.play();
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
      ],
    );
  }
} 