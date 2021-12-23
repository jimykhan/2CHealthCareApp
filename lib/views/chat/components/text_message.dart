import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/conversion.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
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
        crossAxisAlignment: !(message!.isSender!)
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
            margin: EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              // color: message.isSender ? drawerColor : appColor,
              borderRadius: !(message!.isSender!)
                  ? BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))
                  : BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
            ),
            child: Text(
              message?.senderName ?? "",
              style: Styles.PoppinsRegular(
                fontSize: ApplicationSizing.convert(12),
                color: drawerColor,
              ),
            ),
          ),
          Container(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0Xff1d161712),
                    blurRadius: 3,
                    offset: Offset(0, 6), // Shadow position
                  ),
                ],
                color: !(message!.isSender!) ? Colors.white : Color(0xffDEEFDD),
                borderRadius: !(message!.isSender!)
                    ? BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                        right: ApplicationSizing.convertWidth(15),
                        left: ApplicationSizing.convertWidth(15),
                        bottom: ApplicationSizing.convertWidth(10),
                        top: ApplicationSizing.convertWidth(10),
                      ),
                      child: Column(
                        crossAxisAlignment: message!.isSender!
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SelectableLinkify(
                                onOpen: (data){
                                  print(data.url);
                                  launchURL(url: data.url);
                                },
                                onTap:(){
                                  //
                                } ,
                                text:message!.message ?? "",
                                style: TextStyle(
                                  fontSize: ApplicationSizing.convert(18),
                                  color: !(message!.isSender!)
                                      ? Colors.black
                                      : Colors.black,
                                ),
                                options: LinkifyOptions(humanize: false),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ApplicationSizing.convertWidth(5),
                          ),
                          Column(
                            children: [
                              Text(
                                "${Jiffy(message?.timeStamp).format("h:mm a")}",
                                // "${message?.timeStamp}",
                                style: Styles.RobotoMedium(
                                  fontSize: ApplicationSizing.convert(12),
                                  color: Colors.green,
                                ),
                                textAlign: TextAlign.right,
                                // ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: ApplicationSizing.convertWidth(3),
          ),
          // Container(
          //   child: Text(
          //     "${Jiffy(message?.timeStamp).format("h:mm a")}",
          //     style: Styles.RobotoMedium(
          //       fontSize: ApplicationSizing.convert(12),
          //       color: Colors.red,
          //     ),
          //     // ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
