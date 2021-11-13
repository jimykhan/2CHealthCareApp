import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/splash_vm/splash_vm.dart';
class Splash extends HookWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationSizing(applicationContext?.currentContext);
    SplashVM deviceService = useProvider(splachVMProvider);


    useEffect(
          () {
        Future.microtask(() async {});

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                  ),
                  Container(
                    child: Image.asset("assets/icons/splash_logo.png",
                      width: ApplicationSizing.convert(200),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Container(
                      child: Image.asset("assets/icons/loginBg.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
