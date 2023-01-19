import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twochealthcare/common_widgets/buttons/delete_button.dart';
import 'package:twochealthcare/common_widgets/buttons/sent_button.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/util/styles.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_screen_vm.dart';
import 'package:twochealthcare/views/chat/components/flow_shader.dart';
import 'package:twochealthcare/views/chat/components/lottie_animation.dart';
import 'package:twochealthcare/views/chat/constants.dart';

class RecordButton extends StatefulWidget {
  ChatScreenVM chatScreenVM;
   RecordButton({
    Key? key,
     required this.chatScreenVM
  }) : super(key: key);



  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  static const double size = 55;

  final double lockerHeight = 200;
  double timerWidth = 0;

  late Animation<double> buttonScaleAnimation;
  late Animation<double> timerAnimation;
  late Animation<double> lockerAnimation;

  DateTime? startTime;
  Timer? timer;
  String recordDuration = "00:00";

  bool isLocked = false;
  bool showLottie = false;

  @override
  void initState() {
    super.initState();
    print("recording initState call");
    widget.chatScreenVM.openTheRecorder();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    buttonScaleAnimation = Tween<double>(begin: 1, end: 2).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticInOut),
      ),
    );
    controller.addListener(() {
      setState(() {});
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    timerWidth =
        MediaQuery.of(context).size.width - 2 * ApplicationSizing.defaultPadding ;
    timerAnimation =
        Tween<double>(begin: timerWidth + ApplicationSizing.defaultPadding, end: 0)
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.2, 1, curve: Curves.easeIn),
          ),
        );
    lockerAnimation =
        Tween<double>(begin: lockerHeight + ApplicationSizing.defaultPadding, end: 0)
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.2, 1, curve: Curves.easeIn),
          ),
        );
  }

  @override
  void dispose() {
    // record.dispose();
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          lockSlider(chatScreenVM: widget.chatScreenVM),
          cancelSlider(chatScreenVM: widget.chatScreenVM),
          audioButton(chatScreenVM: widget.chatScreenVM),
          if (isLocked) timerLocked(context,chatScreenVM: widget.chatScreenVM),
        ],
      ),
    );
  }

  Widget lockSlider({required ChatScreenVM chatScreenVM}) {
    return Positioned(
      bottom: -lockerAnimation.value,
      child: Container(
        height: lockerHeight,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ApplicationSizing.borderRadius),
          color: whiteColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const FaIcon(FontAwesomeIcons.lock, size: 20),
            const SizedBox(height: 8),
            FlowShader(
              direction: Axis.vertical,
              child: Column(
                children: const [
                  Icon(Icons.keyboard_arrow_up),
                  Icon(Icons.keyboard_arrow_up),
                  Icon(Icons.keyboard_arrow_up),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cancelSlider({required ChatScreenVM chatScreenVM}) {
    return Positioned(
      right: -timerAnimation.value,
      child: Container(
        height: size,
        width: timerWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ApplicationSizing.borderRadius),
          color: whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              showLottie ? const LottieAnimation() : Text(recordDuration),
              const SizedBox(width: size),
              FlowShader(
                child: Row(
                  children: const [
                    Icon(Icons.keyboard_arrow_left),
                    Text("Slide to cancel")
                  ],
                ),
                duration: const Duration(seconds: 3),
                flowColors: const [Colors.white, Colors.grey],
              ),
              const SizedBox(width: size),
            ],
          ),
        ),
      ),
    );
  }



  Widget timerLocked(context,{required ChatScreenVM chatScreenVM}) {
    return Positioned(
      right: 0,
      child: Container(
        height: size,
        width: MediaQuery.of(context).size.width ,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(ApplicationSizing.borderRadius),
          color: whiteColor,
          // color: Colors.blue,
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // chatScreenVM.isRecording ? Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text(recordDuration,style: Styles.PoppinsRegular(fontSize: ApplicationSizing.fontScale(14),fontWeight: FontWeight.w500),),
              //     Expanded(
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: kDefaultPadding * 0.75,
              //         ),
              //         decoration: BoxDecoration(
              //           // color: Colors.grey.shade300,
              //           // color: Colors.green,
              //           // borderRadius: BorderRadius.circular(40),
              //         ),
              //         // color: Colors.amber,
              //         child: !(chatScreenVM.isRecording) ? Container() :AudioWaveforms(
              //           size: Size(MediaQuery.of(context).size.width, 30.0),
              //           shouldCalculateScrolledPosition: true,
              //           padding: EdgeInsets.zero,
              //           margin: EdgeInsets.zero,
              //           recorderController: chatScreenVM.recorderController!,
              //           waveStyle: const WaveStyle(
              //             waveCap: StrokeCap.square,
              //             // showDurationLabel: true,
              //             showMiddleLine: false,
              //             // durationTextPadding: 10,
              //             // showHourInDuration: true,
              //             showTop: true,
              //             spacing: 4.0,
              //             extendWaveform: true,
              //             // labelSpacing: -10,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ) : Container(),
              Container(
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(recordDuration,style: Styles.PoppinsRegular(fontSize: ApplicationSizing.fontScale(14),fontWeight: FontWeight.w500),),
                    SendButton(
                      withBackground: true,
                      ontap: ()async {
                        Vibrate.feedback(FeedbackType.success);
                        timer?.cancel();
                        timer = null;
                        startTime = null;
                        recordDuration = "00:00";
                        /// stop and save recording
                        setState(() {
                          isLocked = false;
                        });
                        await chatScreenVM.saveRecording();
                        // chatScreenVM.cancelRecording();
                        // setState(() {
                        //   isLocked = false;
                        // });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget audioButton({required ChatScreenVM chatScreenVM}) {
    return GestureDetector(
      child: Transform.scale(
        scale: buttonScaleAnimation.value,
        child: Container(
          child: const Icon(Icons.mic),
          height: size,
          width: size,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      onLongPressDown: (_) {
        debugPrint("onLongPressDown");
        controller.forward();
      },
      onLongPressEnd: (details) async {
        debugPrint("onLongPressEnd");

        if (isCancelled(details.localPosition, context)) {
          cancelRecording(chatScreenVM);

        } else if (checkIsLocked(details.localPosition)) {
          controller.reverse();

          Vibrate.feedback(FeedbackType.heavy);
          debugPrint("Locked recording");
          debugPrint(details.localPosition.dy.toString());
          setState(() {
            isLocked = true;
          });
        }
        else {
          controller.reverse();
          Vibrate.feedback(FeedbackType.success);
          timer?.cancel();
          timer = null;
          startTime = null;
          recordDuration = "00:00";
          /// stop and save recording
          chatScreenVM.saveRecording();
        }
      },
      onLongPressCancel: () {
        debugPrint("onLongPressCancel");
        controller.reverse();
      },
      onLongPress: () async {
        debugPrint("onLongPress");
        Vibrate.feedback(FeedbackType.success);

        /// Start recording and timer
        bool hasRecordingPermission = await chatScreenVM.RecordingPermission();
        if (hasRecordingPermission) {
          chatScreenVM.startRecording();
          startTime = DateTime.now();
          timer = Timer.periodic(const Duration(seconds: 1), (_) {
            final minDur = DateTime.now().difference(startTime!).inMinutes;
            final secDur = DateTime.now().difference(startTime!).inSeconds % 60;
            String min = minDur < 10 ? "0$minDur" : minDur.toString();
            String sec = secDur < 10 ? "0$secDur" : secDur.toString();
            setState(() {
              recordDuration = "$min:$sec";
            });
          });
        }
      },
    );
  }

  cancelRecording(ChatScreenVM chatScreenVM){
    print("cancel recording call");
    Vibrate.feedback(FeedbackType.heavy);

    timer?.cancel();
    timer = null;
    startTime = null;
    recordDuration = "00:00";
    setState(() {
      showLottie = true;
    });

    Timer(const Duration(milliseconds: 1440), () async {
      controller.reverse();
      debugPrint("Stop and Cancelled recording");
      chatScreenVM.cancelRecording();
      showLottie = false;
    });
  }

  bool checkIsLocked(Offset offset) {
    return (offset.dy < -35);
  }

  bool isCancelled(Offset offset, BuildContext context) {
    return (offset.dx < -(MediaQuery.of(context).size.width * 0.2));
  }
}