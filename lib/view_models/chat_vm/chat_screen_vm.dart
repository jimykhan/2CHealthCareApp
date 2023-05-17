import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart' as audioPlay;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_message_model.dart';
import 'package:twochealthcare/models/patient_communication_models/communication_history_model.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/chat_services/chat_screen_service.dart';
import 'package:twochealthcare/services/chat_services/patient_communication_service.dart';
import 'package:twochealthcare/services/connectivity_service.dart';
import 'package:twochealthcare/services/s3-services/src/s3-crud-service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/util/data_format.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/views/chat/chat_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twochealthcare/models/patient_communication_models/chat_summary_data_model.dart';

class ChatScreenVM extends ChangeNotifier {

  // ChatHistoryModel chatMessageList = ChatHistoryModel();

  CommunicationHistoryModel communicationHistoryModel = CommunicationHistoryModel(results: []);

  List<Participients>? participients = [];
  bool allMessagesLoading = true;
  bool pageWiseLoading = false;
  S3CrudService? _s3crudService;
  // bool isSearchFieldValid = true;
  TextEditingController? searchController;
  String? currentUserAppUserId;
  String? chatGroupId;
  int loadingPageNumber = 1;
  ProviderReference? _ref;
  AuthServices? _authServices;
  ChatScreenService? _chatScreenService;
  SharedPrefServices? _sharedPrefServices;
  ChatListVM? _chatListVM;
  ApplicationRouteService? _applicationRouteService;
  late ConnectivityService connectivityService;
  SignalRServices? _signalRServices;
  bool isMessageEmpty = true;
  FocusNode? myFocusNode;

  /// audio recording
  bool isRecording = false;
  int recordingDuration = 0;
  int? patientId;
  late AnimationController controller;
  final FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  DateTime? startTime;

  /// audio recording

  PatientCommunicationService? _patientCommunicationService;




  ChatScreenVM({ProviderReference? ref}) {
    _ref = ref;
    initService();
  }

  disposAudioController() {}

  dispose() {
    myFocusNode?.dispose();
    // chatMessageList.chats = [];
    // chatMessageList.participients = [];

    /// audio recording init
    // recorderController.dispose();
    /// audio recording init
  }

  // searchListener() {
  //   searchController = TextEditingController();
  //   participients = [];
  //   participients!.addAll(chatMessageList.participients ?? []);
  //   searchController?.addListener(() {
  //     if (searchController!.text == "") {
  //       participients = [];
  //       participients!.addAll(chatMessageList.participients ?? []);
  //     } else {
  //       participients = [];
  //       chatMessageList.participients!.forEach((element) {
  //         if (element.fullName!
  //             .toLowerCase()
  //             .contains(searchController!.text.toLowerCase())) {
  //           participients!.add(element);
  //         }
  //       });
  //     }
  //     notifyListeners();
  //   });
  // }

  disposeSearchController() {
    searchController?.dispose();
  }

  initChatScreen() async {
    myFocusNode = FocusNode();
    currentUserAppUserId = await _authServices?.getCurrentAppUserId();
    myFocusNode?.addListener(() {
      print("addListener has focus ${myFocusNode?.hasFocus}");
      if (myFocusNode?.hasFocus ?? false) {
        print("addListener has focus true");
        ChatScreen.jumpToListIndex(isDelayed: false);
      }
    });

    /// audio recording init

    /// audio recording init
  }

