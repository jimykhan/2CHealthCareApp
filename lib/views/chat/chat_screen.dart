import 'dart:io';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/circular_svg_icon.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/models/chat_model/GetGroups.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
import 'package:twochealthcare/views/chat/chat_info.dart';
import 'package:twochealthcare/views/chat/components/animation_mic.dart';
import 'package:twochealthcare/views/chat/components/audio_message.dart';
import 'package:twochealthcare/views/chat/components/chat_input_field.dart';
import 'package:twochealthcare/views/chat/components/message.dart';
import 'package:marquee/marquee.dart';

ScrollController? chatScrollController;

class ChatScreen extends HookWidget {
  GetGroupsModel? getGroupsModel;
  bool backToHome;
  ChatScreen({this.getGroupsModel,this.backToHome = false});
  @override
  Widget build(BuildContext context) {
    chatScrollController = useScrollController(initialScrollOffset: MediaQuery.of(context).size.height);
    ChatScreenVM chatScreenVM = useProvider(chatScreenVMProvider);
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);
    OnLaunchActivityAndRoutesService onLaunchActivityService = useProvider(onLaunchActivityServiceProvider);
    useEffect(

      () {
        chatScreenVM.initChatScreen();
        // chatService.initSigalR(token: deviceService?.currentUser?.bearerToken??"",appId: deviceService?.currentUser?.appUserId??"");
        Future.microtask(() async {
          chatScreenVM.chatGroupId = getGroupsModel?.id.toString();

          chatScreenVM.loadingPageNumber = 1;
          await chatScreenVM.getAllMessages(
              chatGroupId: getGroupsModel?.id.toString() ?? "", pageNumber: 1);
          jumpToListIndex(isDelayed: true);
        });
        chatScrollController?.addListener(_scrollListener);

        // chatScrollController?.jumpTo(chatScrollController?.position.maxScrollExtent??0.0);

        return () {
          chatScreenVM.dispose();
          applicationRouteService.removeScreen(screenName: "${getGroupsModel?.id}");
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
      primary: false,
      resizeToAvoidBottomInset : true,
      backgroundColor: Color(0xffFBFBFB),
      // backgroundColor: Colors.black,
      // drawerScrimColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
        child: CustomAppBar(
          color1: AppBarStartColor,
          color2: AppBarEndColor,
          leadingIcon: Row(
            children: [
              CustomBackButton(
                onclik: backToHome ? (){
                  applicationRouteService.removeAllAndAdd(screenName: "Home");
                  onLaunchActivityService.HomeDecider();
                } : null,
              ),
              SizedBox(
                width: ApplicationSizing.convertWidth(5),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, PageTransition(child: ChatInfo(title: getGroupsModel?.title ?? ""), type: PageTransitionType.leftToRight));
                },
                child: Row(
                  children: [
                    CircularImage(
                      ontap: () {
                        // Navigator.push(context, PageTransition(child: PatientProfile(), type: PageTransitionType.fade));
                      },
                      color: Colors.blueAccent,
                      h: ApplicationSizing.convert(35),
                      w: ApplicationSizing.convert(35),
                      imageUrl: "assets/icons/personIcon.png",
                      assetImage: true,
                    ),
                    SizedBox(
                      width: ApplicationSizing.convertWidth(10),
                    ),
                    AppBarTextStyle(
                        text: getGroupsModel?.title ?? "Text",
                        textsize: ApplicationSizing.convert(18)),
                  ],
                ),
              )
            ],
          ),
          // trailingIcon: GestureDetector(
          //     onTap: () async {
          //       // showBottomModel(listOfItem: listOfParticepant(context,participants: chatService.selectedChatGroup.participants,callingViewModel: callingViewModel));
          //     },
          //     child: Icon(Icons.call)),
          hight: ApplicationSizing.convert(90),
          parentContext: context,
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          return _onScrollNotification(scrollNotification);
        },
        child: _body(context, chatScreenVM: chatScreenVM),
      )
      ,
    );
  }
  bool _onScrollNotification (ScrollNotification scrollNotification) {
    // if (scrollNotification is ScrollUpdateNotification) {
    //   if(chatScrollController!.offset != chatScrollController!.position.maxScrollExtent)
    //   jumpToListIndex();
    //   // detect scroll position here
    //   // and set resizeToAvoidBottomInset to false if needed\
    //   return true;
    // }
    return false;
  }

  _body(context, {required ChatScreenVM chatScreenVM}) {
    String date = "";
    return Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: ApplicationSizing.constSize(24),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child:  Marquee(
                        text: 'This chat can not be used for emergency purposes. You may not get a response for extended period of time. Use 911 in case of emergency.',
                        style: Styles.PoppinsRegular(
                          fontSize: ApplicationSizing.constSize(15),
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                        ),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        blankSpace: 20.0,
                        velocity: 20.0,
                        pauseAfterRound: Duration(seconds: 1),
                        // startPadding: 10.0,
                        // accelerationDuration: Duration(seconds: 3),
                        accelerationCurve: Curves.linear,
                        // decelerationDuration: Duration(milliseconds: 2),
                        decelerationCurve: Curves.easeOut,
                      ),
                    ),

                  Expanded(
                    child:RefreshIndicator(
                      displacement: 10,
                      backgroundColor: Colors.white,
                      color: appColor,
                      strokeWidth: 3,
                      triggerMode: RefreshIndicatorTriggerMode.onEdge,
                      onRefresh: () => chatScreenVM.getAllMessages(
                          chatGroupId: getGroupsModel?.id.toString() ?? "",
                          pageNumber: chatScreenVM.loadingPageNumber),
                      child: ListView.separated(
                        controller: chatScrollController,
                        // reverse: true,
                        // itemExtent: 50.0,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: chatScreenVM.chatMessageList.chats?.length??0,
                        itemBuilder: (context, index) {
                          if (date !=
                              chatScreenVM.chatMessageList.chats![index].timeStamp
                                  ?.substring(0, 10)) {
                            date = chatScreenVM
                                .chatMessageList.chats![index].timeStamp!
                                .substring(0, 10);
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                  ApplicationSizing.convertWidth(20)),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ApplicationSizing.convert(10)),
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                      ApplicationSizing.convertWidth(10),
                                      vertical: ApplicationSizing.convert(5),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Text(
                                      Jiffy(chatScreenVM.chatMessageList.chats![index].timeStamp??"0000-00-00T00:00:00.000000").format("dd MMM yyyy"),
                                      style: Styles.PoppinsRegular(
                                          color: drawerColor,
                                          fontSize:
                                          ApplicationSizing.convert(14)),
                                    ),
                                  ),
                                  Message(
                                    message:
                                    chatScreenVM.chatMessageList.chats![index],
                                    participients: chatScreenVM.chatMessageList.participients,
                                    index: index,
                                  ),
                                ],
                              ),
                            );
                            // date = chatService.listOfMessage[index].timeStamp
                            //     .substring(0, 10);
                            // print(date.toString());
                          } else {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                  ApplicationSizing.convertWidth(20)),
                              child: Column(
                                children: [
                                  Message(
                                    message: chatScreenVM.chatMessageList.chats![index],
                                    participients: chatScreenVM.chatMessageList.participients,
                                    index: index,
                                  ),
                                ],
                              ),
                            );
                          }
                        }, separatorBuilder: (BuildContext context, int index) { return ApplicationSizing.verticalSpacer(n: 0); },
                      ),
                    ),
                  ),
                  Container(
                      child: ChatInputField(),
                    padding: EdgeInsets.only(bottom: Platform.isIOS ? 15 : 0),
                  ),
                ],
              ),
              chatScreenVM.allMessagesLoading ? AlertLoader() : Container(),
            ],
          );
  }

  _scrollListener() {
    if (chatScrollController!.offset >=
            chatScrollController!.position.maxScrollExtent &&
        !chatScrollController!.position.outOfRange) {
      print("out of range");
    }
    if (chatScrollController!.offset <=
            chatScrollController!.position.minScrollExtent &&
        !chatScrollController!.position.outOfRange) {
      print("In of range");
      // chatService.loadingNewPage
      //     ? null
      //     : chatService.GetAllMessage(context,
      //         UserId: deviceService?.currentUser?.appUserId ?? "",
      //         token: deviceService?.currentUser?.bearerToken ?? "",
      //         pageNumber: chatService.ChatCurrentPage);
    }
  }

  static jumpToListIndex({bool isDelayed = false}) {
    print("this is jump function");
    Future.delayed(Duration(seconds: isDelayed ? 1 : 0), () {
      chatScrollController!.jumpTo(
        chatScrollController!.position.maxScrollExtent,
        // duration: Duration(microseconds: 3),
        // curve: Curves.ease,
      );
    });
  }

  Widget listOfParticepant(
    context,
    // {List<Participants> participants,videoCallingViewModel  callingViewModel}
  ) {
    return Container(
      margin: EdgeInsets.only(top: ApplicationSizing.convert(20)),
      // child: participants.length > 0 ?
      child: true
          ? ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ApplicationSizing.convertWidth(25)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              CircularImage(
                                ontap: () {
                                  // Navigator.push(context, PageTransition(child: PatientProfile(), type: PageTransitionType.fade));
                                },
                                color: Colors.white,
                                h: ApplicationSizing.convert(30),
                                w: ApplicationSizing.convert(30),
                                imageUrl: "assets/icons/personIcon.png",
                                assetImage: true,
                              ),
                              SizedBox(
                                width: ApplicationSizing.convertWidth(10),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "{participants[index].name}",
                                    style: Styles.PoppinsRegular(
                                      fontSize: ApplicationSizing.convert(13),
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircularSvgIcon(
                                iconSize: ApplicationSizing.convert(30),
                                iconUrl: "assets/icons/Icon_Video.svg",
                                padding: ApplicationSizing.convert(5),
                                bgColor: Color(0xfff3f2f7),
                                fluentSystemIcons: Icon(
                                  FluentSystemIcons.ic_fluent_video_regular,
                                  color: Color(0xff0479fb),
                                  size: ApplicationSizing.convert(18),
                                ),
                                ontap: () async {
                                  // await callingViewModel.initCalling(calleeId: participants[index]?.appUserId??"");
                                  // Future.delayed(Duration(milliseconds: 500),(){
                                  //   Navigator.pushReplacement(context, PageTransition(child: videoCallingScreen(calleeName: participants[index]?.name??"",), type: PageTransitionType.fade));
                                  // });
                                },
                              ),
                              SizedBox(
                                width: ApplicationSizing.convertWidth(15),
                              ),
                              CircularSvgIcon(
                                iconSize: ApplicationSizing.convert(30),
                                // iconUrl: "assets/icons/call_end.svg",
                                padding: ApplicationSizing.convert(5),
                                bgColor: Color(0xfff3f2f7),
                                iconColor: Color(0xff0479fb),
                                fluentSystemIcons: Icon(
                                  FluentSystemIcons.ic_fluent_call_end_regular,
                                  color: Color(0xff0479fb),
                                  size: ApplicationSizing.convert(18),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: ApplicationSizing.convertWidth(70)),
                  color: Colors.grey.withOpacity(0.5),
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                );
              },
              itemCount: 10)
          : Container(),
    );
  }
}
