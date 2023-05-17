import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/chat_model/GetGroups.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_group_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/views/chat/chat_screen.dart';
import 'package:twochealthcare/views/chat/components/slider_menu.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:twochealthcare/views/home/profile.dart';

class ChatList extends HookWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatListVM chatListVM = useProvider(chatListVMProvider);
    ApplicationRouteService applicationRouteService =
        useProvider(applicationRouteServiceProvider);
    OnLaunchActivityAndRoutesService onLaunchActivityService = useProvider(onLaunchActivityServiceProvider);
    LoginVM loginVM = useProvider(loginVMProvider);
    useEffect(
      () {
        Future.microtask(() async {
          chatListVM.loadingPageNumber = 1;
          chatListVM.getPatientGroupByFacilityId(pageNumber : 1);
          chatListVM.getChatSummaryDataByFacilityId();
        });

        return () {
          applicationRouteService.removeScreen(screenName: "ChatList");
          // Dispose Objects here
        };
      },
      const [],
    );
    return (chatListVM.isTextFieldActive) ? simpleScaffold(context,chatListVM: chatListVM,loginVM: loginVM,applicationRouteService: applicationRouteService) :
    Scaffold(
        primary: false,
        appBar: appBar(context,loginVM,chatListVM: chatListVM),
        floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.black,
          // child: SvgPicture.asset(
          //   "assets/icons/bottom_navbar/user-icon.svg",
          //   height: ApplicationSizing.convert(25),
          // ),
          child: Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(15),
            child: SvgPicture.asset(
              "assets/icons/side_menu/home-icon.svg",
              height: ApplicationSizing.convert(25),
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0Xff4EAF48), Color(0xff388333)],
                )),
          ),
          onPressed: () {
            applicationRouteService.removeAllAndAdd(screenName: "Home");
            onLaunchActivityService.HomeDecider();
            // Navigator.pushReplacement(
            //     context,
            //     PageTransition(
            //       child: Home(),
            //       type: PageTransitionType.bottomToTop,
            //     ));
          },
        ),
        bottomNavigationBar: BottomBar(
          selectedIndex: 2,
        ),
        body: _body(
            chatListVM: chatListVM,
            applicationRouteService: applicationRouteService,
        loginVM: loginVM));
  }

  appBar(context,LoginVM loginVM,{required ChatListVM chatListVM}){
    return PreferredSize(
      preferredSize: Size.fromHeight(ApplicationSizing.convert(90)),
      child: CustomAppBar(
        facilityIcon: (loginVM.currentUser?.userType == 1) ? false : true,
        // leadingIcon: Container(),
        color1: Colors.white,
        color2: Colors.white,
        hight: ApplicationSizing.convert(70),
        parentContext: context,
        centerWigets: Container(
          // color: Colors.red,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBarTextStyle(
                  text: "Chat List",
                ),
              //   SizedBox(width: 5,),
              // chatListVM.unReadChats.length < 1 ? Container() :
              // Container(
              //
              //   alignment: Alignment.center,
              //   padding: EdgeInsets.all(3),
              //   margin: EdgeInsets.only(bottom: 5),
              //   child: Text(
              //     "${chatListVM.unReadChats.length}",
              //     style: Styles.PoppinsRegular(
              //         fontWeight: FontWeight.w400,
              //         fontSize: ApplicationSizing.fontScale(10),
              //         color: Colors.white),
              //     maxLines: 1,
              //   ),
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle, color: appColor),
              // )
            ],
          ),
        ),
        // chatListVM.searchedGroup
        //     ? _searchField(chatListVM: chatListVM)
        //     : AppBarTextStyle(
        //         text: "Chat List",
        //       ),
        // trailingIcon: InkWell(
        //   onTap: chatListVM.onClickSearch,
        //   child: Icon(
        //     chatListVM.searchedGroup ? Icons.cancel : Icons.person_search,
        //     color: appColor,
        //     size: 27,
        //   ),
        // ),
      ),
    );
  }

  simpleScaffold(context,{ required ChatListVM chatListVM,required LoginVM loginVM,required ApplicationRouteService applicationRouteService}){
    return Scaffold(
        primary: false,
        appBar: appBar(context,loginVM,chatListVM: chatListVM),

        bottomNavigationBar: BottomBar(
          selectedIndex: 2,
        ),
        body: _body(
            chatListVM: chatListVM,
            applicationRouteService: applicationRouteService,
            loginVM: loginVM));
  }

  _emptyChat() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Coming Soon...11",
              style: Styles.PoppinsRegular(
                fontWeight: FontWeight.w500,
                color: appColor,
                fontSize: ApplicationSizing.fontScale(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _searchField({
     ChatListVM? chatListVM,
  }) {
    return  Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(),vertical: 10),
          height: 50,
          child: CustomTextField(
            onchange: chatListVM!.onGroupSearch,
            checkFocus: chatListVM.checkFocus,
            onSubmit: (val){},
            hints: "Search Group",

          ));
  }

  _body(
      {ChatListVM? chatListVM,
      required ApplicationRouteService applicationRouteService,required LoginVM loginVM}) {
    return Column(
      children: [
        (loginVM.currentUser?.userType == 1) ? Container() :
        Container(height : 40,child: ChatSlider(menuList: chatListVM?.chatTypeList??[], onchange: chatListVM?.onChatFilterChange?? (Menu){},)),
        // (loginVM.currentUser?.userType == 1) ? Container() : _searchField(chatListVM: chatListVM),
        SizedBox(height: 20,),
        Expanded(child: (chatListVM?.chatGroupList.length == 0 && !chatListVM!.loadingChatList)
            ? NoData()
            : Container(
          child: Stack(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        applicationRouteService.addScreen(
                            screenName: ScreenName.chatHistory);
                        Navigator.push(
                            context,
                            PageTransition(
                                child: ChatScreen(
                                  // getGroupsModel: chatListVM?.chatGroupList[index],
                                  patientId: chatListVM?.chatGroupList[index].lastCommunication!.patientId!,
                                  messageTitle: chatListVM?.chatGroupList[index].name,
                                ),
                                type: PageTransitionType.fade));
                      },
                      child: chatTile(
                          getGroupsModel: chatListVM?.chatGroupList[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return ApplicationSizing.verticalSpacer();
                  },
                  itemCount: chatListVM?.chatGroupList.length ?? 0),
              chatListVM!.loadingChatList ? AlertLoader() : Container(),

            ],
          ),
        ),
        ),
      ],
    );
  }

  chatTile({ChatGroupModel? getGroupsModel}) {
    return Container(
      // color: Colors.brown,
      padding: EdgeInsets.symmetric(
        horizontal: ApplicationSizing.horizontalMargin(),
      ),
      // padding: EdgeInsets.only(left: 15, right: 15, bottom: 0),
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(width: 1.0, color: Colors.black12),
      //   ),
      //   color: Colors.white,
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularImage(
            h: 45,
            w: 45,
            imageUrl: "assets/icons/personIcon.png",
            assetImage: true,
          ),
          ApplicationSizing.horizontalSpacer(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0),
              // alignment: Alignment.topLeft,
              // color: Colors.green,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                            // color: Colors.red,
                            child: Text(
                          getGroupsModel?.name ?? "",
                          style: Styles.PoppinsRegular(
                              fontWeight: FontWeight.w400,
                              fontSize: ApplicationSizing.fontScale(14)),
                          maxLines: 1,
                        )),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                            // color: Colors.brown,

                            alignment: Alignment.centerRight,
                            // color: Colors.pink,
                            child: Text(
                              getGroupsModel?.lastCommunication?.timeStamp ?? "",
                              style: Styles.PoppinsRegular(
                                  fontWeight: FontWeight.w400,
                                  fontSize: ApplicationSizing.fontScale(11),
                                  color: appColor),
                              maxLines: 1,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          // color: Colors.red,
                          padding: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black12),
                            ),
                            // color: Colors.white,
                          ),
                          child: Text(
                            getGroupsModel?.lastCommunication?.message ?? "",
                            style: Styles.PoppinsRegular(
                              fontWeight: FontWeight.w400,
                              fontSize: ApplicationSizing.fontScale(12),
                              color: fontGrayColor,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      // getGroupsModel?.unreadMsgCount == 0
                      //     ? Container()
                      //     : Expanded(
                      //         flex: 0,
                      //         child: Container(
                      //           alignment: Alignment.center,
                      //           padding: EdgeInsets.all(5),
                      //           child: Text(
                      //             "${getGroupsModel?.unreadMsgCount ?? ""}",
                      //             style: Styles.PoppinsRegular(
                      //                 fontWeight: FontWeight.w400,
                      //                 fontSize: ApplicationSizing.fontScale(10),
                      //                 color: Colors.white),
                      //             maxLines: 1,
                      //           ),
                      //           decoration: BoxDecoration(
                      //               shape: BoxShape.circle, color: appColor),
                      //         )
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}





