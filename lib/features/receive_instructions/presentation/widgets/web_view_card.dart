import 'package:flutter/material.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCard extends StatefulWidget {
  final String url;
  const WebViewCard({super.key, required this.url});

  @override
  State<WebViewCard> createState() => _WebViewCardState();
}

class _WebViewCardState extends State<WebViewCard> {
  late final WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.greyLite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: WebViewWidget(controller: controller));
  }
}
