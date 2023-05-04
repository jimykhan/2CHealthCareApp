import 'package:twochealthcare/models/chat_model/ChatMessage.dart';

class ChatMessageModel {
  int? id;
  int? ringCentralMessageId;
  int? direction;
  int? method;
  int? type;
  String? fromPhoneNumber;
  String? toPhoneNumber;
  String? message;
  String? timeStamp;
  bool? isRead;
  String? senderUserId;
  String? senderName;
  int? patientId;
  String? patientName;
  String? data;

/// Not in Model
  bool? isSender;
  ChatMessageType? messageType;
  MessageStatus? messageStatus;
  bool isError = false;
  bool downloading = false;

  ChatMessageModel(
      {this.id,
        this.ringCentralMessageId,
        this.direction,
        this.method,
        this.type,
        this.fromPhoneNumber,
        this.toPhoneNumber,
        this.message,
        this.timeStamp,
        this.isRead,
        this.senderUserId,
        this.senderName,
        this.patientId,
        this.patientName,
        this.isSender,
        this.isError = false,
        this.downloading = false,
        this.data,
      });

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ringCentralMessageId = json['ringCentralMessageId'];
    direction = json['direction'];
    method = json['method'];
    type = json['type'];
    fromPhoneNumber = json['fromPhoneNumber'];
    toPhoneNumber = json['toPhoneNumber'];
    message = json['message'];
    timeStamp = json['timeStamp'];
    isRead = json['isRead'];
    senderUserId = json['senderUserId'];
    senderName = json['senderName'];
    patientId = json['patientId'];
    patientName = json['patientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ringCentralMessageId'] = this.ringCentralMessageId;
    data['direction'] = this.direction;
    data['method'] = this.method;
    data['type'] = this.type;
    data['fromPhoneNumber'] = this.fromPhoneNumber;
    data['toPhoneNumber'] = this.toPhoneNumber;
    data['message'] = this.message;
    data['timeStamp'] = this.timeStamp;
    data['isRead'] = this.isRead;
    data['senderUserId'] = this.senderUserId;
    data['senderName'] = this.senderName;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    return data;
  }
}