import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/aler_dialogue.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/menu_text_style.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/views/care_plan/care_plan.dart';
import 'package:twochealthcare/views/health_guides/health_guides.dart';
import 'package:twochealthcare/views/home/profile.dart';
import 'package:twochealthcare/views/readings/modalities_reading.dart';
class PMenu extends StatelessWidget {
  LoginVM loginVM;
  PMenu({required this.loginVM,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: ApplicationSizing.convert(20)),
              child: Column(
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.pushReplacement(context,
                  //         PageTransition(child: Home(), type: PageTransitionType.fade));
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: ApplicationSizing
                  //             .horizontalMargin(),
                  //         vertical: ApplicationSizing.convert(6)),
                  //     child: Row(
                  //       // crossAxisAlignment: CrossAxisAlignment.end,
                  //       children: [
                  //         SvgPicture.asset(
                  //           "assets/icons/side_menu/home-icon.svg",
                  //           color: appColor,
                  //           width: ApplicationSizing.convert(18),
                  //           height: ApplicationSizing.convert(18),
                  //         ),
                  //         MenuTextStyle(
                  //           text: "Home",
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          PageTransition(child: Profile(), type: PageTransitionType.fade));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ApplicationSizing
                              .horizontalMargin(),
                          vertical: ApplicationSizing.convert(6)),
                      // color: Colors.pinkAccent,
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/home/user-icon.svg",
                            color: appColor,
                            width: ApplicationSizing.convert(18),
                            height: ApplicationSizing.convert(18),
                          ),
                          MenuTextStyle(
                            text: "My Profile",
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          PageTransition(child: ModalitiesReading(), type: PageTransitionType.fade));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ApplicationSizing
                              .horizontalMargin(),
                          vertical: ApplicationSizing.convert(6)),
                      // color: Colors.pinkAccent,
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/home/reading-icon.svg",
                            color: appColor,
                            width: ApplicationSizing.convert(18),
                            height: ApplicationSizing.convert(18),
                          ),
                          MenuTextStyle(
                            text: "My Readings",
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          PageTransition(child: HealthGuides(), type: PageTransitionType.fade));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ApplicationSizing
                              .horizontalMargin(),
                          vertical: ApplicationSizing.convert(6)),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/home/health-guide-icon.svg",
                            color: appColor,
                            width: ApplicationSizing.convert(18),
                            height: ApplicationSizing.convert(18),
                          ),
                          MenuTextStyle(
                            text: "Health Guides",
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      CustomAlertDialog(message: "Coming Soon...");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ApplicationSizing
                              .horizontalMargin(),
                          vertical: ApplicationSizing.convert(6)),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/home/trophy-icon.svg",
                            color: appColor,
                            width: ApplicationSizing.convert(18),
                            height: ApplicationSizing.convert(18),
                          ),
                          MenuTextStyle(
                            text: "My Rewards",
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          PageTransition(child: CarePlan(), type: PageTransitionType.fade));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ApplicationSizing
                              .horizontalMargin(),
                          vertical: ApplicationSizing.convert(6)),
                      // color: Colors.pinkAccent,
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            "assets/icons/side_menu/treatment.png",
                            color: appColor,
                            width: ApplicationSizing.convert(18),
                            height: ApplicationSizing.convert(18),
                          ),
                          MenuTextStyle(
                            text: "Care Plan",
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      CustomAlertDialog(message: "Coming Soon...");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ApplicationSizing
                              .horizontalMargin(),
                          vertical: ApplicationSizing.convert(6)),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/side_menu/setting-icon.svg",
                            color: appColor,
                            width: ApplicationSizing.convert(18),
                            height: ApplicationSizing.convert(18),
                          ),
                          MenuTextStyle(
                            text: "Settings",
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      loginVM.userLogout();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ApplicationSizing
                              .horizontalMargin(),
                          vertical: ApplicationSizing.convert(6)),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/side_menu/logout-icon.svg",
                            color: appColor,
                            width: ApplicationSizing.convert(18),
                            height: ApplicationSizing.convert(18),
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
            )
          ],
        ),
      ),
    );
  }
}
