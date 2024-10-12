import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart'; // Import GetX package

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the URL passed via GetX's navigation
    final String url = Get.arguments; // Get the URL from arguments

    // Create WebViewController to manage the WebView
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
            const PlatformWebViewControllerCreationParams());

    // Set up the WebView settings
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
          Uri.parse(url)); // Load the URL retrieved from Get.arguments

    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: WebViewWidget(controller: controller), // Display the WebView
    );
  }
}
