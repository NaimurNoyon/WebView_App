import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  WebViewController controller = WebViewController()

    ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://flutter.dev/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(
      Uri.parse('https://github.com/'),
    );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Visibility(
            visible: isLoading,
            child: Center(child: CircularProgressIndicator()),
            replacement: WebViewWidget(
              controller: controller,
            ),
          )
      ),
    );
  }
}
