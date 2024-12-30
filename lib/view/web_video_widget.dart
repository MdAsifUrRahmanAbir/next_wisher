import 'dart:core';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../utils/basic_screen_imports.dart';

class WebVideoWidget extends StatefulWidget {
  final String link;

  const WebVideoWidget({super.key, required this.link});

  @override
  State<WebVideoWidget> createState() => _WebVideoWidgetState();
}

class _WebVideoWidgetState extends State<WebVideoWidget> {
  bool isLoading = false;
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimaryAppBar(onTap: () {
          Navigator.pop(context);
        }),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.link)),
                initialSettings: InAppWebViewSettings(

                    javaScriptEnabled: true),
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, Uri? url) {
                  setState(() {
                    isLoading = true;
                    debugPrint("Load Start >> $url");
                    debugPrint("Load Start >> $isLoading");
                  });
                },
                onLoadStop:
                    (InAppWebViewController controller, Uri? url) async {
                  setState(() {
                    isLoading = false;
                    debugPrint("Load Stop >> $isLoading");
                  });
                  // Inject JavaScript to set the video fullscreen
                  await controller.evaluateJavascript(source: """
            document.addEventListener('DOMContentLoaded', function() {
              const video = document.querySelector('video');
              if (video) {
                video.addEventListener('loadeddata', function() {
                  video.requestFullscreen().catch(console.error);
                });
              }
            });
          """);
                },
              ),

              isLoading ? CustomLoadingAPI() : SizedBox.shrink()
              // Visibility(visible: isLoading, child: const CustomLoadingAPI())
            ],
          ),
        ));
  }
}
