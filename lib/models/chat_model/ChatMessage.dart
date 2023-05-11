enum ChatMessageType { text, sms, document, image, audio, video }
enum MessageStatus { not_sent, not_view, viewed }



class ChatHistoryModel {
  List<ChatMessage>? chats;
  List<Participients>? participients;

  ChatHistoryModel({this.chats, this.participients});

  ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['chats'] != null) {
      chats = <ChatMessage>[];
      json['chats'].forEach((v) {
        chats!.add(new ChatMessage.fromJson(v));
      });
    }
    if (json['participients'] != null) {
      participients = <Participients>[];
      json['participients'].forEach((v) {
        participients!.add(new Participients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    if (this.participients != null) {
      data['participients'] =
          this.participients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Participients {
  String? userId;
  String? fullName;
  String? shortName;
  int? readIndex;
  String? email;

  Participients(
      {this.userId, this.fullName, this.shortName, this.readIndex, this.email});

  Participients.fromJson(Map<String, dynamic> json) {
    userId = json['userId']??json['UserId'];
    fullName = json['fullName']??json['FullName'];
    shortName = json['shortName']??json['ShortName'];
    readIndex = json['readIndex']??json['ReadIndex'];
    email = json['email']??json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['FullName'] = this.fullName;
    data['ShortName'] = this.shortName;
    data['ReadIndex'] = this.readIndex;
    data['Email'] = this.email;
    return data;
  }
}

class ChatMessage {
  int? id;
  String? message;
  String? linkUrl;
  String? timeStamp;
  String? timeToken;
  bool? sentToAll;
  bool? viewedByAll;
  String? senderUserId;
  String? senderName;
  int? chatGroupId;
  String? channelName;
  int? chatType;
  String? data;


  bool? isSender;
  ChatMessageType? messageType;
  MessageStatus? messageStatus;
  bool isError = false;
  bool downloading = false;

  ChatMessage(
      {this.id,
        this.message,
        this.linkUrl,
        this.timeStamp,
        this.timeToken,
        this.sentToAll,
        this.viewedByAll,
        this.senderUserId,
        this.senderName,
        this.chatGroupId,
        this.channelName,
        this.messageType,
        this.messageStatus,
        this.isSender,
        this.chatType,
        this.isError = false,
        this.downloading = false,
        this.data,
      });

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    linkUrl = json['linkUrl'];
    timeStamp = json['timeStamp'];
    timeToken = json['timeToken'];
    sentToAll = json['sentToAll'];
    viewedByAll = json['viewedByAll'];
    senderUserId = json['senderUserId'];
    senderName = json['senderName'];
    chatGroupId = json['chatGroupId'];
    channelName = json['channelName'];
    chatType = json['chatType'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['linkUrl'] = this.linkUrl;
    data['timeStamp'] = this.timeStamp;
    data['timeToken'] = this.timeToken;
    data['sentToAll'] = this.sentToAll;
    data['viewedByAll'] = this.viewedByAll;
    data['senderUserId'] = this.senderUserId;
    data['senderName'] = this.senderName;
    data['chatGroupId'] = this.chatGroupId;
    data['channelName'] = this.channelName;
    data['chatType'] = this.chatType;
    return data;
  }
}

List demeChatMessages = [


];
