import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/common_widgets/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/bottom_bar.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/no_data_inlist.dart';
import 'package:twochealthcare/common_widgets/notification_widget.dart';
import 'package:twochealthcare/models/chat_model/GetGroups.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/views/chat/chat_screen.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:twochealthcare/views/home/profile.dart';
class ChatList extends HookWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatListVM chatListVM = useProvider(chatListVMProvider);
    useEffect(
          () {
        Future.microtask(() async {
          chatListVM.getGroupsIds();
        });

        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(ApplicationSizing.convert(80)),
          child: CustomAppBar(
            leadingIcon: Container(),
            color1: Colors.white,
            color2: Colors.white,
            hight: ApplicationSizing.convert(80),
            parentContext: context,
            centerWigets: AppBarTextStyle(
              text: "Chat List",
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                    colors: [Color(0Xff4EAF48), Color(0xff60E558)])),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                  child: Home(),
                  type: PageTransitionType.bottomToTop,
                ));
          },
        ),
        bottomNavigationBar: BottomBar(selectedIndex: 2,),
        body: _body(chatListVM: chatListVM));
  }
  _emptyChat(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text("Coming Soon...11",
              style: Styles.PoppinsRegular(
                fontWeight: FontWeight.w500,
                color: appColor,
                fontSize: ApplicationSizing.fontScale(15),
              ),),
          ),
        ],
      ),
    );
  }

  _body({ChatListVM? chatListVM}){
    return (chatListVM?.groupIds.length == 0 && !chatListVM!.loadingGroupId) ? NoData() :   Container(
      child: Stack(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context,int index){
                return  GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(child: ChatScreen(getGroupsModel: chatListVM?.groupIds[index],), type: PageTransitionType.fade));
                    },
                  child: chatTile(getGroupsModel: chatListVM?.groupIds[index]),
                );
              },
              separatorBuilder:  (BuildContext context,int index){
                return ApplicationSizing.verticalSpacer();
              },
              itemCount: chatListVM?.groupIds.length??0),
          chatListVM!.loadingGroupId ? AlertLoader() : Container(),
        ],
      ),
    );
  }

  chatTile({GetGroupsModel? getGroupsModel}){
    return Container(
      // color: Colors.brown,
      padding: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularImage(
            h: 45,
            w: 45,
          ),
          ApplicationSizing.horizontalSpacer(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              // alignment: Alignment.topLeft,
              // color: Colors.green,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Expanded(
                        flex: 5,
                        child: Container(
                          // color: Colors.red,
                            child: Text(getGroupsModel?.title??"",
                              style: Styles.PoppinsRegular(
                                fontWeight: FontWeight.w400,
                                fontSize: ApplicationSizing.fontScale(14)
                              ),
                              maxLines: 1,
                            )),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.centerRight,
                            // color: Colors.pink,
                            child: Text(getGroupsModel?.lastMessageTime??"",
                              style: Styles.PoppinsRegular(
                                  fontWeight: FontWeight.w400,
                                  fontSize: ApplicationSizing.fontScale(11),
                                  color: appColor
                              ),
                              maxLines: 1,
                            )),
                      ),

                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Expanded(
                        flex: 4,
                        child: Container(
                          // color: Colors.red,
                            child: Text(getGroupsModel?.lastMessage??"",
                              style: Styles.PoppinsRegular(
                                  fontWeight: FontWeight.w400,
                                  fontSize: ApplicationSizing.fontScale(12),
                                color: fontGrayColor
                              ),
                              maxLines: 1,
                            )),
                      ),
                      getGroupsModel?.unreadMsgCount == 0 ? Container() : Expanded(
                        flex: 1,
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              child: Text("${getGroupsModel?.unreadMsgCount ?? ""}",
                                style: Styles.PoppinsRegular(
                                    fontWeight: FontWeight.w400,
                                    fontSize: ApplicationSizing.fontScale(12),
                                  color: Colors.white
                                ),
                                maxLines: 1,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: appColor
                              ),
                            )
                      ),

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

