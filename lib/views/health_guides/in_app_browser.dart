import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
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
   InAppBrowser({Key? key,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);
    HealthGuidesVM healthGuidesVM = useProvider(healthGuidesVMProviders);

    useEffect(
          () {

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
            leadingIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding:
                EdgeInsets.only(right: ApplicationSizing.convertWidth(10)),
                child: RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                        "assets/icons/home/right-arrow-icon.svg")),
              ),
            ),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Health Guidelines",
            ),
            trailingIcon: healthGuidesVM.navigationControl(),
          ),
        ),
          body: healthGuidesVM.inAppWebView(initailUrl: url),
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