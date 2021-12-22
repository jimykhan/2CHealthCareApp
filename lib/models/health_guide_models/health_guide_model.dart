class HealthGuideModel {
  int? id;
  String? title;
  String? url;
  String? createdOn;
  String? updatedOn;

  HealthGuideModel(
      {this.id, this.title, this.url, this.createdOn, this.updatedOn});

  HealthGuideModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}