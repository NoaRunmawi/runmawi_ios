import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  String? title;
  String? url;
  WebViewExample(this.title, this.url);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  bool _isLoading = true;
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    controller = WebViewController()
      ..setNavigationDelegate(
          NavigationDelegate(
        onWebResourceError: (WebResourceError eroor){
        },
        onPageStarted: (url) {
          setState(() {
            _isLoading = true;
          });
        },
        onProgress: (progress) {
          setState(() {
            _isLoading = true;
          });
        },
        onPageFinished: (url) {
          setState(() {
            _isLoading = false;
          });
        },
      ))..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(widget.url!),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title.toString()),

        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller:controller,
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
