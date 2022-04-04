import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/models/health_guide_models/health_guide_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/health_guides_service/health_guides_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HealthGuidesVM extends ChangeNotifier{
  Completer<WebViewController> controller = Completer<WebViewController>();
  List<HealthGuideModel> listOfHealthGuide = [];
  double progressWebPageLoad = 0;
  bool webPageLoading = true;
  bool loadingHealthGuides = true;
  ProviderReference? _ref;
  HealthGuidesService? _healthGuidesService;

  HealthGuidesVM({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _healthGuidesService = _ref!.read(healthGuidesServiceProvider);
  }

  inAppWebView({required String initailUrl}) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        if(snapshot.hasError){}
          return WebView(
            initialUrl: initailUrl,
            javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  controller.complete(webViewController);
                },
            onProgress: (progress){
              print("progrss $progress");
              if(progress == 100){
                // webPageLoading = false;
                notifyListeners();
              }
                progressWebPageLoad = progress/100;
            },
          );
      },
    );
  }

  navigationControl() {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {

            final bool webViewReady =
                snapshot.connectionState == ConnectionState.done;
            final WebViewController? controller1 = snapshot.data;
        return InkWell(
          onTap: !webViewReady
              ? null
              : () => navigate(context, controller1!, goBack: true),
            child: Icon(Icons.arrow_back_ios));
      },
    );
  }
  navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
    goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("No ${goBack ? 'back' : 'forward'} history item")),
      );
    }
  }




  setLoadingHealthGuide(check){
    loadingHealthGuides = check;
    notifyListeners();
  }

  getAllHealthGuides()async{
    List<HealthGuideModel> data = [];
    listOfHealthGuide = [];
    data = await _healthGuidesService!.getAllHealthGuides();
    if(data is List<HealthGuideModel>){
      data.forEach((element) {
        listOfHealthGuide.add(element);
      });
    }
    setLoadingHealthGuide(false);
  }


}