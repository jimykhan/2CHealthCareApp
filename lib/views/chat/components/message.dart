
import 'package:twochealthcare/common_widgets/loader.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/chat/constants.dart';
import 'audio_message.dart';
import 'text_message.dart';
import 'video_message.dart';

class Message extends HookWidget {
  const Message({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

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

    Widget messageContaint(ChatMessage? message) {
      switch (message!.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        case ChatMessageType.audio:
          return AudioMessage(message: message);
        case ChatMessageType.video:
          return VideoMessage();
        default:
          return TextMessage(message: message);
        // return SizedBox();
      }
    }

    return Container(
      padding:  EdgeInsets.only(top: kDefaultPadding),
      margin: EdgeInsets.only(
        right: !(message!.isSender!)
            ? ApplicationSizing.convertWidth(20)
            : 0,
        left: !(message!.isSender!)
            ? 0
            : ApplicationSizing.convertWidth(20)
      ),
      child: Row(
        mainAxisAlignment:
            !(message!.isSender!) ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // if (!(message.senderUserId == null)) ...[
          //   CircleAvatar(
          //     radius: 12,
          //     backgroundImage: AssetImage("assets/icons/user_2.png"),
          //   ),
          //   SizedBox(width: kDefaultPadding / 2),
          // ],
          Expanded(child: messageContaint(message)),
          !(message!.isSender!)
              ? checkLoader(message!.messageStatus!)
              : MessageStatusDot(status: message!.messageStatus!)
        ],
      ),
    );
  }

  checkLoader(MessageStatus status) {
    return status == MessageStatus.not_view
        ? Container(
            margin: EdgeInsets.only(left: kDefaultPadding / 2),
            height: 12,
            width: 12,
            decoration: const BoxDecoration(
                // shape: BoxShape.circle,
                ),
            child: loader()
    )

        : Container();
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({Key? key, required this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
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
