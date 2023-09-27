import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/models/health_guide_models/health_guide_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/health_guides_service/health_guides_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HealthGuidesVM extends ChangeNotifier {
  late WebViewController controller;
  List<HealthGuideModel> listOfHealthGuide = [];
  double progressWebPageLoad = 0;
  bool webPageLoading = false;
  bool loadingHealthGuides = true;
  ProviderReference? _ref;
  HealthGuidesService? _healthGuidesService;

  HealthGuidesVM({ProviderReference? ref}) {
    _ref = ref;
    initService();
  }
  initService() {
    _healthGuidesService = _ref!.read(healthGuidesServiceProvider);
  }

  inAppWebView({required String initailUrl}) {
    WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100 && webPageLoading) {
              webPageLoading = false;
              notifyListeners();
            }
            progressWebPageLoad = progress / 100;
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            webPageLoading = false;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://connect.medlineplus.gov/') || request.url.startsWith('https://connect.medlineplus.gov/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(initailUrl));

    return Stack(
      children: [
        WebViewWidget(controller: webViewController),
        webPageLoading
            ? loader(
                radius: 20,
              )
            : Container(
                width: 0,
                height: 0,
              ),
      ],
    );
  }

  // navigationControl() {
  //           final bool webViewReady =
  //           controller. == ConnectionState.done;
  //       final WebViewController? controller1 = snapshot.data;
  //       return InkWell(
  //           onTap: !webViewReady
  //               ? null
  //               : () => navigate(context, controller1!, goBack: true),
  //           child: Icon(Icons.arrow_back_ios));
  //   // return FutureBuilder<WebViewController>(
  //   //   future: controller?.future,
  //   //   builder:
  //   //       (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {

  //   //   },
  //   // );
  // }

  disposeAppWebViewController() {
    controller?.clearCache();
    // controller?.future.then((value) => value.clearCache());
  }

  navigateBack(WebViewController controller, {bool goBack: false}) async {
    bool canNavigate =
        goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text("No ${goBack ? 'back' : 'forward'} history item")),
      // );
    }
  }

  setLoadingHealthGuide(check) {
    loadingHealthGuides = check;
    notifyListeners();
  }

  getAllHealthGuides() async {
    List<HealthGuideModel> data = [];
    listOfHealthGuide = [];
    data = await _healthGuidesService!.getAllHealthGuides();
    if (data is List<HealthGuideModel>) {
      data.forEach((element) {
        listOfHealthGuide.add(element);
      });
    }
    setLoadingHealthGuide(false);
  }
}
