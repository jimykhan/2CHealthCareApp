import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/connectivity_service.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/splash_vm/splash_vm.dart';

class Deeplinkwork extends HookWidget {
  var url;
  Deeplinkwork({Key? key,this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ApplicationSizing(applicationContext?.currentContext);
    // SplashVM deviceService = useProvider(splachVMProvider);
    // OnLaunchActivityAndRoutesService onLaunchActivityAndRoutesService = useProvider(onLaunchActivityServiceProvider);
    // ConnectivityService connectivityService = useProvider(connectivityServiceProvider);
    // ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);

    useEffect(
      () {
        // onLaunchActivityAndRoutesService.handleMessage();
        // connectivityService.checkInternetConnection();
        Future.microtask(() async {});

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(child: Text("Deep Link working okay ${url.toString()}")),
    ));
  }
  // It is assumed that all messages contain a data field with the key 'type'
}