  initService() {
    communicationHistoryModel.results = [];
    _authServices = _ref!.read(authServiceProvider);
    _chatListVM = _ref!.read(chatListVMProvider);
    _chatScreenService = _ref!.read(chatScreenServiceProvider);
    _signalRServices = _ref!.read(signalRServiceProvider);
    _applicationRouteService = _ref!.read(applicationRouteServiceProvider);
    _s3crudService = _ref!.read(s3CrudServiceProvider);
    connectivityService = _ref!.read(connectivityServiceProvider);
    _patientCommunicationService = _ref!.read(patientCommunicationServiceProvider);
    _sharedPrefServices = _ref!.read(sharedPrefServiceProvider);


    _signalRServices?.newMessage.stream.listen((event) {
      print("new message reached to Rx dart..");
      print(event.timeStamp.toString());
      if (_applicationRouteService?.currentScreen() == ScreenName.chatHistory) {
        if (event.senderUserId != currentUserAppUserId) {
          event.isSender = false;
          event.messageStatus = MessageStatus.viewed;
          if(event.timeStamp !=null){
            event.timeStamp = convertLocalToUtc(event.timeStamp!.replaceAll("Z", ""));
          }
          communicationHistoryModel.results?.add(event);
            print("this is appUserId  = ${currentUserAppUserId}");
            // _signalRServices!.MarkChatGroupViewed(
            //     chatGroupId: event.chatGroupId!, userId: currentUserAppUserId!);
            notifyListeners();
            communicationHistoryModel.results!.length == 0
                ? null
                : ChatScreen.jumpToListIndex(isDelayed: true);

        }
      }

    });
    _signalRServices?.onChatViewed.stream.listen((event) {
      print("new message reached to Rx dart..");
      if (communicationHistoryModel.results!.length > 0) {
        // if (event["chatGroupId"] == chatMessageList.chats![0].chatGroupId) {
        //   List<Participients> updateParticipantList = [];
        //   event["participients"].forEach((e) {
        //     updateParticipantList.add(Participients.fromJson(e));
        //   });
        //   chatMessageList.participients = [];
        //   chatMessageList.participients!.addAll(updateParticipantList);
        //   notifyListeners();
        // }
      }
    });
  }

  setAllMessagesLoading(bool check) {
    allMessagesLoading = check;
    notifyListeners();
  }

  setPageWiseLoading(bool check) {
    pageWiseLoading = check;
    notifyListeners();
  }

  checkMessageField(var field) {
    if (field is String) {
      if (field.length > 0) {
        isMessageEmpty = false;
      } else {
        isMessageEmpty = true;
        myFocusNode!.unfocus();
      }
    }
    notifyListeners();
  }

  Future<dynamic> getAllMessages({int? patientId, int? pageNumber}) async {
    try {
      pageNumber == 1 ? setAllMessagesLoading(true) : setPageWiseLoading(true);
      int? UserId = patientId ?? await _authServices?.getCurrentUserId();
      String? appUserId = await _authServices?.getCurrentAppUserId();
      var response = await _patientCommunicationService?.getCommunicationHistory(appUserId: appUserId,patientId: UserId, pageNumber: loadingPageNumber);
      if (response is CommunicationHistoryModel) {
        if (loadingPageNumber == 1) {
          communicationHistoryModel.results = response.results;
          setAllMessagesLoading(false);
        } else {
          if (response.results?.length != 0) {
            communicationHistoryModel.results!.insertAll(0, response.results ?? []);
          }
          setPageWiseLoading(false);
        }
        response.results!.length > 0 ? loadingPageNumber++ : null;
        // markChatViewed();
        return communicationHistoryModel;
      }
      else {
        loadingPageNumber == 1
            ? setAllMessagesLoading(false)
            : setPageWiseLoading(false);
        return null;
      }
    } catch (e) {
      loadingPageNumber == 1
          ? setAllMessagesLoading(false)
          : setPageWiseLoading(false);
    }
  }

  Future<dynamic> getGenerateCasesFromMessageList({int? patientId}) async {
    try {
      int? UserId = patientId ?? await _authServices?.getCurrentUserId();
      int? facilityId =  await _authServices?.getFacilityId();
      String? appUserId = await _authServices?.getCurrentAppUserId();

        var response =  _patientCommunicationService?.getGenerateCasesFromMessageList(appUserId: appUserId,patientId: UserId, facility: facilityId);
        // if (response is List<ChatMessageModel> && response.length > 0) {
        //   communicationHistoryModel.results!.insertAll(0, response ?? []);
        //   notifyListeners();
        //   return communicationHistoryModel;
        // }

    } catch (e) {
      print(e.toString());
    }
  }


