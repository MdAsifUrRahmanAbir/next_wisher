// import 'package:video_player/video_player.dart';
//
// import '../backend/utils/custom_loading_api.dart';
// import '../utils/basic_screen_imports.dart';
//
// class VideoPlayerScreen extends StatefulWidget {
//   const VideoPlayerScreen({super.key, required this.videoUrl});
//
//   final String videoUrl;
//
//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;
//
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Create and store the VideoPlayerController. The VideoPlayerController
//     // offers several different constructors to play videos from assets, files,
//     // or the internet.
//     _controller = VideoPlayerController.networkUrl(
//       Uri.parse(
//         widget.videoUrl,
//       ),
//     );
//
//     _initializeVideoPlayerFuture = _controller.initialize();
//   }
//
//   @override
//   void dispose() {
//     // Ensure disposing of the VideoPlayerController to free up resources.
//     _controller.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Complete the code in the next step.
//     return FutureBuilder(
//       future: _initializeVideoPlayerFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//
//           // chewieController = ChewieController(
//           //   videoPlayerController: _controller,
//           //   autoPlay: true, // Auto-play the video
//           //   looping: false, // Disable looping by default
//           //   // aspectRatio: 16/9,
//           //   placeholder: CustomLoadingAPI(),
//           //   errorBuilder: (context, url) => Icon(Icons.error),
//           // );
//
//           return Column(
//             children: [
//               AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 // Use the VideoPlayer widget to display the video.
//                 // child: Chewie(
//                 //   controller: chewieController,
//                 // ),
//                 child: VideoPlayer(_controller),
//               ),
//               IconButton(
//                 onPressed: () {
//                   // Wrap the play or pause in a call to `setState`. This ensures the
//                   // correct icon is shown.
//                   setState(() {
//                     // If the video is playing, pause it.
//                     if (_controller.value.isPlaying) {
//                       _controller.pause();
//                     } else {
//                       // If the video is paused, play it.
//                       _controller.play();
//                     }
//                   });
//                 },
//                 // Display the correct icon depending on the state of the player.
//                 icon: Icon(
//                   _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                 ),
//               )
//             ],
//           );
//         } else {
//           // If the VideoPlayerController is still initializing, show a
//           // loading spinner.
//           return const Center(
//             child: CustomLoadingAPI(),
//           );
//         }
//       },
//     );
//   }
// }