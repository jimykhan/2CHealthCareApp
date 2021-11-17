import 'package:twochealthcare/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/chat/constants.dart';
import 'package:twochealthcare/views/chat/chat_screen.dart';

class ChatInputField extends HookWidget {
  TextEditingController? _textEditingController;
  ChatInputField({Key? key,}) : super(key: key);
  // FocusNode myFocusNode;
  @override
  Widget build(BuildContext context) {
    _textEditingController = useTextEditingController();
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
    return Container(
      padding: EdgeInsets.symmetric(
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
      child: SafeArea(
        child: Row(
          children: [
            // Icon(Icons.mic, color: kPrimaryColor),
            // SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
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
                      child: TextField(
                        style: Styles.PoppinsRegular(
                            color: drawerColor,
                            fontSize: ApplicationSizing.convert(16)),
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                            hintStyle: Styles.PoppinsRegular(
                                color: drawerSelectMenuColor, fontSize: 16)),
                        // onChanged: chatService.CheckMessageField,
                        // focusNode: myFocusNode,
                      ),
                    ),
                    // chatService.isMessageEmpty
                    false
                        ? Container()
                        : InkWell(
                            onTap: () async {
                              // chatService.isMessageEmpty = true;
                              // FocusScope.of(context).unfocus();
                              // chatService.listOfMessage.add(ChatMessage(
                              //   id: 0,
                              //   message: _textEditingController.text.toString(),
                              //   sentToAll: false,
                              //   viewedByAll: false,
                              //   senderUserId: deviceService?.currentUser?.appUserId??"",
                              //   isSender: false,
                              //   messageStatus: MessageStatus.not_sent,
                              //   timeStamp: DateTime.now().toString(),
                              // ));
                              ChatScreen().jumpToListIndex();
                              var messageVal =
                                  _textEditingController?.text.toString();
                              _textEditingController?.clear();
                              // await chatService.SendTextMessage(
                              //   context,
                              //   body: {
                              //     "senderUserId":
                              //         deviceService?.currentUser?.appUserId??"",
                              //     "chatGroupId":
                              //         chatService?.selectedChatGroup?.id ?? 0,
                              //     "message": messageVal,
                              //     "linkUrl": "string",
                              //   },
                              //   token: deviceService?.currentUser?.bearerToken??"",
                              //   UserId: deviceService?.currentUser?.appUserId ?? '',
                              // );
                              print("work");

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
          ],
        ),
      ),
    );
  }
}
