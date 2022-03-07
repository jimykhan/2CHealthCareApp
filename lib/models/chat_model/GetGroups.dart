class GetGroupsModel {
  int? id;
  String? title;
  String? channelName;
  String? dateCreated;
  String? lastMessage;
  String? lastMessageTime;
  int? unreadMsgCount;
  bool? isNewGroup;
  List<Participants?>? participants;

  /// not in model
  String? timeStamp;

  GetGroupsModel(
      {this.id,
        this.title,
        this.channelName,
        this.dateCreated,
        this.lastMessage,
        this.lastMessageTime,
        this.unreadMsgCount,
        this.isNewGroup,
        this.participants,
        this.timeStamp
      });

  GetGroupsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    channelName = json['channelName'];
    dateCreated = json['dateCreated'];
    lastMessage = json['lastMessage'];
    lastMessageTime = json['lastMessageTime'];
    unreadMsgCount = json['unreadMsgCount'];
    isNewGroup = json['isNewGroup'];
    if (json['participants'] != null) {
      participants =  [];
      json['participants'].forEach((v) {
        participants?.add(new Participants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['channelName'] = this.channelName;
    data['dateCreated'] = this.dateCreated;
    data['lastMessage'] = this.lastMessage;
    data['lastMessageTime'] = this.lastMessageTime;
    data['unreadMsgCount'] = this.unreadMsgCount;
    data['isNewGroup'] = this.isNewGroup;
    if (this.participants != null) {
      data['participants'] = this.participants?.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}

class Participants {
  String? appUserId;
  String? name;
  String? userName;
  String? email;
  int? userType;

  Participants(
      {this.appUserId, this.name, this.userName, this.email, this.userType});

  Participants.fromJson(Map<String, dynamic> json) {
    appUserId = json['appUserId'];
    name = json['name'];
    userName = json['userName'];
    email = json['email'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appUserId'] = this.appUserId;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['userType'] = this.userType;
    return data;
  }
}