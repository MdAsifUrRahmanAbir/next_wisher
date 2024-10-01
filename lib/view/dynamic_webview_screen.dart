import 'dart:core';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../utils/basic_screen_imports.dart';

class WebViewScreen extends StatefulWidget {
  final String link, appTitle;
  final Function? onFinished;

  const WebViewScreen(
      {super.key, required this.link, required this.appTitle, this.onFinished});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimaryAppBar(
          title: widget.appTitle,
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.link)),
              onWebViewCreated: (InAppWebViewController controller) {},
              onLoadStart: (InAppWebViewController controller, Uri? url) {
                setState(() {
                  isLoading = true;
                });
              },
              onLoadStop: (InAppWebViewController controller, Uri? url) {
                widget.onFinished!(url);
                setState(() {
                  isLoading = false;
                });
              },
            ),
            Visibility(visible: isLoading, child: const CustomLoadingAPI())
          ],
        ));
  }
}
