import 'package:flutter/material.dart';
import 'package:momra/core/util/helper_functions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({
    super.key,
    required this.url,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController webViewController;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = 'Something went wrong.';

  Future<void> init() async {
    if (!Uri.parse(widget.url).isAbsolute ||
        (!widget.url.startsWith('http://') &&
            !widget.url.startsWith('https://'))) {
      setState(() {
        _hasError = true;
        _isLoading = false;
        _errorMessage = 'Invalid URL format. Only HTTP/HTTPS URLs are allowed';
      });
      return;
    }

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onHttpError: (HttpResponseError error) {
            setState(() {
              _hasError = true;
              _isLoading = false;
              _errorMessage = 'HTTP Error: ${error.response?.statusCode} ';
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _hasError = true;
              _isLoading = false;
              _errorMessage =
                  'Web Resource Error: ${error.errorCode} ${error.description}';
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse(
            widget.url,
          ),
          headers: {
            'KeyAccess': generateRandom4Char(),
          });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          if (_hasError)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            WebViewWidget(controller: webViewController),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
