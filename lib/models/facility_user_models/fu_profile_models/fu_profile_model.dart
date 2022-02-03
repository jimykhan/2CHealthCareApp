import 'package:twochealthcare/models/facility_user_models/fu_profile_models/facility_model.dart';
import 'package:twochealthcare/models/facility_user_models/fu_profile_models/organization.dart';

class FUProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? nameAbbrevation;
  String? userName;
  String? title;
  bool? isSiteManager;
  bool? hasAuthenticator;
  bool? twoFactorEnabled;
  String? phoneNo;
  bool? isPhoneNumberVerified;
  String? email;
  bool? isEmailVerified;
  List<String>? assignedFacilities;
  String? roles;
  String? profileImagePath;
  String? profileImagePublicUrl;
  bool? isActive;
  FacilityDto? facilityDto;
  Organization? organization;

  FUProfileModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.middleName,
        this.nameAbbrevation,
        this.userName,
        this.title,
        this.isSiteManager,
        this.hasAuthenticator,
        this.twoFactorEnabled,
        this.phoneNo,
        this.isPhoneNumberVerified,
        this.email,
        this.isEmailVerified,
        this.assignedFacilities,
        this.roles,
        this.profileImagePath,
        this.profileImagePublicUrl,
        this.isActive,
        this.facilityDto,
        this.organization});

  FUProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    nameAbbrevation = json['nameAbbrevation'];
    userName = json['userName'];
    title = json['title'];
    isSiteManager = json['isSiteManager'];
    hasAuthenticator = json['hasAuthenticator'];
    twoFactorEnabled = json['twoFactorEnabled'];
    phoneNo = json['phoneNo'];
    isPhoneNumberVerified = json['isPhoneNumberVerified'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    assignedFacilities = json['assignedFacilities'].cast<String>();
    roles = json['roles'];
    profileImagePath = json['profileImagePath'];
    profileImagePublicUrl = json['profileImagePublicUrl'];
    isActive = json['isActive'];
    facilityDto = json['facilityDto'] != null
        ? new FacilityDto.fromJson(json['facilityDto'])
        : null;
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['nameAbbrevation'] = this.nameAbbrevation;
    data['userName'] = this.userName;
    data['title'] = this.title;
    data['isSiteManager'] = this.isSiteManager;
    data['hasAuthenticator'] = this.hasAuthenticator;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['phoneNo'] = this.phoneNo;
    data['isPhoneNumberVerified'] = this.isPhoneNumberVerified;
    data['email'] = this.email;
    data['isEmailVerified'] = this.isEmailVerified;
    data['assignedFacilities'] = this.assignedFacilities;
    data['roles'] = this.roles;
    data['profileImagePath'] = this.profileImagePath;
    data['profileImagePublicUrl'] = this.profileImagePublicUrl;
    data['isActive'] = this.isActive;
    if (this.facilityDto != null) {
      data['facilityDto'] = this.facilityDto!.toJson();
    }
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    return data;
  }
}