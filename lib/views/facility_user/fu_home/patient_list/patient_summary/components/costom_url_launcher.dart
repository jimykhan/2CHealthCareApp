import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/health_guides_vm/health_guides_vm.dart';

class CostomUrlLauncher extends HookWidget {
  String url;
  double? height;

  CostomUrlLauncher({Key? key,required this.url,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return Container(
      height: height?? MediaQuery.of(context).size.height/1.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30)
          ),
          color: Colors.white
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
              healthGuidesVM.disposeAppWebViewController();
            },
            child: Container(
              // color: Colors.red,
              padding: EdgeInsets.only(top: 5,bottom: 10),
              child: Container(
                // margin: EdgeInsets.only(top: 5,bottom: 10),
                width: 170,
                height: 5,
                decoration: BoxDecoration(
                    color: fontGrayColor,
                    borderRadius: BorderRadius.circular(2)
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              // height: MediaQuery.of(context).size.height/1.8-20,
              child:  healthGuidesVM.inAppWebView(initailUrl: url),

            ),
          )

        ],
      ),
    );
  }
}