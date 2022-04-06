class CcmServiceType {
  int? id;
  String? name;
  bool? isFav;
  String? createdOn;
  String? createdUser;
  String? updatedOn;
  String? updatedUser;
  bool? isActiveState;
  bool? isDeletedState;

  CcmServiceType(
      {this.id,
        this.name,
        this.isFav,
        this.createdOn,
        this.createdUser,
        this.updatedOn,
        this.updatedUser,
        this.isActiveState,
        this.isDeletedState});

  CcmServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isFav = json['isFav'];
    createdOn = json['createdOn'];
    createdUser = json['createdUser'];
    updatedOn = json['updatedOn'];
    updatedUser = json['updatedUser'];
    isActiveState = json['isActiveState'];
    isDeletedState = json['isDeletedState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isFav'] = this.isFav;
    data['createdOn'] = this.createdOn;
    data['createdUser'] = this.createdUser;
    data['updatedOn'] = this.updatedOn;
    data['updatedUser'] = this.updatedUser;
    data['isActiveState'] = this.isActiveState;
    data['isDeletedState'] = this.isDeletedState;
    return data;
  }
}