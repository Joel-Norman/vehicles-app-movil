import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState(url: url);
}

class _WebViewScreenState extends State<WebViewScreen> {
  final String url; 
  bool isLoading = true;
  late WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        print("cargado");
      },
      onPageStarted: (String url) {print("cargado2");},
      onPageFinished: (String url) {print("cargado3");},
      onHttpError: (HttpResponseError error) {print("cargado4");},
      onWebResourceError: (WebResourceError error) {print("cargado5");},
      onNavigationRequest: (NavigationRequest request) {
        print("cargado6");
        if (request.url.startsWith(url)) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse(url));

  _WebViewScreenState({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tilopay'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}