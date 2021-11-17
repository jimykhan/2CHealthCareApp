enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

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

  bool? isSender;
  ChatMessageType? messageType;
  MessageStatus? messageStatus;

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
        this.isSender
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
    return data;
  }
}

List demeChatMessages = [


];
