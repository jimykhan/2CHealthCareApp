
import 'package:twochealthcare/common_widgets/circular_image.dart';
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_message_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/views/chat/constants.dart';
import 'audio_message.dart';
import 'text_message.dart';
import 'video_message.dart';

class Message extends HookWidget {
   Message({
    Key? key,
    this.message,
     required this.index
  }) : super(key: key);

  final ChatMessageModel? message;
  int index;

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        Future.microtask(() async {});
        return () {
          // Dispose Objects here
        };
      },
      const [],
    );

    Widget messageContaint(ChatMessageModel message,{required int index}) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        case ChatMessageType.audio:
          return Container();
          // return AudioMessage(message: message,index: index);
        case ChatMessageType.video:
          return VideoMessage();
        default:
          // return TextMessage(message: message);
        return SizedBox();
      }
    }

    return Container(
      padding:  EdgeInsets.only(top: kDefaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                !(message!.isSender!) ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: messageContaint(message!,index: index)),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Container(
          //       child: participients == null ? Container () : Wrap(
          //         children: participients!.map((e) => e.readIndex == message!.id ? viewTags(name: e.shortName?.replaceAll(" ", "")) : Container()).toList(),
          //       ),
          //     ),
          //   ],
          // ),

          // !(message!.isSender!)
          //     ? checkLoader(message!.messageStatus!)
          //     : MessageStatusDot(status: message!.messageStatus!)
        ],
      ),
    );
  }

  Widget viewTags({String? name}){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.5),
      width: 15,
      height: 15,
      decoration:   BoxDecoration(
        shape: BoxShape.circle,
        color:appColorSecondary.withOpacity(0.3),
      ),
      child: Center(
        child: Text(name??"",
        style: Styles.PoppinsRegular(fontSize: 8,
        color: appColorSecondary),),
      ),
    );
  }

  checkLoader(MessageStatus status) {
    return status == MessageStatus.not_view
        ? Container(
            margin: EdgeInsets.only(left: kDefaultPadding / 2),
            height: 12,
            width: 12,
            decoration: const BoxDecoration(),
            child: loader()
    ) : Container();
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({Key? key, required this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Color dotColor(MessageStatus status) {
      print("this is green dot $status");
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
        case MessageStatus.not_view:
          return fontGrayColor;
        case MessageStatus.viewed:
          return appColor;
        default:
          return appColor;
      }
    }

    return status == MessageStatus.not_sent ? Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
    ) : Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: status == MessageStatus.not_sent
          ? loader()
          : Icon(
              status == MessageStatus.not_sent ? Icons.close : Icons.done,
              size: 8,
              color: Colors.white,
            ),
    );
  }
}
