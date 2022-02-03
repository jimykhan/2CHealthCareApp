import 'dart:io';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';

import '../menu_text_style.dart';

class FUMenu extends StatelessWidget {
  LoginVM loginVM;
  FUMenu({required this.loginVM,Key? key}) : super(key: key);
  double iconSize = ApplicationSizing.constSize(25);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(
          left: ApplicationSizing.constSize(20),
          right: ApplicationSizing.constSize(20),
          top: ApplicationSizing.constSize(10),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // applicatonState.updateSelectedTabI(0);
                // Navigator.pushReplacement(
                //     context,
                //     PageTransition(
                //         child: ChatListScreen(),
                //         type: PageTransitionType.fade));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FluentSystemIcons.ic_fluent_badge_regular,
                    size: iconSize,
                    color: appColor,
                  ),
                  MenuTextStyle(
                    text: "Home",
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                loginVM.userLogout();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FluentSystemIcons.ic_fluent_power_regular,
                    size: iconSize,
                    color: appColor,
                  ),
                  MenuTextStyle(
                    text: "Logout",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
// lounchDexcomUrl(context, ApplicatonState applicatonState,
//     DeviceService deviceService) async {
//   print("lounchDexcom url call");
//   try {
//     applicatonState.SetStateForDexcomAuth(true);
//     var response = await SimpleApi().getWithContext(
//         url: ApiStrings.GET_DEXCOM_CODE,
//         context: context,
//         bearerToken: deviceService.currentUser.bearerToken,
//         patintId: deviceService.currentUser.id);
//     if (response is Response) {
//       if (response.statusCode == 200) {
//         print(response.data);
//         await launch(response.data);
//       }
//       applicatonState.SetStateForDexcomAuth(false);
//     } else {
//       applicatonState.SetStateForDexcomAuth(false);
//     }
//   } catch (e) {
//     applicatonState.SetStateForDexcomAuth(false);
//   }
// }
}