  getPeriodicMessage({int? patientId}){
    Timer.periodic(Duration(seconds: 4), (timer) {
      if(_applicationRouteService?.currentScreen() == ScreenName.chatHistory){
        getGenerateCasesFromMessageList(patientId: patientId);
      }else{
        timer.cancel();
      }

    });

  }



  Future<dynamic> sendTextMessage(
      {String? message,
      String? fileUrl,
      required ChatMessageType chatMessageType}) async {
    patientId = patientId ??  await _sharedPrefServices?.getCurrentUserId();
    int? facilityId = await _sharedPrefServices?.getFacilityId();
    String? appUserId = await _sharedPrefServices?.getCurrentAppUserId();
    int? userType = await _sharedPrefServices?.getCurrentUserType();
    if(recordingDuration==0) recordingDuration = recordingDuration - 300;
    int chatType = 0;
    int communicationMethod = 1;
    if(userType == 5){
      if(communicationHistoryModel.results?.last.messageType == ChatMessageType.sms) communicationMethod = 0;
    }
    try {

      if (chatMessageType == ChatMessageType.text) chatType = 0;
      if (chatMessageType == ChatMessageType.sms) chatType = 1;
      if (chatMessageType == ChatMessageType.document) chatType = 2;
      if (chatMessageType == ChatMessageType.image) chatType = 3;
      if (chatMessageType == ChatMessageType.audio) chatType = 4;
      isMessageEmpty = true;
      communicationHistoryModel.results!.add(ChatMessageModel(
        id: -1,
        message: message ?? "",
        senderUserId: appUserId,
        isSender: true,
        timeStamp: DateTime.now().toString(),
        data: recordingDuration.toString(),
        // method: ,
      ));
      notifyListeners();
      var body = {
        "message": message,
        "senderUserId": appUserId,
        "patientId": patientId,
        "facilityId": facilityId,
        "method": communicationMethod,
      };
      var response = await _patientCommunicationService?.sendMessage(
          body: body, currentUserAppUserId: currentUserAppUserId);
      if (response is ChatMessageModel) {
        response.isSender = true;
        print("yes run this okay");
        communicationHistoryModel.results!.removeLast();
        response.messageStatus = MessageStatus.not_view;
        response != null ? communicationHistoryModel.results!.add(response as ChatMessageModel) : null;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> markChatViewed() async {
    try {
      var response = await _chatScreenService?.markChatViewed(
          chatGroupId: chatGroupId, currentUserAppUserId: currentUserAppUserId);
      if (response is bool && response) {
        communicationHistoryModel.results!.forEach((element) {
          element.messageStatus = MessageStatus.viewed;
        });
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  /// recording functionality
  startRecording() async {
    startDurationTimer();
    Codec _codec = Codec.aacMP4;
    String _mPath = '${DateTime.now().toString().replaceFirst(' ', '').replaceFirst(".", "")}tau_file.mp4';
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    // await recorderController
        // ?.record(Platform.isIOS ? '${appDirectory.path}/${DateTime.now().toString().replaceAll(" ", "").replaceAll(".", ":")}.aac' : null);
    _mRecorder.startRecorder(toFile: _mPath ,codec: _codec);
    isRecording = true;
    notifyListeners();
  }

  endRecording() async {
    // final path = await recorderController?.stop();
    final path = await _mRecorder.stopRecorder();
    calculateDuration(isStop: true);
    String? res;
    if (path != null) {
      File file;
      Platform.isIOS ? file = File.fromUri(Uri.parse(path)) : file = File(path);
      String? res = await _s3crudService?.uploadFile(file: file);
      print(res);
      isRecording = false;
      notifyListeners();
      return res;
    }
    isRecording = false;
    notifyListeners();
    // return res;
  }

  startDurationTimer() {
    recordingDuration = 0;
    calculateDuration(isStart: true);
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder.openRecorder();
  }

  saveRecording() async {
    String fileUrl = await endRecording();
    if (connectivityService.connectionStatus == ConnectivityResult.none) {
      SnackBarMessage(
          message: "No internet connection detected, please try again.");
    } else {
      await sendTextMessage(
          fileUrl: fileUrl, chatMessageType: ChatMessageType.audio);
      ChatScreen.jumpToListIndex(isDelayed: true);
      print("work");
    }
  }

  pauseRecording() async {
    await _mRecorder.pauseRecorder();
  }

  cancelRecording() async {
    await _mRecorder.closeRecorder();
    calculateDuration();
    isRecording = false;
    notifyListeners();
  }

  Future<bool> RecordingPermission() async {
    var status = await Permission.microphone.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  /// recording functionality

  /// Audio Player Functionality
  ///
  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  int currentIndex = -1;

  ///
  audioPlay.AudioPlayer? audioPlayer;
  late audioPlay.AudioCache _audioCache;
  audioPlay.PlayerState playerState = audioPlay.PlayerState.stopped;
  bool get isPlaying => playerState == audioPlay.PlayerState.playing;
  startAudio(String id) {
    audioPlayer = audioPlay.AudioPlayer(playerId: id);
    // AudioPlayer.logEnabled = true;
    _audioDuration();
  }

  disposeAudioResouces(int chatId, bool isError) {
    audioPlayer?.dispose();
    currentpos = 0;
    currentpostlabel = "00:00";
    playerState = audioPlay.PlayerState.stopped;
    if (isError) {
      isFileDownloadError(chatId, true);
      isFileDownloading(chatId, false);
      currentIndex = -1;
    } else {
      isFileDownloadError(chatId, false);
      isFileDownloading(chatId, true);
      currentIndex = chatId;
      // maxduration = chatMessageList[che]
    }
  }

  _audioDuration() {
    audioPlayer?.onPlayerStateChanged.listen((msg) {
      print('audioPlayer error : $msg');
      switch (msg) {
        case audioPlay.PlayerState.stopped:
          {
            // setState(() {
            playerState = audioPlay.PlayerState.stopped;
            // });
          }
          break;
        case audioPlay.PlayerState.completed:
          {
            // setState(() {
            playerState = audioPlay.PlayerState.completed;
            // });
          }
          break;
      }
    });

    audioPlayer?.onDurationChanged.listen((event) {
      // if(event.inMicroseconds > 0){
      //   maxduration = event.inMilliseconds;
      //   notifyListeners();
      // }
    });

    audioPlayer?.onPositionChanged.listen((Duration p) {
      // if(!(widget.isPlay)){
      //   disposeAudioResouces();
      // }
      if (p.inMilliseconds > maxduration) {
        maxduration = p.inMilliseconds;
        print("Add one second in max ${maxduration}");
      }
      currentpos = p.inMilliseconds;
      //get the current position of playing audio
      //generating the duration label
      print("current postion ${currentpos}");
      if (currentpos == maxduration) {
        print("${currentpos} == ${maxduration}");
      }
      calculateCurrentPostionLable(currentpos);
      if (currentpos < maxduration) {
        //refresh the UI

      }
      notifyListeners();
    });

    audioPlayer?.onPlayerComplete.listen((event) {
      audioPlayer?.seek(Duration());
      playerState = audioPlay.PlayerState.completed;
      currentpos = 0;
      calculateCurrentPostionLable(0);
      print("onPlayerComplete call");
      notifyListeners();
    });
  }

  calculateCurrentPostionLable(int durationInMilliseconds) {
    int shours = Duration(milliseconds: currentpos).inHours;
    int sminutes = Duration(milliseconds: currentpos).inMinutes;
    int sseconds = Duration(milliseconds: currentpos).inSeconds;

    int rhours = shours;
    int rminutes = sminutes - (shours * 60);
    int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

    currentpostlabel = "$rhours:$rminutes:$rseconds";
  }

  calculateDuration(
      {bool isStop = false,
      bool isStart = false,
      bool isPause = false,
      bool isResume = false}) {
    if (isStart) {
      recordingDuration = 0;
      startTime = DateTime.now();
    } else if (isStop) {
      if (startTime != null) {
        recordingDuration = recordingDuration +
            DateTime.now().difference(startTime!).inMilliseconds;
      }
    } else if (isResume) {
      startTime = DateTime.now();
    } else if (isPause) {
      recordingDuration = recordingDuration +
          DateTime.now().difference(startTime!).inMilliseconds;
      startTime = null;
    } else {
      startTime = null;
      recordingDuration = 0;
    }
  }

  playPause(int index, int chatId, String audioUrl) async {
    if (currentIndex != chatId) {
      disposeAudioResouces(chatId, false);
      if (communicationHistoryModel.results?[index].data != null) {
        /// duration in millisecond
        maxduration = (int.parse(communicationHistoryModel.results?[index].data ?? "1"));
        print("Audoi MaxDuration ${maxduration}");
      }
      notifyListeners();
    }
    startAudio(audioUrl);
    if (playerState == audioPlay.PlayerState.playing) {
      final playerResult = await audioPlayer?.pause().whenComplete(() {
        playerState = audioPlay.PlayerState.paused;
        isFileDownloadError(chatId, false);
        isFileDownloading(chatId, false);
        notifyListeners();
      });
    } else if (playerState == audioPlay.PlayerState.paused) {
      final playerResult = await audioPlayer?.resume().whenComplete(() {
        playerState = audioPlay.PlayerState.playing;
        isFileDownloadError(chatId, false);
        isFileDownloading(chatId, false);
        notifyListeners();
      });
    }
    // else if (playerState == audioPlay.PlayerState.completed) {
    //
    //   final playerResult = await audioPlayer?.resume().whenComplete(() {
    //     playerState = audioPlay.PlayerState.playing;
    //     notifyListeners();
    //   }
    //   );
    // }
    else {
      if (playerState == audioPlay.PlayerState.completed) {
        disposeAudioResouces(chatId, false);
        notifyListeners();
      }
      String publicUrl;
      try {
        publicUrl = await _s3crudService?.getPublicUrl(audioUrl) ?? "";
      } catch (ex) {
        isFileDownloadError(chatId, true);
        isFileDownloading(chatId, false);
        notifyListeners();
        return;
      }
      play(publicUrl, chatId);
      // audioPlayer?.setReleaseMode();
    }
  }

  play(String publicUrl, int chatId) async {
    final playerResult = await audioPlayer
        ?.play(audioPlay.UrlSource(publicUrl))
        .whenComplete(() {
      playerState = audioPlay.PlayerState.playing;
      isFileDownloadError(chatId, false);
      isFileDownloading(chatId, false);
      notifyListeners();
    }).onError((error, stackTrace) {
      disposeAudioResouces(chatId, true);
      notifyListeners();
      print("$error");
    }).timeout(Duration(seconds: 7), onTimeout: () {
      disposeAudioResouces(chatId, true);
      notifyListeners();
    });
  }

  isFileDownloading(int chatId, bool downloading) {
    communicationHistoryModel.results?.forEach((element) {
      if (element.id == chatId) {
        element.downloading = downloading;
      } else {
        element.downloading = false;
      }
    });
  }

  bool isAnyFileLoading() {
    return communicationHistoryModel.results
            ?.any((element) => element.downloading == true) ??
        false;
  }

  isFileDownloadError(int chatId, bool isError) {
    communicationHistoryModel.results?.forEach((element) {
      if (element.id == chatId) {
        element.isError = isError;
      } else {
        // element.isError = !isError;
      }
    });
  }

  /// Audio Player Functionality
}
