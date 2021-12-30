class StateModel {
  int? id;
  String? name;
  String? code;
  int? countryId;
  String? country;
  String? timeZoneId;
  String? timeZone;
  String? createdOn;
  String? createdUser;
  String? updatedOn;
  String? updatedUser;
  bool? isActiveState;
  bool? isDeletedState;
  int? tenantId;

  StateModel(
      {this.id,
        this.name,
        this.code,
        this.countryId,
        this.country,
        this.timeZoneId,
        this.timeZone,
        this.createdOn,
        this.createdUser,
        this.updatedOn,
        this.updatedUser,
        this.isActiveState,
        this.isDeletedState,
        this.tenantId});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    countryId = json['countryId'];
    country = json['country'];
    timeZoneId = json['timeZoneId'];
    timeZone = json['timeZone'];
    createdOn = json['createdOn'];
    createdUser = json['createdUser'];
    updatedOn = json['updatedOn'];
    updatedUser = json['updatedUser'];
    isActiveState = json['isActiveState'];
    isDeletedState = json['isDeletedState'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['countryId'] = this.countryId;
    data['country'] = this.country;
    data['timeZoneId'] = this.timeZoneId;
    data['timeZone'] = this.timeZone;
    data['createdOn'] = this.createdOn;
    data['createdUser'] = this.createdUser;
    data['updatedOn'] = this.updatedOn;
    data['updatedUser'] = this.updatedUser;
    data['isActiveState'] = this.isActiveState;
    data['isDeletedState'] = this.isDeletedState;
    data['tenantId'] = this.tenantId;
    return data;
  }
}