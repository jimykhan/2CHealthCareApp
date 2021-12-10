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
import 'package:twochealthcare/common_widgets/menu_text_style.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/application_package_vm.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:twochealthcare/views/home/profile.dart';
import 'package:twochealthcare/views/readings/modalities_reading.dart';

class CustomDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    FirebaseService firebaseService = useProvider(firebaseServiceProvider);
    ApplicationPackageVM applicationPackageVM =
        useProvider(applicationPackageVMProvider);
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
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [AppBarStartColor, AppBarEndColor],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )),
                            child: Row(
                              children: [
                                Container(
                                  height: ApplicationSizing.convert(200),
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          ApplicationSizing.horizontalMargin()),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: ApplicationSizing
                                                .horizontalMargin()),
                                        child: CircularImage(
                                          w: ApplicationSizing.convert(80),
                                          h: ApplicationSizing.convert(80),
                                          imageUrl:
                                              'https://www.propertytwinsswfl.com/wp-content/uploads/2018/09/dummy-profile-pic-male.jpg',
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          loginVM.currentUser?.fullName ?? "",
                                          style: Styles.PoppinsRegular(
                                              fontSize:
                                                  ApplicationSizing.fontScale(
                                                      20),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: 10, left: 10),
                                        child: Text(
                                          loginVM.currentUser?.userName ?? "",
                                          style: Styles.PoppinsRegular(
                                              fontSize:
                                                  ApplicationSizing.fontScale(
                                                      10),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ApplicationSizing.verticalSpacer(n: 10),
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
                                    firebaseService.turnOfReadingNotification();
                                    firebaseService.turnOfChatNotification();

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
                      (loginVM.logedInUserModel?.lastLogedIn == "" || loginVM.logedInUserModel?.lastLogedIn == null)
                          ? Container() :MenuTextStyle(
                        text: Jiffy(loginVM.logedInUserModel?.lastLogedIn ?? "").format("dd MMM yy, h:mm a") ,
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

  _menu(
    context,
  ) {
    Color UnSelectedColor = Color(0xff134389);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: ApplicationSizing.convert(1)),
          padding: EdgeInsets.symmetric(
              horizontal: ApplicationSizing.horizontalMargin()),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [AppBarStartColor, AppBarEndColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Icon(
          //             FluentSystemIcons.ic_fluent_heart_regular,
          //             size: size.convert(context, 25),
          //             color: Colors.white,
          //           ),
          //           MenuTextStyle(
          //             text: "Hub",
          //             color: Colors.white,
          //           ),
          //         ],
          //       ),
          //     ),
          //     toggleButton(
          //       value: applicatonState.isHubActive,
          //       enableColor: AppBarStartColor,
          //       disableColor: Colors.white,
          //       buttonWidth: size.convertWidth(context, 50),
          //       onChange: (value) {
          //         print("$value");
          //         showDialog(
          //             context: context,
          //             barrierColor: Colors.transparent,
          //             builder: (context) => ConfirmationAlerts(
          //                   deviceService: deviceService,
          //                   value: value,
          //                   Action: "hub",
          //                 ));
          //       },
          //     ),
          //   ],
          // ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: ApplicationSizing.convertWidth(20),
            right: ApplicationSizing.convertWidth(20),
            top: ApplicationSizing.convert(10),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: Home(), type: PageTransitionType.fade));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FluentSystemIcons.ic_fluent_badge_regular,
                      size: ApplicationSizing.convert(25),
                      color: appColor,
                    ),
                    MenuTextStyle(
                      text: "Home",
                    ),
                  ],
                ),
              ),
              Platform.isIOS
                  ? Container()
                  : InkWell(
                      onTap: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          Navigator.pop(context);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FluentSystemIcons.ic_fluent_dismiss_regular,
                            size: ApplicationSizing.convert(25),
                            color: appColor,
                          ),
                          MenuTextStyle(
                            text: "Exit",
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  // facilityUserMenu(
  //     context, DeviceService deviceService, ApplicatonState applicatonState) {
  //   Color UnSelectedColor = Color(0xff134389);
  //   return Column(
  //     children: [
  //       Container(
  //         margin: EdgeInsets.only(
  //           left: size.convertWidth(context, 20),
  //           right: size.convertWidth(context, 20),
  //           top: size.convertWidth(context, 10),
  //         ),
  //         child: Column(
  //           children: [
  //             InkWell(
  //               onTap: () {
  //                 applicatonState.updateSelectedTabI(0);
  //                 Navigator.pushReplacement(
  //                     context,
  //                     PageTransition(
  //                         child: ChatListScreen(),
  //                         type: PageTransitionType.fade));
  //               },
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Icon(
  //                     FluentSystemIcons.ic_fluent_badge_regular,
  //                     size: size.convert(context, 25),
  //                     color: appColor,
  //                   ),
  //                   MenuTextStyle(
  //                     text: "Home",
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             InkWell(
  //               onTap: () {
  //                 showDialog(
  //                     context: context,
  //                     barrierColor: Colors.transparent,
  //                     builder: (context) => ConfirmationAlerts(
  //                           Action: "logout",
  //                         ));
  //               },
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Icon(
  //                     FluentSystemIcons.ic_fluent_power_regular,
  //                     size: size.convert(context, 25),
  //                     color: appColor,
  //                   ),
  //                   MenuTextStyle(
  //                     text: "Logout",
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Platform.isIOS ? Container(): InkWell(
  //               onTap: () {
  //                 if (Platform.isAndroid) {
  //                   SystemNavigator.pop();
  //                 } else if (Platform.isIOS) {
  //                   Navigator.pop(context);
  //                 }
  //               },
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Icon(
  //                     FluentSystemIcons.ic_fluent_dismiss_regular,
  //                     size: size.convert(context, 25),
  //                     color: appColor,
  //                   ),
  //                   MenuTextStyle(
  //                     text: "Exit",
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
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

//  ConfirmationAlert(context, DeviceService deviceService,{String message,String event}) {
//   // Navigator.pop(context);
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: Container(
//             padding: EdgeInsets.symmetric(
//                 horizontal: size.convertWidth(context, 15)),
//             height: size.convert(context, size.convert(context, 157)),
//             width: size.convertWidth(context, 334),
//             child: Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: size.convert(context, 26),
//                 ),
//                 Text(
//                   "Alert",
//                   style:
//                       style.RobotoRegular(fontSize: size.convert(context, 15)),
//                 ),
//                 SizedBox(
//                   height: size.convert(context, 18),
//                 ),
//                 Text(
//                   message??"Are you sure, you want Logout?",
//                   style:
//                       style.RobotoRegular(fontSize: size.convert(context, 15)),
//                 ),
//                 SizedBox(
//                   height: size.convert(context, 24),
//                 ),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                             if(event!=null){
//                               if(event=="reset" || event =="Reset"){
//                                 deviceService.ResetPairedDevice();
//                               }
//                             }
//                             else{
//                               print("press Confirm Logout");
//                               var firebaseMessaging = FirebaseMessaging.instance;
//                               firebaseMessaging
//                                   .unsubscribeFromTopic(
//                                   "${deviceService.currentUser.appUserId}-NewDataReceived")
//                                   .then((value) => null);
//                               firebaseMessaging
//                                   .unsubscribeFromTopic(
//                                   "${deviceService.currentUser.appUserId}-NewMsgReceived")
//                                   .then((value) => null);
//                               SharedPref().logoutPref();
//                               Navigator.pushAndRemoveUntil(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (BuildContext context) => SignInPage(),
//                                 ),
//                                     (route) => false,
//                               );
//                             }
//
//                             //Navigator.pushReplacement(context, PageTransition(child: SignInPage(), type: PageTransitionType.fade));
//                           },
//                           child: Container(
//                             width: size.convertWidth(context, 87),
//                             height: size.convert(context, 35),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                     size.convert(context, 5)),
//                                 border: Border.all(width: 1, color: appColor)),
//                             child: Center(
//                               child: Text(
//                                 "Yes",
//                                 style: style.RobotoRegular(
//                                     fontSize: size.convert(context, 15)),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: size.convertWidth(context, 26),
//                       ),
//                       Container(
//                         child: InkWell(
//                           onTap: () {
//                             print("press No Logout");
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             width: size.convertWidth(context, 87),
//                             height: size.convert(context, 35),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                     size.convert(context, 5)),
//                                 border: Border.all(width: 1, color: appColor)),
//                             child: Center(
//                               child: Text(
//                                 "No",
//                                 style: style.RobotoRegular(
//                                     fontSize: size.convert(context, 15)),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       });
// }

// ConfirmationAlert(context,
//     {DeviceService deviceService,
//     int index,
//     ApplicatonState appState,
//     GlobalKey<ScaffoldState> scaffoldkey,
//     String message,
//     String event}) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Container(
//             padding: EdgeInsets.all(size.convert(context, 20)),
//             // height: size.convert(context, size.convert(context, 160)),
//             width: double.minPositive,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       FluentSystemIcons.ic_fluent_error_circle_regular,
//                       size: size.convert(context, 30),
//                       color: Colors.red,
//                     ),
//                     SizedBox(
//                       height: size.convert(context, 5),
//                     ),
//                     Text(
//                       "Alert",
//                       textAlign: TextAlign.center,
//                       style: style.RobotoMedium(
//                           fontSize: size.convert(context, 16)),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: size.convert(context, 18),
//                 ),
//                 Text(
//                   message ?? "Are you sure, you want delete device?",
//                   textAlign: TextAlign.center,
//                   style:
//                       style.RobotoRegular(fontSize: size.convert(context, 15)),
//                 ),
//                 SizedBox(
//                   height: size.convert(context, 24),
//                 ),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         child: GestureDetector(
//                           onTap: () async {
//                             Navigator.pop(context);
//                             if (event != null) {
//                               if (event == "reset" || event == "Reset") {
//                                 deviceService.ResetPairedDevice();
//                               }
//                               if (event == "logout" || event == "Logout") {
//                                 print("press Confirm Logout");
//
//
//                               }
//                             } else {
//                               appState.SetStateForDeleteDevice(index);
//                               print("press Confirm Logout");
//                               bool isDelete =
//                                   await deviceService.RemoveDeviceWithId(
//                                       showSnackbarForError: false,
//                                       scaffold: scaffoldkey,
//                                       context: context,
//                                       DeviceId: deviceService
//                                           .pairedDevices[index].id);
//                               print("is delete $isDelete}");
//                               if (isDelete) {
//                                 deviceService.DeleteDevicesFromSharedPrefByMac(
//                                     deviceService
//                                         .pairedDevices[index].macAddress);
//                                 // await deviceService.getDashBoardDevices(
//                                 //     context: context);
//                                 appState.SetStateForDeleteDevice(-1);
//                                 // Navigator.pop(context);
//                               } else {
//                                 deviceService.DeleteDevicesFromSharedPrefByMac(
//                                     deviceService
//                                         .pairedDevices[index].macAddress);
//                                 appState.SetStateForDeleteDevice(-1);
//                                 // Navigator.pop(context);
//                               }
//                             }
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: size.convert(context, 30),
//                                 vertical: size.convert(context, 10)),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                     size.convert(context, 5)),
//                                 color: Colors.red.shade500),
//                             child: Center(
//                               child: Text(
//                                 "Yes",
//                                 style: style.RobotoRegular(
//                                     fontSize: size.convert(context, 15),
//                                     color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: size.convertWidth(context, 15),
//                       ),
//                       Container(
//                         child: InkWell(
//                           onTap: () {
//                             print("press No Logout");
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: size.convert(context, 30),
//                                 vertical: size.convert(context, 10)),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                     size.convert(context, 5)),
//                                 border:
//                                     Border.all(width: 1, color: Colors.white),
//                                 color: Colors.grey.shade300),
//                             child: Center(
//                               child: Text(
//                                 "No",
//                                 style: style.RobotoRegular(
//                                     fontSize: size.convert(context, 15)),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       });
// }
