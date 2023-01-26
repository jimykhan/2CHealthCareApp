import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:twochealthcare/common_widgets/buttons/sent_button.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
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
    ConnectivityService connectivityService =
        useProvider(connectivityServiceProvider);
    useEffect(
      () {
        //
        // myFocusNode = FocusNode();
        return () {
          // chatScreenVM.recorderController?.dispose();
          // chatScreenVM.recorderController = null;
        };
      },
      const [],
    );
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          // color: Theme.of(context).scaffoldBackgroundColor,
          // color: Colors.black,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 32,
              color: Color(0xFF087949).withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon(Icons.mic, color: kPrimaryColor),
                // SizedBox(width: kDefaultPadding),
                Expanded(
                  child:  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: fontGrayColor.withOpacity(0.2),
                            // color: Colors.green,
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
                                  child:  TextField(
                                      // expands: true,
                                      // maxLines: 4,
                                      // keyboardType: TextInputType.multiline,

                                      maxLines: 20,
                                      // focusNode: chatScreenVM.myFocusNode,
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
                                    onTap: (){
                                      // if(val){
                                      ChatScreen.jumpToListIndex(isDelayed: true);
                                      // }
                                    },
                                      // focusNode: myFocusNode,
                                    ),

                                ),
                              ),
                              chatScreenVM.isMessageEmpty
                                  ? Container()
                                  : SendButton(
                                ontap: () async {
                                  if (connectivityService.connectionStatus ==
                                      ConnectivityResult.none) {
                                    SnackBarMessage(
                                        message:
                                        "No internet connection detected, please try again.");
                                  } else {
                                    FocusScope.of(context).unfocus();
                                     chatScreenVM.sendTextMessage(
                                        message: _textEditingController?.text
                                            .toString(),
                                        chatMessageType: ChatMessageType.text
                                    );
                                    _textEditingController?.clear();
                                    ChatScreen.jumpToListIndex();
                                    print("work");
                                  }
                                },
                                // withBackground: true,
                              ),
                            ],
                          ),
                        ),
                     // chatScreenVM.isRecording ? Container(
                     //   padding: const EdgeInsets.symmetric(
                     //     horizontal: kDefaultPadding * 0.75,
                     //   ),
                     //   decoration: BoxDecoration(
                     //     color: Colors.grey.shade300,
                     //     // color: Colors.green,
                     //     borderRadius: BorderRadius.circular(40),
                     //   ),
                     //   // color: Colors.amber,
                     //   child: AudioWaveforms(
                     //      size: Size(MediaQuery.of(context).size.width, 30.0),
                     //      shouldCalculateScrolledPosition: true,
                     //      padding: EdgeInsets.zero,
                     //      margin: EdgeInsets.zero,
                     //      recorderController: chatScreenVM.recorderController!,
                     //     waveStyle: const WaveStyle(
                     //       waveCap: StrokeCap.square,
                     //       // showDurationLabel: true,
                     //       showMiddleLine: false,
                     //       // durationTextPadding: 10,
                     //       // showHourInDuration: true,
                     //       showTop: true,
                     //       spacing: 4.0,
                     //       extendWaveform: true,
                     //       // labelSpacing: -10,
                     //     ),
                     //    ),
                     // ) : Container(),
                    ],
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
