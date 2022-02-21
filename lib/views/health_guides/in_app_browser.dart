import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/health_guides_vm/health_guides_vm.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppBrowser extends HookWidget {
  String url;
  String title;
   InAppBrowser({Key? key,required this.url,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);
    HealthGuidesVM healthGuidesVM = useProvider(healthGuidesVMProviders);

    useEffect(
          () {
        healthGuidesVM.webPageLoading = true;
        Future.microtask(() async {
        });
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: CustomBackButton(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: title,
            ),
            // trailingIcon: healthGuidesVM.navigationControl(),
          ),
        ),
          body: Container(
            child: Column(
              children: [
            Container(
                height: 3,
                child: LinearPercentIndicator(//leaner progress bar
                  padding: EdgeInsets.zero,
                animation: true,
                width: MediaQuery.of(context).size.width,
                animationDuration: 1000,
                lineHeight: 3.0,
                percent: healthGuidesVM.progressWebPageLoad == 0.1 ? 0 : healthGuidesVM.progressWebPageLoad,
                // center: Text(
                //   percent.toString() + "%",
                //   style: TextStyle(
                //       fontSize: 12.0,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.black),
                // ),
                // linearStrokeCap: LinearStrokeCap.,
                progressColor: appColor,
                backgroundColor: Colors.grey[300],
            ),
              ),
                Expanded(
                  child: healthGuidesVM.inAppWebView(initailUrl: url),)
              ],
            ),
          ),


        // body: Container(
        //   child: !healthGuidesVM.controller.isCompleted ? AlertLoader() : WebView(
        //     initialUrl: url,
        //     onWebViewCreated: (WebViewController webViewController) {
        //       healthGuidesVM.controller.complete(webViewController);
        //
        //     },
        //   ),
        // )
    );
  }




}