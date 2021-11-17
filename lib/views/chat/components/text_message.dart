import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
      //     ? Colors.white
      //     : Colors.black,

      // padding: EdgeInsets.symmetric(
      //   horizontal: size.convertWidth(context, 5),
      //   vertical: kDefaultPadding / 2,
      // ),
      // decoration: BoxDecoration(
      //   color: kPrimaryColor.withOpacity(message.isSender ? 1 : 0.1),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: Column(
        crossAxisAlignment: message!.isSender!
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
            margin: EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              // color: message.isSender ? drawerColor : appColor,
              borderRadius: message!.isSender!
                  ? BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(5))
                  : BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(0),
                    ),
            ),
            child: Text(
              message?.senderName ?? "",
              style: Styles.PoppinsRegular(
                fontSize: ApplicationSizing.convert(10),
                color: drawerColor,
              ),
            ),
          ),
          Container(
            child: Container(
              decoration: BoxDecoration(
                color: message!.isSender! ? drawerColor : appColor,
                borderRadius: message!.isSender!
                    ? BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(5))
                    : BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(0),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      right: ApplicationSizing.convertWidth(10),
                      left: ApplicationSizing.convertWidth(10),
                      bottom: ApplicationSizing.convertWidth(10),
                      top: ApplicationSizing.convertWidth(10),
                    ),
                    child: Text(
                      message!.message??"",
                      style: TextStyle(
                        fontSize: ApplicationSizing.convert(16),
                        color: message!.isSender! ? Colors.white : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: ApplicationSizing.convertWidth( 5),
          ),
          Container(
            child: Text(
              "${message!.timeStamp!}",
              style: Styles.RobotoMedium(
                fontSize: ApplicationSizing.convert(10),
                color: Colors.red,
              ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
