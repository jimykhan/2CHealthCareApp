import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/chat_model/GetGroups.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/connectivity_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
import 'package:twochealthcare/views/chat/components/chat_input_field.dart';
import 'package:twochealthcare/views/chat/components/message.dart';
import 'package:marquee/marquee.dart';
import 'package:twochealthcare/views/chat/components/recording_button.dart';

ScrollController? chatScrollController;

class ChatScreen extends HookWidget {
  String? messageTitle;
  GetGroupsModel? getGroupsModel;
  bool backToHome;
  int? patientId;
  ChatScreen({this.getGroupsModel,this.backToHome = false,this.patientId,this.messageTitle});
  @override
  Widget build(BuildContext context) {
    LoginVM loginVM = useProvider(loginVMProvider);
    chatScrollController = useScrollController(initialScrollOffset: MediaQuery.of(context).size.height);
    ChatScreenVM chatScreenVM = useProvider(chatScreenVMProvider);
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);
    OnLaunchActivityAndRoutesService onLaunchActivityService = useProvider(onLaunchActivityServiceProvider);
    ConnectivityService connectivityService =
    useProvider(connectivityServiceProvider);
    useEffect(

      () {
        chatScreenVM.chatGroupId = getGroupsModel?.id.toString();
        chatScreenVM.patientId = patientId;

        // chatService.initSigalR(token: deviceService?.currentUser?.bearerToken??"",appId: deviceService?.currentUser?.appUserId??"");
        Future.microtask(() async {
          chatScreenVM.loadingPageNumber = 1;
          await chatScreenVM.getAllMessages(patientId: patientId, pageNumber: 1);
          jumpToListIndex(isDelayed: true);
          // chatScreenVM.getPeriodicMessage(patientId: patientId);
        });
        chatScrollController?.addListener(_scrollListener);

        // chatScrollController?.jumpTo(chatScrollController?.position.maxScrollExtent??0.0);

        return () {
          chatScreenVM.dispose();
          applicationRouteService.removeScreen(screenName: ScreenName.chatHistory);
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
                  // Navigator.push(context, PageTransition(child: ChatInfo(title: getGroupsModel?.title ?? ""), type: PageTransitionType.leftToRight));
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
                          text: messageTitle ?? loginVM.currentUser?.fullName ?? "Text",
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
        child: _body(context, chatScreenVM: chatScreenVM,connectivityService: connectivityService),
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

  _body(context, {required ChatScreenVM chatScreenVM, required ConnectivityService connectivityService}) {
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
                          patientId: patientId,
                          pageNumber: chatScreenVM.loadingPageNumber),
                      child: ListView.separated(
                        controller: chatScrollController,
                        // reverse: true,
                        // itemExtent: 50.0,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: chatScreenVM.communicationHistoryModel.results?.length??0,
                        itemBuilder: (context, index) {
                          if (date !=
                              chatScreenVM.communicationHistoryModel.results![index].timeStamp
                                  ?.substring(0, 10)) {
                            date = chatScreenVM
                                .communicationHistoryModel.results![index].timeStamp!
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
                                      Jiffy(chatScreenVM.communicationHistoryModel.results![index].timeStamp??"0000-00-00T00:00:00.000000").format("dd MMM yyyy"),
                                      style: Styles.PoppinsRegular(
                                          color: drawerColor,
                                          fontSize:
                                          ApplicationSizing.convert(14)),
                                    ),
                                  ),
                                  Message(
                                    message:
                                    chatScreenVM.communicationHistoryModel.results![index],
                                    // participients: chatScreenVM.chatMessageList.participients,
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
                                    message: chatScreenVM.communicationHistoryModel.results![index],
                                    // participients: chatScreenVM.chatMessageList.participients,
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
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.only(bottom: Platform.isIOS ? 10 : 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                              child: chatScreenVM.isRecording ? Container() : ChatInputField(),
                          ),

                        ),
                        // RecordButton(chatScreenVM: chatScreenVM,),
                        // GestureDetector(
                        //   onLongPressStart: (long){
                        //     chatScreenVM.startRecording();
                        //   },
                        //   onLongPressEnd: (end) async{
                        //     String fileUrl = await chatScreenVM.endRecording();
                        //     if (connectivityService.connectionStatus == ConnectivityResult.none) {
                        //       SnackBarMessage(message: "No internet connection detected, please try again.");
                        //     } else {
                        //       await chatScreenVM.sendTextMessage(
                        //           fileUrl: fileUrl,
                        //           chatMessageType: ChatMessageType.audio
                        //       );
                        //       ChatScreen.jumpToListIndex();
                        //       print("work");
                        //     }
                        //   },
                        //   // onTap: chatScreenVM.startRecording,
                        //   // onFocusChange: chatScreenVM.endRecording,
                        //   child: Container(
                        //     padding: EdgeInsets.all(6),
                        //     decoration: BoxDecoration(
                        //         color: appColor,
                        //         shape: BoxShape.circle
                        //     ),
                        //     child: Icon(Icons.mic_none,color: Colors.white,),
                        //   ),
                        // ),
                      ],
                    ),
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
