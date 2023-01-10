import 'dart:async';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
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
  // late Record record;

  bool isLocked = false;
  bool showLottie = false;

  @override
  void initState() {
    super.initState();
    print("recording initState call");
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
      margin: EdgeInsets.symmetric(horizontal: ApplicationSizing.horizontalMargin(n: 5)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          lockSlider(chatScreenVM: widget.chatScreenVM),
          cancelSlider(chatScreenVM: widget.chatScreenVM),
          audioButton(chatScreenVM: widget.chatScreenVM),
          if (isLocked) timerLocked(chatScreenVM: widget.chatScreenVM),
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

  Widget timerLocked({required ChatScreenVM chatScreenVM}) {
    return Positioned(
      right: 0,
      child: Container(
        height: size,
        width: timerWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ApplicationSizing.borderRadius),
          color: whiteColor,
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              Vibrate.feedback(FeedbackType.success);
              timer?.cancel();
              timer = null;
              startTime = null;
              recordDuration = "00:00";

              // var filePath = await Record().stop();
              // AudioState.files.add(filePath!);
              // ApplicationSizing.audioListKey.currentState!
              //     .insertItem(AudioState.files.length - 1);
              // debugPrint(filePath);
              setState(() {
                isLocked = false;
              });
            },
            child: Column(
              children: [
                chatScreenVM.isRecording ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    // color: Colors.green,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  // color: Colors.amber,
                  child: AudioWaveforms(
                    size: Size(MediaQuery.of(context).size.width, 30.0),
                    shouldCalculateScrolledPosition: true,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    recorderController: chatScreenVM.recorderController!,
                    waveStyle: const WaveStyle(
                      waveCap: StrokeCap.square,
                      // showDurationLabel: true,
                      showMiddleLine: false,
                      // durationTextPadding: 10,
                      // showHourInDuration: true,
                      showTop: true,
                      spacing: 4.0,
                      extendWaveform: true,
                      // labelSpacing: -10,
                    ),
                  ),
                ) : Container(),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(recordDuration),
                      FlowShader(
                        child: const Text("Tap lock to stop"),
                        duration: const Duration(seconds: 3),
                        flowColors: const [Colors.white, Colors.grey],
                      ),
                      const Center(
                        child: FaIcon(
                          FontAwesomeIcons.lock,
                          size: 18,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
            debugPrint("Cancelled recording");
            // var filePath = await record.stop();
            // debugPrint(filePath);
            // File(filePath!).delete();
            // debugPrint("Deleted $filePath");
            showLottie = false;
          });
        } else if (checkIsLocked(details.localPosition)) {
          controller.reverse();

          Vibrate.feedback(FeedbackType.heavy);
          debugPrint("Locked recording");
          debugPrint(details.localPosition.dy.toString());
          setState(() {
            isLocked = true;
          });
        } else {
          controller.reverse();

          Vibrate.feedback(FeedbackType.success);

          timer?.cancel();
          timer = null;
          startTime = null;
          recordDuration = "00:00";

          // var filePath = await Record().stop();
          // AudioState.files.add(filePath!);
          // ApplicationSizing.audioListKey.currentState!
          //     .insertItem(AudioState.files.length - 1);
          // debugPrint(filePath);
        }
      },
      onLongPressCancel: () {
        debugPrint("onLongPressCancel");
        controller.reverse();
      },
      onLongPress: () async {
        debugPrint("onLongPress");
        Vibrate.feedback(FeedbackType.success);
        // if (await Record().hasPermission()) {
        //   record = Record();
        //   await record.start(
        //     path: ApplicationSizing.documentPath +
        //         "audio_${DateTime.now().millisecondsSinceEpoch}.m4a",
        //     encoder: AudioEncoder.AAC,
        //     bitRate: 128000,
        //     samplingRate: 44100,
        //   );
        //   startTime = DateTime.now();
        //   timer = Timer.periodic(const Duration(seconds: 1), (_) {
        //     final minDur = DateTime.now().difference(startTime!).inMinutes;
        //     final secDur = DateTime.now().difference(startTime!).inSeconds % 60;
        //     String min = minDur < 10 ? "0$minDur" : minDur.toString();
        //     String sec = secDur < 10 ? "0$secDur" : secDur.toString();
        //     setState(() {
        //       recordDuration = "$min:$sec";
        //     });
        //   });
        // }
      },
    );
  }

  bool checkIsLocked(Offset offset) {
    return (offset.dy < -35);
  }

  bool isCancelled(Offset offset, BuildContext context) {
    return (offset.dx < -(MediaQuery.of(context).size.width * 0.2));
  }
}