import 'dart:core';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../backend/utils/custom_loading_api.dart';
import '../utils/basic_screen_imports.dart';

class WebVideoWidget extends StatefulWidget {
  final String link;

  const WebVideoWidget({super.key, required this.link});

  @override
  State<WebVideoWidget> createState() => _WebVideoWidgetState();
}

class _WebVideoWidgetState extends State<WebVideoWidget> {
  bool isLoading = true;
  late InAppWebViewController webViewController;
  bool hasError = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Video Player", style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.link)),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                mediaPlaybackRequiresUserGesture: false,
                useHybridComposition: true,
                allowsInlineMediaPlayback: true,
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
              },
              onLoadStart: (InAppWebViewController controller, Uri? url) {
                setState(() {
                  isLoading = true;
                  debugPrint("Web View Load Start >> $url");
                });
              },
              onLoadStop: (InAppWebViewController controller, Uri? url) async {
                debugPrint("Web View Load Stop >> $url");
                
                // Inject custom video styles and controls
                await controller.evaluateJavascript(source: """
                  (function() {
                    document.body.style.backgroundColor = 'black';
                    document.body.style.display = 'flex';
                    document.body.style.alignItems = 'center';
                    document.body.style.justifyContent = 'center';
                    document.body.style.height = '100vh';
                    document.body.style.margin = '0';
                    document.body.style.padding = '0';
                    
                    var video = document.querySelector('video');
                    if (video) {
                      video.controls = true;
                      video.style.maxWidth = '100%';
                      video.style.maxHeight = '90vh';
                      video.style.width = 'auto';
                      video.style.height = 'auto';
                      video.style.margin = 'auto';
                      video.autoplay = true;
                      
                      // Create player wrapper if needed
                      var wrapper = document.createElement('div');
                      wrapper.style.display = 'flex';
                      wrapper.style.flexDirection = 'column';
                      wrapper.style.alignItems = 'center';
                      wrapper.style.justifyContent = 'center';
                      wrapper.style.width = '100%';
                      wrapper.style.height = '100%';
                      
                      video.parentNode.insertBefore(wrapper, video);
                      wrapper.appendChild(video);
                      
                      // Try to play the video
                      video.play().catch(function(error) {
                        console.log('Video play error:', error);
                      });
                    } else {
                      // No video found, create one with the source
                      var videoElement = document.createElement('video');
                      videoElement.src = "${widget.link}";
                      videoElement.controls = true;
                      videoElement.autoplay = true;
                      videoElement.style.maxWidth = '100%';
                      videoElement.style.maxHeight = '90vh';
                      
                      document.body.appendChild(videoElement);
                      
                      videoElement.play().catch(function(error) {
                        console.log('Video play error:', error);
                      });
                    }
                  })();
                """);
                
                setState(() {
                  isLoading = false;
                });
              },
              onReceivedError: (controller, request, error) {
                debugPrint("WebView Error: ${error.description}");
                setState(() {
                  hasError = true;
                  isLoading = false;
                });
              },
            ),
            
            if (isLoading)
              const CustomLoadingAPI(),
              
            if (hasError)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Error loading video",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Go Back"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
