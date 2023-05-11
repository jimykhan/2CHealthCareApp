class ChatSummaryDataModel {
  int? unread;
  int? critical;
  int? following;
  int? anonymous;

  ChatSummaryDataModel(
      {this.unread, this.critical, this.following, this.anonymous});

  ChatSummaryDataModel.fromJson(Map<String, dynamic> json) {
    unread = json['unread'];
    critical = json['critical'];
    following = json['following'];
    anonymous = json['anonymous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unread'] = this.unread;
    data['critical'] = this.critical;
    data['following'] = this.following;
    data['anonymous'] = this.anonymous;
    return data;
  }
}