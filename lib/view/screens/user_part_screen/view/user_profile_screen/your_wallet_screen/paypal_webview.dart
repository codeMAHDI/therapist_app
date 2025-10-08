import 'package:counta_flutter_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// For iOS

class PayPalWebView extends StatefulWidget {
  final String paypalUrl;
  final Function(String token, String payerId) onPaymentSuccess;
  final Function(String? error) onPaymentError;

  const PayPalWebView({
    super.key,
    required this.paypalUrl,
    required this.onPaymentSuccess,
    required this.onPaymentError,
  });

  @override
  State<PayPalWebView> createState() => _PayPalWebViewState();
}

class _PayPalWebViewState extends State<PayPalWebView> {
  late final WebViewController _controller;
  var _isLoading = true;
  var _loadingProgress = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the controller with platform-specific settings
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _loadingProgress = progress;
              _isLoading = progress < 100;
            });
          },
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('payment-success')) {
              final uri = Uri.parse(request.url);
              final token = uri.queryParameters['token'];
              final payerId = uri.queryParameters['PayerID'];

              if (token != null && payerId != null) {
                widget.onPaymentSuccess(token, payerId);
                Navigator.of(context).pop();
                return NavigationDecision.prevent;
              }
            }

            if (request.url.contains('cancel')) {
              widget.onPaymentError('Payment cancelled');
              Navigator.of(context).pop();
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paypalUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text('PayPal Payment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            widget.onPaymentError('Payment cancelled by user');
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            LinearProgressIndicator(
              value: _loadingProgress / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
