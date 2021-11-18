import 'dart:io';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
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
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
import 'package:twochealthcare/views/chat/components/chat_input_field.dart';
import 'package:twochealthcare/views/chat/components/message.dart';

ScrollController? _scrollController;


class ChatScreen extends HookWidget {
  GetGroupsModel? getGroupsModel;
  ChatScreen({this.getGroupsModel});
  @override
  Widget build(BuildContext context) {
    _scrollController = useScrollController();
    ChatScreenVM chatScreenVM = useProvider(chatScreenVMProvider);
    useEffect(
      () {

        // chatService.initSigalR(token: deviceService?.currentUser?.bearerToken??"",appId: deviceService?.currentUser?.appUserId??"");
        Future.microtask(() async {
          chatScreenVM.chatGroupId = getGroupsModel?.id.toString();
              jumpToListIndex(isDelayed: true);
              chatScreenVM.loadingPageNumber = 1;
              chatScreenVM.getAllMessages(
                chatGroupId: getGroupsModel?.id.toString()??"",
                pageNumber: 1);
        });
        // _scrollController = ScrollController();
        _scrollController?.addListener(_scrollListener);

        // _scrollController.jumpTo(_scrollController.position.maxScrollExtent); i am trying

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
      // backgroundColor: Colors.black,
      // drawerScrimColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
        child: CustomAppBar(
          color1: AppBarStartColor,
          color2: AppBarEndColor,
          // clickOnDrawer: () {
          //   _scaffoldkey.currentState.openDrawer();
          // },
          leadingIcon: Row(
            children: [
              SizedBox(
                width: ApplicationSizing.convertWidth(5),
              ),
              CircularImage(
                ontap: () {
                  // Navigator.push(context, PageTransition(child: PatientProfile(), type: PageTransitionType.fade));
                },
                color: Colors.blueAccent,
                h: ApplicationSizing.convert(30),
                w: ApplicationSizing.convert(30),
                imageUrl: "assets/icons/personIcon.png",
                assetImage: true,
              ),
              SizedBox(width: ApplicationSizing.convertWidth(10),),
              AppBarTextStyle(
                text: getGroupsModel?.title??"Text",
                textsize: ApplicationSizing.convert(14),
              ),
            ],
          ),
          trailingIcon: GestureDetector(
              onTap: () async {
                // showBottomModel(listOfItem: listOfParticepant(context,participants: chatService.selectedChatGroup.participants,callingViewModel: callingViewModel));
              },
              child: Icon(Icons.call)),
          hight: ApplicationSizing.convert(90),
          parentContext: context,
        ),
      ),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(size.convert(context, 50)),
      //   child: buildAppBar(context, chatService: chatService),
      // ),
      body: RefreshIndicator(
        displacement: 10,
        backgroundColor: Colors.white,
        color: appColor,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () => chatScreenVM.getAllMessages(chatGroupId: getGroupsModel?.id.toString()??"",pageNumber: chatScreenVM.loadingPageNumber),
        child: _body(context,chatScreenVM: chatScreenVM),
      ),
      // body: _body(context,chatScreenVM: chatScreenVM),
      // body: test(),
    );
  }

  _body(context,{required ChatScreenVM chatScreenVM}) {
    String date = "";
    return (!chatScreenVM.allMessagesLoading && chatScreenVM.chatMessageList.length == 0)
        ? NoData()
        : Stack(
          children: [
            Column(
                children: [
                  Expanded(
                    child: Container(
                        // margin: EdgeInsets.symmetric(
                        //   vertical: size.convert(context, 150)
                        // ),
                        // color: Colors.blueGrey,
                        // padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: ListView.builder(
                            // reverse: true,
                            // itemExtent: 50.0,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: chatScreenVM.chatMessageList.length,
                            itemBuilder: (context, index) {
                              if (date != chatScreenVM.chatMessageList[index].timeStamp?.substring(0, 10))
                                {
                                date = chatScreenVM.chatMessageList[index].timeStamp!.substring(0, 10);
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: ApplicationSizing.convertWidth(20)),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: ApplicationSizing.convert(10)),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ApplicationSizing.convertWidth(10),
                                          vertical: ApplicationSizing.convert(5),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Text(
                                          "$date",
                                          style: Styles.PoppinsRegular(
                                              color: drawerColor,
                                              fontSize: ApplicationSizing.convert(14)),
                                        ),
                                      ),
                                      Message(
                                        message: chatScreenVM.chatMessageList[index],
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
                                      horizontal: ApplicationSizing.convertWidth(20)),
                                  child: Column(
                                    children: [
                                      Message(
                                        message: chatScreenVM.chatMessageList[index],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                  ),
                  Container(
                    height: ApplicationSizing.convert(70),
                      child: ChatInputField()),
                ],
              ),
            chatScreenVM.allMessagesLoading ? AlertLoader() : Container(),
          ],
        );
  }

  _scrollListener() {
    if (_scrollController!.offset >=
            _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      print("out of range");
    }
    if (_scrollController!.offset <=
            _scrollController!.position.minScrollExtent &&
        !_scrollController!.position.outOfRange) {
      print("In of range");
      // chatService.loadingNewPage
      //     ? null
      //     : chatService.GetAllMessage(context,
      //         UserId: deviceService?.currentUser?.appUserId ?? "",
      //         token: deviceService?.currentUser?.bearerToken ?? "",
      //         pageNumber: chatService.ChatCurrentPage);
    }
  }

  jumpToListIndex({bool isDelayed = false}) {
    print("this is jump function");
    // _scrollController.;
    // _scrollController.jumpTo()
    Future.delayed(Duration(seconds: isDelayed ? 1 : 0),(){
      _scrollController!.animateTo(
        // 0.0,
        _scrollController!.position.maxScrollExtent,
        curve: Curves.linearToEaseOut,
        duration: const Duration(milliseconds: 300),
      );
      // chatService.notifyListeners();
    });

  }

  Widget listOfParticepant(context,
      // {List<Participants> participants,videoCallingViewModel  callingViewModel}
      ){
    return Container(
      margin: EdgeInsets.only(top: ApplicationSizing.convert(20)),
      // child: participants.length > 0 ?
          child: true ? ListView.separated(
            shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context,index){
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.convertWidth(25)),
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
                          SizedBox(width: ApplicationSizing.convertWidth(10),),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "{participants[index].name}",
                                style: Styles.PoppinsRegular(fontSize: ApplicationSizing.convert(13),),
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
                            fluentSystemIcons: Icon(FluentSystemIcons.ic_fluent_video_regular,
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
                          SizedBox(width: ApplicationSizing.convertWidth(15),),
                          CircularSvgIcon(
                            iconSize: ApplicationSizing.convert(30),
                            // iconUrl: "assets/icons/call_end.svg",
                            padding: ApplicationSizing.convert(5),
                            bgColor: Color(0xfff3f2f7),
                            iconColor: Color(0xff0479fb),
                            fluentSystemIcons: Icon(FluentSystemIcons.ic_fluent_call_end_regular,
                            color: Color(0xff0479fb),
                              size: ApplicationSizing.convert(18),),
                          ),
                        ],
                      )),
                    ],
                  ),
                );
              },
              separatorBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.only(top: 8,bottom: 8,left: ApplicationSizing.convertWidth(70)),
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
