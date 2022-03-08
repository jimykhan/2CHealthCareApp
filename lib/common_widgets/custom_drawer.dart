import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/aler_dialogue.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/drawer_components/fu_menu.dart';
import 'package:twochealthcare/common_widgets/drawer_components/head_profile.dart';
import 'package:twochealthcare/common_widgets/drawer_components/p_menu.dart';
import 'package:twochealthcare/common_widgets/menu_text_style.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/application_package_vm.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/views/care_plan/care_plan.dart';
import 'package:twochealthcare/views/health_guides/health_guides.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:twochealthcare/views/home/profile.dart';
import 'package:twochealthcare/views/readings/modalities_reading.dart';

class CustomDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    ApplicationPackageVM applicationPackageVM =
        useProvider(applicationPackageVMProvider);
    OnLaunchActivityAndRoutesService onLaunchActivityAndRoutesService =
        useProvider(onLaunchActivityServiceProvider);
    useEffect(
      () {
        Future.microtask(() async {});

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeadProfile(
                      loginVM: loginVM,
                    ),
                    ApplicationSizing.verticalSpacer(n: 10),
                    loginVM.currentUser!.userType == 1
                        ? PMenu(
                            loginVM: loginVM,
                            onLaunchActivityAndRoutesService:
                                onLaunchActivityAndRoutesService,
                          )
                        : FUMenu(
                            loginVM: loginVM,
                          ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ApplicationSizing.horizontalMargin(),
                    // vertical: ApplicationSizing.convert(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuTextStyle(
                        text: "Versions: ",
                        fontSize: ApplicationSizing.fontScale(10),
                        isPadding: false,
                      ),
                      MenuTextStyle(
                        text: applicationPackageVM.currentVersion ?? "",
                        fontSize: ApplicationSizing.fontScale(10),
                        isPadding: false,
                        color: appColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: ApplicationSizing.horizontalMargin(),
                    right: ApplicationSizing.horizontalMargin(),
                    bottom: ApplicationSizing.convert(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuTextStyle(
                        text: "Last loggedIn date : ",
                        fontSize: ApplicationSizing.fontScale(10),
                        isPadding: false,
                      ),
                      (loginVM.logedInUserModel?.lastLogedIn == "" ||
                              loginVM.logedInUserModel?.lastLogedIn == null)
                          ? Container()
                          : MenuTextStyle(
                              text: Jiffy(
                                      loginVM.logedInUserModel?.lastLogedIn ??
                                          "")
                                  .format(Strings.dateAndTimeFormat),
                              fontSize: ApplicationSizing.fontScale(10),
                              isPadding: false,
                              color: appColor,
                            ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
