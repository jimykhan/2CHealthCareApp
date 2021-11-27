class LogedInUserModel {
  int? id;
  String? userName;
  String? lastLogedIn;

  LogedInUserModel({this.id, this.userName, this.lastLogedIn});

  LogedInUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    lastLogedIn = json['lastLogedIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['lastLogedIn'] = this.lastLogedIn;
    return data;
  }
}