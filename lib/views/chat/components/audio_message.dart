import 'package:audioplayers/audioplayers.dart' as audioPlay;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twochealthcare/common_widgets/alert_loader.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
import 'package:twochealthcare/views/chat/constants.dart';
class AudioMessage extends HookWidget {
  final ChatMessage? message;
  int index;
   AudioMessage({this.message,required this.index,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatScreenVM chatScreenVM = useProvider(chatScreenVMProvider);
    return Column(
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
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            margin:  !(message!.isSender!) ? EdgeInsets.only(right: 20) : EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
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
              // borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: message!.isSender!
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        // widget.onPlay(widget.id);
                        // _playPause();
                        chatScreenVM.playPause(index,message!.id!, message!.linkUrl!);
                      },
                      child: Container(
                        // width: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor
                        ),
                        child: message!.downloading ? SimpleLoader(color: whiteColor,) : Icon(!(chatScreenVM.playerState == audioPlay.PlayerState.playing && chatScreenVM.currentIndex == message!.id!) ? Icons.play_arrow_outlined : Icons.pause,
                          color: Colors.white,),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: chatScreenVM.currentIndex ==  message!.id! ? double.parse(chatScreenVM.currentpos.toString()) : 0.0,
                        min: 0,
                        max: chatScreenVM.currentIndex ==  message!.id! ? double.parse(chatScreenVM.maxduration.toString()) : 0.0,
                        divisions: chatScreenVM.currentIndex ==  message!.id! ? chatScreenVM.maxduration : null,
                        label: chatScreenVM.currentIndex ==  message!.id! ? chatScreenVM.currentpostlabel : null,
                        activeColor: chatScreenVM.currentIndex ==  message!.id! ? appColor : disableColor,
                        inactiveColor: kPrimaryColor.withOpacity(0.2),
                        thumbColor: kPrimaryColor,
                        onChanged: chatScreenVM.audioPlayer == null ? null : (double value) async {
                          int seekval = value.round();
                          print("seekbval ${seekval}");
                          if(seekval < chatScreenVM.maxduration){
                            chatScreenVM.audioPlayer?.seek(Duration(milliseconds: seekval)).whenComplete(() {
                                print("yes Seek work ${seekval}");

                                chatScreenVM.currentpos = seekval;
                                chatScreenVM.calculateCurrentPostionLable(chatScreenVM.currentpos);
                                chatScreenVM.notifyListeners();
                                // if(_playerState == PlayerState.completed){
                                //   _playerState = PlayerState.playing;
                                // }
                            });
                          }
                          if(seekval == chatScreenVM.maxduration){
                            chatScreenVM.audioPlayer?.stop();
                            chatScreenVM.playerState = audioPlay.PlayerState.completed;

                          }
                        },
                      ),
                    ),
                    message!.isError ? Icon(Icons.error_outline, color: errorColor,) : SizedBox()
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
                    Text(
                      "${chatScreenVM.currentIndex ==  message!.id! ? chatScreenVM.currentpostlabel : ""}",
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
            )
        ),
        SizedBox(
          height: ApplicationSizing.convertWidth(3),
        ),
      ],
    );
  }
}

