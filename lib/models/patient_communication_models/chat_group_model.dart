
import 'package:twochealthcare/models/patient_communication_models/chat_message_model.dart';

class ChatGroupModel {
  int? id;
  String? name;
  String? lastMessage;
  String? lastMessageTime;
  ChatMessageModel? lastCommunication;

  /// not in model
  String? timeStamp;

  ChatGroupModel({this.id, this.name, this.lastMessage, this.lastMessageTime,this.timeStamp,this.lastCommunication});

  ChatGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastMessage = json['lastMessage'];
    lastMessageTime = json['lastMessageTime'];
    lastCommunication = json['lastCommunication'] != null
        ? new ChatMessageModel.fromJson(json['lastCommunication'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastMessage'] = this.lastMessage;
    data['lastMessageTime'] = this.lastMessageTime;
    if (this.lastCommunication != null) {
      data['lastCommunication'] = this.lastCommunication!.toJson();
    }
    return data;
  }
}