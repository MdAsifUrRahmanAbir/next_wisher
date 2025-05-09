import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../backend/utils/custom_loading_api.dart';
import 'package:get/get.dart';

/// A widget that plays videos directly inline like TikTok
/// Shows thumbnail until tapped, then plays video in the same place
class TikTokStyleVideoWidget extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final bool showFullscreenOption;

  const TikTokStyleVideoWidget({
    Key? key,
    required this.videoUrl,
    required this.thumbnailUrl,
    this.width = double.infinity,
    this.height = 450,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.showFullscreenOption = true,
  }) : super(key: key);

  // Create a global key to access the state
  static final GlobalKey<_TikTokStyleVideoWidgetState> globalKey =
      GlobalKey<_TikTokStyleVideoWidgetState>();

  // Static method to pause all videos
  static void pauseAllVideos() {
    if (globalKey.currentState != null) {
      globalKey.currentState!.pauseVideo();
    }
  }

  @override
  State<TikTokStyleVideoWidget> createState() => _TikTokStyleVideoWidgetState();
}

class _TikTokStyleVideoWidgetState extends State<TikTokStyleVideoWidget>
    with WidgetsBindingObserver {
  bool _isPlaying = false;
  bool _isLoading = false;
  late InAppWebViewController? _webViewController;
  final GlobalKey _webViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _webViewController = null;

    // Register as an observer to detect app lifecycle changes
    WidgetsBinding.instance.addObserver(this);

    // Load video immediately but don't autoplay
    setState(() {
      _isPlaying = true; // Show video instead of thumbnail
      _isLoading = true;
    });
  }

  @override
  void dispose() {
    // Remove observer when widget is disposed
    WidgetsBinding.instance.removeObserver(this);

    // Ensure video is paused when widget is disposed
    pauseVideo();
    _webViewController = null;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pause video when app goes to background
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      pauseVideo();
    }
  }

  // Method to pause the video
  void pauseVideo() {
    if (_webViewController != null && _isPlaying) {
      _webViewController?.evaluateJavascript(source: """
        (function() {
          var video = document.querySelector('video');
          if (video && !video.paused) {
            video.pause();
          }
        })();
      """);
    }
  }

  void _playVideo() {
    if (_isPlaying) return;

    setState(() {
      _isPlaying = true;
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: Colors.transparent,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail
          if (!_isPlaying)
            GestureDetector(
              onTap: _playVideo,
              child: CachedNetworkImage(
                imageUrl: widget.thumbnailUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.black,
                  child: const Icon(Icons.error, color: Colors.white),
                ),
              ),
            ),

          // WebView (only shown when playing)
          if (_isPlaying)
            InAppWebView(
              key: _webViewKey,
              initialUrlRequest: URLRequest(url: WebUri(widget.videoUrl)),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                mediaPlaybackRequiresUserGesture: false,
                useHybridComposition: true,
                allowsInlineMediaPlayback: true,
                transparentBackground: true,
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  _isLoading = true;
                });
              },
              onLoadStop: (controller, url) async {
                // Inject custom JavaScript to style the video and display the first frame
                await controller.evaluateJavascript(source: """
                  (function() {
                    // Fix body styles
                    document.body.style.backgroundColor = 'transparent';
                    document.body.style.margin = '0';
                    document.body.style.padding = '0';
                    document.body.style.display = 'flex';
                    document.body.style.alignItems = 'center';
                    document.body.style.justifyContent = 'center';
                    document.body.style.width = '100%';
                    document.body.style.height = '100%';
                    document.body.style.position = 'fixed';
                    document.body.style.top = '0';
                    document.body.style.left = '0';
                    document.body.style.right = '0';
                    document.body.style.bottom = '0';
                    document.body.style.overflow = 'hidden';

                    // Strong CSS to control all elements
                    var style = document.createElement('style');
                    style.textContent = `
                      * {
                        box-sizing: border-box;
                      }
                      html, body {
                        width: 100% !important;
                        height: 100% !important;
                        margin: 0 !important;
                        padding: 0 !important;
                        overflow: hidden !important;
                        background-color: transparent !important;
                        display: flex !important;
                        align-items: center !important;
                        justify-content: center !important;
                      }
                      video {
                        display: block !important;
                        width: 100% !important;
                        height: auto !important;
                        object-fit: contain !important;
                        background-color: transparent !important;
                        position: absolute !important;
                        left: 0 !important;
                        top: 0 !important;
                        right: 0 !important;
                        bottom: 0 !important;
                        margin: auto !important;
                      }
                    `;
                    document.head.appendChild(style);

                    // Create and set up video element
                    var video = document.querySelector('video');
                    if (!video) {
                      video = document.createElement('video');
                      video.src = "${widget.videoUrl}";
                      document.body.appendChild(video);
                    }

                    // Configure video element
                    video.controls = true;
                    video.style.width = '100%';
                    video.style.height = 'auto';
                    video.style.objectFit = 'contain';
                    video.style.backgroundColor = 'transparent';
                    video.style.position = 'absolute';
                    video.style.top = '0';
                    video.style.left = '0';
                    video.style.right = '0';
                    video.style.bottom = '0';
                    video.style.margin = 'auto';
                    video.autoplay = true;
                    video.loop = true;
                    video.muted = false; // Muted for preload
                    video.preload = 'auto';

                    // Force center the video
                    video.parentElement.style.display = 'flex';
                    video.parentElement.style.alignItems = 'center';
                    video.parentElement.style.justifyContent = 'center';
                    video.parentElement.style.width = '100%';
                    video.parentElement.style.height = '100%';

                    // Load video to display first frame
                    video.load();

                    // Seek to first frame to ensure thumbnail shows
                    video.addEventListener('loadeddata', function() {
                      // Seek to 0.1 seconds to show a frame, but not play
                      video.currentTime = 0.1;

                      // Add click event to play/pause video
                      video.addEventListener('click', function() {
                        if (video.paused) {
                          video.play().then(function() {
                            video.muted = false; // Unmute when playing
                          }).catch(console.error);
                        } else {
                          video.pause();
                        }
                      });
                    });
                  })();
                """);

                setState(() {
                  _isLoading = false;
                });
              },
              onReceivedError: (controller, request, error) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),

          // Loading indicator
          if (_isPlaying && _isLoading)
            Container(
              color: Colors.black,
              child: const Center(
                child: CustomLoadingAPI(),
              ),
            ),

          // Fullscreen button
          if (_isPlaying && widget.showFullscreenOption)
            Positioned(
              bottom: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    FullscreenVideoPage(videoUrl: widget.videoUrl),
                    transition: Transition.fade,
                  );
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A fullscreen page for video viewing
class FullscreenVideoPage extends StatefulWidget {
  final String videoUrl;

