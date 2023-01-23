import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  static const String routeName='/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
Connectivity connectivity=Connectivity();
bool data=false;
class _HomePageState extends State<HomePage> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://jadurjini.logomeker.com'));

  late WebViewController controllerGlobal;


  @override
  Widget build(BuildContext context) {
    Connectivity connectivity=Connectivity();
    return WillPopScope(
      onWillPop: ()async{
        if(await controller.canGoBack())
        {
          controller.goBack();
          return false;
        }
        else
        {

          return true;
        }
      },
      child: Scaffold(
          body: StreamBuilder(
            stream: connectivity.onConnectivityChanged,
            builder: (_, snapshot){
              return snapshot.connectionState==ConnectionState.active?
              snapshot.data!=ConnectivityResult.none?
              WebViewWidget(controller: controller): Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off_sharp,size: 45,),
                    SizedBox(height: 10,),
                    Text('No Data Connection')
                  ],
                ),
              )
                  :WebViewWidget(controller: controller);
            },)
      ),
    );
  }
}
