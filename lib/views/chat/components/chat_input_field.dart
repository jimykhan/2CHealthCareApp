import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/services/connectivity_service.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
import 'package:twochealthcare/views/chat/constants.dart';
import 'package:twochealthcare/views/chat/chat_screen.dart';

class ChatInputField extends HookWidget {
  TextEditingController? _textEditingController;
  ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _textEditingController = useTextEditingController();
    ChatScreenVM chatScreenVM = useProvider(chatScreenVMProvider);
    ConnectivityService connectivityService = useProvider(connectivityServiceProvider);
    useEffect(
      () {
        //
        // myFocusNode = FocusNode();
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 32,
              color: Color(0xFF087949).withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
              children: [
                // Icon(Icons.mic, color: kPrimaryColor),
                // SizedBox(width: kDefaultPadding),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        // Icon(
                        //   Icons.sentiment_satisfied_alt_outlined,
                        //   color: Theme.of(context)
                        //       .textTheme
                        //       .bodyText1
                        //       .color
                        //       .withOpacity(0.64),
                        // ),
                        // SizedBox(width: kDefaultPadding / 4),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 3),
                            child: TextField(
                              // expands: true,
                              // maxLines: 4,
                              // keyboardType: TextInputType.multiline,
                              maxLines: 20,
                              focusNode: chatScreenVM.myFocusNode,
                              minLines: 1,
                              maxLengthEnforcement: MaxLengthEnforcement.enforced,
                              style: Styles.PoppinsRegular(
                                color: drawerColor,
                                fontSize: ApplicationSizing.convert(16),
                              ),
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                hintText: "Type a message",
                                border: InputBorder.none,
                                hintStyle: Styles.PoppinsRegular(
                                    color: drawerSelectMenuColor, fontSize: 16),
                              ),
                              onChanged: chatScreenVM.checkMessageField,
                              // focusNode: myFocusNode,
                            ),
                          ),
                        ),
                        chatScreenVM.isMessageEmpty
                            ? Container()
                            : InkWell(
                            onTap: () async {
    if(connectivityService.connectionStatus == ConnectivityResult.none){
    SnackBarMessage(message: "No internet connection detected, please try again.");
    }else{
      FocusScope.of(context).unfocus();
      ChatScreen.jumpToListIndex();
      chatScreenVM.sendTextMessage(
          message:
          _textEditingController?.text.toString());
      _textEditingController?.clear();
      print("work");
    }


                            },
                            child: Icon(
                              Icons.send,
                              color: AppBarEndColor,
                              size: ApplicationSizing.convert(30),
                            ))
                      ],
                    ),
                  ),
                ),
                // chatScreenVM.myFocusNode!.hasFocus ? Container() : Container(
                //   child: Row(
                //     children: [
                //       Icon(Icons.image),
                //       Icon(Icons.document_scanner),
                //     ],
                //   ),
                // ),
              ],
            ),
          

      ),
    );
  }
}
