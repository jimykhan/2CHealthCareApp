import 'dart:io';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/aler_dialogue.dart';
import 'package:twochealthcare/common_widgets/drawer_components/menu_spacing.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/views/facility_user/fu_home/patient_list/all_patient.dart';

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
          // left: ApplicationSizing.constSize(20),
          // right: ApplicationSizing.constSize(20),
          // top: ApplicationSizing.constSize(10),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
              },
              child: Container(
                padding: MenuPadding(),
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
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    applicationContext!.currentContext!,
                    PageTransition(
                        child: AllPatient(),
                        type: PageTransitionType.bottomToTop));
              },
              child: Container(
                padding: MenuPadding(),
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
                      text: "Patient List",
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                logoutAlertDialog(loginVM: loginVM);
              },
              child: Container(
                padding: MenuPadding(),
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
            ),
          ],
        ),
      ),
    );
  }
}
