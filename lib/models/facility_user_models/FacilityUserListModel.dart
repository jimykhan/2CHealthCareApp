class FacilityUserListModel {
  int? id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? fullName;
  String? title;
  String? roles;
  List<int>? roleIds;
  int? contactPreferenceId;
  String? phoneNo;
  bool? isSiteManager;
  bool? isActive;
  String? userId;
  int? facilityId;
  String? email;
  String? userName;
  bool? isVerified;
  bool? isPhoneNumberVerified;
  bool? isEmailVerified;

  FacilityUserListModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.middleName,
        this.fullName,
        this.title,
        this.roles,
        this.roleIds,
        this.contactPreferenceId,
        this.phoneNo,
        this.isSiteManager,
        this.isActive,
        this.userId,
        this.facilityId,
        this.email,
        this.userName,
        this.isVerified,
        this.isPhoneNumberVerified,
        this.isEmailVerified});

  FacilityUserListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    fullName = json['fullName'];
    title = json['title'];
    roles = json['roles'];
    roleIds = json['roleIds'].cast<int>();
    contactPreferenceId = json['contactPreferenceId'];
    phoneNo = json['phoneNo'];
    isSiteManager = json['isSiteManager'];
    isActive = json['isActive'];
    userId = json['userId'];
    facilityId = json['facilityId'];
    email = json['email'];
    userName = json['userName'];
    isVerified = json['isVerified'];
    isPhoneNumberVerified = json['isPhoneNumberVerified'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['fullName'] = this.fullName;
    data['title'] = this.title;
    data['roles'] = this.roles;
    data['roleIds'] = this.roleIds;
    data['contactPreferenceId'] = this.contactPreferenceId;
    data['phoneNo'] = this.phoneNo;
    data['isSiteManager'] = this.isSiteManager;
    data['isActive'] = this.isActive;
    data['userId'] = this.userId;
    data['facilityId'] = this.facilityId;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['isVerified'] = this.isVerified;
    data['isPhoneNumberVerified'] = this.isPhoneNumberVerified;
    data['isEmailVerified'] = this.isEmailVerified;
    return data;
  }
}