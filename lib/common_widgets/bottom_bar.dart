import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/red_dot.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/connectivity_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
import 'package:twochealthcare/view_models/home_vm.dart';
import 'package:twochealthcare/views/chat/chat_list.dart';
import 'package:twochealthcare/views/chat/chat_screen.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:twochealthcare/views/home/profile.dart';
import 'package:flutter/foundation.dart' as Foundation;

class BottomBar extends HookWidget {
  int selectedIndex;
  BottomBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectivityService connectivityService =
        useProvider(connectivityServiceProvider);
    HomeVM homeVM = useProvider(homeVMProvider);
    ApplicationRouteService applicationRouteService =
        useProvider(applicationRouteServiceProvider);
    ChatListVM chatScreenVM = useProvider(chatListVMProvider);
    OnLaunchActivityAndRoutesService onLaunchActivityService =
        useProvider(onLaunchActivityServiceProvider);
    ChatListVM chatListVM = useProvider(chatListVMProvider);

    useEffect(
      () {
        Future.microtask(() async {});
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return  BottomAppBar(
/// Customize Bottom app bar in plugin code remove safe
        color: appColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 9.0,
        elevation: 1,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: ApplicationSizing.horizontalMargin()),
          height: Platform.isIOS
              ? ApplicationSizing.convert(60)
              : ApplicationSizing.convert(60),
          // color: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (selectedIndex != 1) {
                      applicationRouteService.addAndRemoveScreen(
                          screenName: "Profile");
                      onLaunchActivityService.profileDecider();
                      print("do something on selected index $selectedIndex}");
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/icons/bottom_navbar/user-icon.svg",
                      height: ApplicationSizing.convert(25),
                    ),
                  ),
                ),
              ),
              ApplicationSizing.horizontalSpacer(n: 180),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () async {
                    if (selectedIndex != 2) {
                      if (connectivityService.connectionStatus ==
                          ConnectivityResult.none) {
                        SnackBarMessage(
                            message: "No internet connection detected, please try again.");
                      }
                      else {
                        var check = await homeVM.checkChatStatus();
                        print(
                            "this is application mode = ${Foundation.kDebugMode}");
                        if(check == -2){
                          SnackBarMessage(
                              message: "Chat disable for this user!");
                          return;
                        }
                        if (check is bool) {
                          if (check) {
                            if (chatListVM.groupIds.length == 1) {
                              applicationRouteService.addScreen(
                                  screenName: "${chatListVM.groupIds[0].id}");
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: ChatScreen(
                                        getGroupsModel: chatScreenVM.groupIds[0],
                                        backToHome: true,
                                      ),
                                      type: PageTransitionType.bottomToTop));
                            } else {
                              applicationRouteService.addAndRemoveScreen(
                                  screenName: "ChatList");

                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: ChatList(),
                                      type: PageTransitionType.bottomToTop));
                            }
                          } else {
                            SnackBarMessage(
                                message: "Chat disable for this user!");
                          }
                        } else {
                          SnackBarMessage(message: "Some thing went wrong!");
                        }
                      }
                      print("do something on selected index $selectedIndex}");
                    }
                  },
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        // color: Colors.red,
                        alignment: Alignment.center,

                        child: SvgPicture.asset(
                          "assets/icons/bottom_navbar/message-icon.svg",
                          height: ApplicationSizing.convert(25),
                        ),
                      ),
                      chatScreenVM.unReadChats.length == 0
                          ? Container()
                          : Positioned(
                              top: 10,
                              child: RedDot(),
                            )
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

// class BottomBarPaint extends CustomPainter{
//   @override
//   void paint(Canvas canvas, Size size) {
//     // TODO: implement paint
//     Paint paint = Paint()..color = Colors.green..style = PaintingStyle.fill;
//      Path path = Path()..moveTo(0, 0);
//      path.quadraticBezierTo(0, 0, size.width*0.40, 0);
//      path.quadraticBezierTo(size.width*0.35, 0, size.width*0.40, 0);
//      path.arcToPoint(Offset(size.width*0.60,0),radius: Radius.circular(10),
//      clockwise: false);
//     path.quadraticBezierTo(size.width*0.60, 0, size.width*0.65, 0);
//     path.quadraticBezierTo(size.width*0.80, 0, size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     canvas.drawShadow(path, Colors.transparent, 4, false);
//     canvas.drawPath(path,paint);
//
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw false;
//   }
//
// }
