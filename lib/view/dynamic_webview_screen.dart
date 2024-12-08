import 'dart:core';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../routes/routes.dart';
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
          actions: [
            IconButton(onPressed: (){
              Get.offAllNamed(Routes.btmScreen);
            }, icon: Icon(Icons.home_filled, color: Theme.of(context).primaryColor,))
          ],
        ),
        body:  Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.link)),
              onWebViewCreated: (InAppWebViewController controller) {},
              onLoadStart: (InAppWebViewController controller, Uri? url) {
                setState(() {
                  isLoading = true;
                  debugPrint("Load Start >> $url");
                  debugPrint("Load Start >> $isLoading");
                });
                widget.onFinished!(url);
              },
              onLoadStop: (InAppWebViewController controller, Uri? url) {
                setState(() {
                  isLoading = false;
                  debugPrint("Load Stop >> $isLoading");
                });
              },
            ),

            isLoading ? CustomLoadingAPI(): SizedBox.shrink()
            // Visibility(visible: isLoading, child: const CustomLoadingAPI())
          ],
        ));
  }
}
