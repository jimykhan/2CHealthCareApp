import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/home/home.dart';

class FloatingButton extends HookWidget {
  FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);
    OnLaunchActivityAndRoutesService onLaunchActivityService = useProvider(onLaunchActivityServiceProvider);
    return FloatingActionButton(
      child: Container(
        width: 60,
        height: 60,
        padding: EdgeInsets.all(15),
        child: SvgPicture.asset(
          "assets/icons/side_menu/home-icon.svg",
          height: ApplicationSizing.convert(25),
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient:
                LinearGradient(colors: [Color(0Xff4EAF48), Color(0xff60E558)])),
      ),
      onPressed: () {
        applicationRouteService.removeAllAndAdd(screenName: "Home");
        onLaunchActivityService.HomeDecider();
      },
    );
  }
}