  const FullscreenVideoPage({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  State<FullscreenVideoPage> createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage>
    with WidgetsBindingObserver {
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    // Register as an observer to detect app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove observer when widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    // Ensure video is paused when widget is disposed
    pauseVideo();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Pause video when app goes to background
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      pauseVideo();
    }
  }

  // Method to pause the video
  void pauseVideo() {
    if (_webViewController != null) {
      _webViewController?.evaluateJavascript(source: """
        (function() {
          var video = document.querySelector('video');
          if (video && !video.paused) {
            video.pause();
          }
        })();
      """);
    }
  }

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
            pauseVideo();
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.videoUrl)),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            mediaPlaybackRequiresUserGesture: false,
            useHybridComposition: true,
            allowsInlineMediaPlayback: true,
          ),
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
          onLoadStop: (controller, url) async {
            await controller.evaluateJavascript(source: """
              (function() {
                // Fix body styles
                document.body.style.backgroundColor = 'transparent';
                document.body.style.margin = '0';
                document.body.style.padding = '0';
                document.body.style.display = 'flex';
                document.body.style.alignItems = 'center';
                document.body.style.justifyContent = 'center';
                document.body.style.width = '100%';
                document.body.style.height = '100%';
                document.body.style.position = 'fixed';
                document.body.style.top = '0';
                document.body.style.left = '0';
                document.body.style.right = '0';
                document.body.style.bottom = '0';
                document.body.style.overflow = 'hidden';

                // Strong CSS to control all elements
                var style = document.createElement('style');
                style.textContent = `
                  * {
                    box-sizing: border-box;
                  }
                  html, body {
                    width: 100% !important;
                    height: 100% !important;
                    margin: 0 !important;
                    padding: 0 !important;
                    overflow: hidden !important;
                    background-color: transparent !important;
                    display: flex !important;
                    align-items: center !important;
                    justify-content: center !important;
                  }
                  video {
                    display: block !important;
                    width: 100% !important;
                    height: auto !important;
                    object-fit: contain !important;
                    background-color: transparent !important;
                    position: absolute !important;
                    left: 0 !important;
                    top: 0 !important;
                    right: 0 !important;
                    bottom: 0 !important;
                    margin: auto !important;
                  }
                `;
                document.head.appendChild(style);

                var video = document.querySelector('video');
                if (video) {
                  video.controls = true;
                  video.style.width = '100%';
                  video.style.height = 'auto';
                  video.style.objectFit = 'contain';
                  video.style.backgroundColor = 'transparent';
                  video.style.position = 'absolute';
                  video.style.top = '0';
                  video.style.left = '0';
                  video.style.right = '0';
                  video.style.bottom = '0';
                  video.style.margin = 'auto';
                  video.autoplay = true;
                  video.loop = true;

                  // Force center the video
                  video.parentElement.style.display = 'flex';
                  video.parentElement.style.alignItems = 'center';
                  video.parentElement.style.justifyContent = 'center';
                  video.parentElement.style.width = '100%';
                  video.parentElement.style.height = '100%';

                  video.play().catch(console.error);
                } else {
                  var newVideo = document.createElement('video');
                  newVideo.src = "${widget.videoUrl}";
                  newVideo.controls = true;
                  newVideo.autoplay = true;
                  newVideo.loop = true;
                  newVideo.style.width = '100%';
                  newVideo.style.height = 'auto';
                  newVideo.style.objectFit = 'contain';
                  newVideo.style.backgroundColor = 'transparent';
                  newVideo.style.position = 'absolute';
                  newVideo.style.top = '0';
                  newVideo.style.left = '0';
                  newVideo.style.right = '0';
                  newVideo.style.bottom = '0';
                  newVideo.style.margin = 'auto';

                  var wrapper = document.createElement('div');
                  wrapper.style.display = 'flex';
                  wrapper.style.alignItems = 'center';
                  wrapper.style.justifyContent = 'center';
                  wrapper.style.width = '100%';
                  wrapper.style.height = '100%';
                  wrapper.style.position = 'fixed';
                  wrapper.style.top = '0';
                  wrapper.style.left = '0';
                  wrapper.style.right = '0';
                  wrapper.style.bottom = '0';

                  document.body.appendChild(wrapper);
                  wrapper.appendChild(newVideo);
                  newVideo.play().catch(console.error);
                }
              })();
            """);
          },
        ),
      ),
    );
  }
}
