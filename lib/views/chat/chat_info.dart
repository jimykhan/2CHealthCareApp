import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/appbar_text_style.dart';
import 'package:twochealthcare/common_widgets/app_bar_components/back_button.dart';
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/custom_appbar.dart';
import 'package:twochealthcare/common_widgets/input_field/custom_text_field.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
class ChatInfo extends HookWidget {
  String title;
   ChatInfo({required this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatScreenVM chatScreenVM = useProvider(chatScreenVMProvider);
    ApplicationRouteService applicationRouteService = useProvider(applicationRouteServiceProvider);
    useEffect(
          () {
            chatScreenVM.searchListener();
        // chatService.initSigalR(token: deviceService?.currentUser?.bearerToken??"",appId: deviceService?.currentUser?.appUserId??"");
        Future.microtask(() async {

        });
        return () {
          chatScreenVM.disposeSearchController();
          // Dispose Objects here
        };
      },
      const [],
    );
    return Scaffold(
      backgroundColor: Color(0xffFBFBFB),
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
              CustomBackButton(),
              SizedBox(
                width: ApplicationSizing.convertWidth(5),
              ),
              AppBarTextStyle(
                  // text: getGroupsModel?.title ?? "Text",
                  text: title,
                  textsize: ApplicationSizing.convert(18)),
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
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(size.convert(context, 50)),
      //   child: buildAppBar(context, chatService: chatService),
      // ),
      body: _body(chatScreenVM),
      // body: _body(context,chatScreenVM: chatScreenVM),
      // body: test(),
    );
  }
  _body(ChatScreenVM chatScreenVM){
    return Container(
      child: Column(
        children: [
          ApplicationSizing.verticalSpacer(n: 5),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
            child: CustomTextField(
              // onchange: loginVM!.onChangeEmail,
              textEditingController: chatScreenVM.searchController,
              hints: "Search...",
              color1: disableColor ,
              onSubmit: (val) {
                // loginVM.fieldValidation(val, fieldType: 0);
              },
              onchange: (String val) {  },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Container(
                // padding: EdgeInsets.symmetric(vertical: ApplicationSizing.convert(10)),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin()),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              color: appColorSecondary.withOpacity(0.3),
                            ),
                            child: Center(
                              child: Text(chatScreenVM.participients?[index].shortName??"",
                                style: Styles.PoppinsRegular(
                                    color: appColorSecondary,
                                    fontSize: ApplicationSizing.fontScale(18),
                                    fontWeight: FontWeight.w600
                                ),

                              ),
                            ),
                          ),
                          SizedBox(width: ApplicationSizing.convertWidth(10),),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                chatScreenVM.searchController?.text = chatScreenVM.participients?[index].fullName??"";
                                FocusScope.of(context).unfocus();
                              },
                              child: Container(
                                // color: Colors.black,
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  chatScreenVM.participients?[index].fullName??"",
                                  style: Styles.PoppinsRegular(
                                    fontSize: ApplicationSizing.fontScale(15),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 5,);
                  },
                  itemCount: chatScreenVM.participients!.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
