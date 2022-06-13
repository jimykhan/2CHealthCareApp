class PatientsModel {
  int? id;
  String? userId;
  String? patientEmrId;
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  String? city;
  String? serviceName;
  String? dateOfBirth;
  String? primaryPhoneNumber;
  String? countryCallingCode;
  String? state;
  String? country;
  bool? isConsentTaken;
  String? modifiedDate;
  int? billingProviderId;
  String? billingProviderName;
  String? billingProviderNameAbbreviation;
  int? careFacilitatorId;
  String? careFacilitatorName;
  String? careFacilitatorNameAbbreviation;
  List<int>? careProviderIds;
  List<String>? careProviderNames;
  List<CareProviders>? careProviders;
  List<ToolTip>? toolTip;
  List<int>? chronicDiseasesIds;
  int? currentMonthCompletedTime;
  String? currentMonthCompletedTimeString;
  bool? profileStatus;
  String? sex;
  int? dueGapsCount;
  int? patientStatus;
  int? assigned;
  int? rpmStatus;
  int? ccmStatus;
  int? bhiStatus;
  int? ccmMonthlyStatus;
  bool? msQualityChecked;
  String? msQualityCheckedByName;
  String? msQualityCheckedDate;
  String? msQualityCheckedByNameAbbreviation;
  String? dateAssigned;
  int? facilityId;
  int? insurancePlanId;
  String? ccmDate;
  String? ccmMinutes;
  String? lastCcm;
  String? recentPcpAppointment;
  bool? isDeleted;
  bool? phoneNumberConfirmed;
  bool? emailConfirmed;
  bool? isBHIRevoked;
  bool? isCCMRevoked;
  bool? isRPMRevoked;
  bool? ccmFlagged;
  String? lastAppLaunchDate;

  /// not in model
  bool? isActve;
  int? age;
  String? primaryPhoneNoWithCountryCode;


  PatientsModel(
      {this.id,
        this.userId,
        this.patientEmrId,
        this.fullName,
        this.firstName,
        this.lastName,
        this.email,
        this.city,
        this.serviceName,
        this.dateOfBirth,
        this.primaryPhoneNumber,
        this.state,
        this.country,
        this.isConsentTaken,
        this.modifiedDate,
        this.billingProviderId,
        this.billingProviderName,
        this.billingProviderNameAbbreviation,
        this.careFacilitatorId,
        this.careFacilitatorName,
        this.careFacilitatorNameAbbreviation,
        this.careProviderIds,
        this.careProviderNames,
        this.careProviders,
        this.toolTip,
        this.chronicDiseasesIds,
        this.currentMonthCompletedTime,
        this.currentMonthCompletedTimeString,
        this.profileStatus,
        this.sex,
        this.dueGapsCount,
        this.patientStatus,
        this.assigned,
        this.rpmStatus,
        this.ccmStatus,
        this.bhiStatus,
        this.ccmMonthlyStatus,
        this.msQualityChecked,
        this.msQualityCheckedByName,
        this.msQualityCheckedDate,
        this.msQualityCheckedByNameAbbreviation,
        this.dateAssigned,
        this.facilityId,
        this.insurancePlanId,
        this.ccmDate,
        this.ccmMinutes,
        this.lastCcm,
        this.recentPcpAppointment,
        this.isDeleted,
        this.phoneNumberConfirmed,
        this.emailConfirmed,
        this.isBHIRevoked,
        this.isCCMRevoked,
        this.isRPMRevoked,
        this.ccmFlagged,
        this.lastAppLaunchDate,
        this.isActve = false,
        this.age,
        this.countryCallingCode,
        this.primaryPhoneNoWithCountryCode,
      });

  PatientsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId']??"";
    patientEmrId = json['patientEmrId']??"";
    fullName = json['fullName']??"";
    firstName = json['firstName']??"";
    lastName = json['lastName']??"";
    email = json['email']??"";
    city = json['city']??"";
    serviceName = json['serviceName']??"";
    dateOfBirth = json['dateOfBirth']??"";
    primaryPhoneNumber = json['primaryPhoneNumber']??"";
    state = json['state']??"";
    country = json['country']??"";
    isConsentTaken = json['isConsentTaken']??false;
    modifiedDate = json['modifiedDate']??"";
    billingProviderId = json['billingProviderId']??1;
    billingProviderName = json['billingProviderName']??"";
    billingProviderNameAbbreviation = json['billingProviderNameAbbreviation']??"";
    careFacilitatorId = json['careFacilitatorId']??1;
    careFacilitatorName = json['careFacilitatorName']??"";
    careFacilitatorNameAbbreviation = json['careFacilitatorNameAbbreviation']??"";
    if(json['careProviderIds'] != null){
      careProviderIds = <int>[];
      json['careProviderIds'].forEach((v) {
        careProviderIds?.add(v);
      });
    }
    if(json['careProviderNames'] != null){
      careProviderNames = <String>[];
      json['careProviderNames'].forEach((v) {
        careProviderNames!.add(v);
      });
    }
    if (json['careProviders'] != null) {
      careProviders = <CareProviders>[];
      json['careProviders'].forEach((v) {
        careProviders!.add(new CareProviders.fromJson(v));
      });
    }
    if (json['toolTip'] != null) {
      toolTip = <ToolTip>[];
      json['toolTip'].forEach((v) {
        toolTip!.add(new ToolTip.fromJson(v));
      });
    }
    if(json['chronicDiseasesIds'] != null){
      chronicDiseasesIds = <int>[];
      json['chronicDiseasesIds'].forEach((v) {
        chronicDiseasesIds!.add(v);
      });
    }
    currentMonthCompletedTime = json['currentMonthCompletedTime'];
    currentMonthCompletedTimeString = json['currentMonthCompletedTimeString'];
    profileStatus = json['profileStatus'];
    sex = json['sex'];
    dueGapsCount = json['dueGapsCount'];
    patientStatus = json['patientStatus'];
    assigned = json['assigned'];
    rpmStatus = json['rpmStatus'];
    ccmStatus = json['ccmStatus'];
    bhiStatus = json['bhiStatus'];
    ccmMonthlyStatus = json['ccmMonthlyStatus'];
    msQualityChecked = json['msQualityChecked'];
    msQualityCheckedByName = json['msQualityCheckedByName'];
    msQualityCheckedDate = json['msQualityCheckedDate'];
    msQualityCheckedByNameAbbreviation =
    json['msQualityCheckedByNameAbbreviation'];
    dateAssigned = json['dateAssigned'];
    facilityId = json['facilityId'];
    insurancePlanId = json['insurancePlanId'];
    ccmDate = json['ccmDate'];
    ccmMinutes = json['ccmMinutes'];
    lastCcm = json['lastCcm'];
    recentPcpAppointment = json['recentPcpAppointment'];
    isDeleted = json['isDeleted'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    emailConfirmed = json['emailConfirmed'];
    isBHIRevoked = json['isBHIRevoked'];
    isCCMRevoked = json['isCCMRevoked'];
    isRPMRevoked = json['isRPMRevoked'];
    ccmFlagged = json['ccmFlagged'];
    lastAppLaunchDate = json['lastAppLaunchDate'];
    countryCallingCode = json['countryCallingCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['patientEmrId'] = this.patientEmrId;
    data['fullName'] = this.fullName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['city'] = this.city;
    data['serviceName'] = this.serviceName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['primaryPhoneNumber'] = this.primaryPhoneNumber;
    data['state'] = this.state;
    data['country'] = this.country;
    data['isConsentTaken'] = this.isConsentTaken;
    data['modifiedDate'] = this.modifiedDate;
    data['billingProviderId'] = this.billingProviderId;
    data['billingProviderName'] = this.billingProviderName;
    data['billingProviderNameAbbreviation'] =
        this.billingProviderNameAbbreviation;
    data['careFacilitatorId'] = this.careFacilitatorId;
    data['careFacilitatorName'] = this.careFacilitatorName;
    data['careFacilitatorNameAbbreviation'] =
        this.careFacilitatorNameAbbreviation;
    data['careProviderIds'] = this.careProviderIds;
    data['careProviderNames'] = this.careProviderNames;
    if (this.careProviders != null) {
      data['careProviders'] =
          this.careProviders!.map((v) => v.toJson()).toList();
    }
    if (this.toolTip != null) {
      data['toolTip'] = this.toolTip!.map((v) => v.toJson()).toList();
    }
    data['chronicDiseasesIds'] = this.chronicDiseasesIds;
    data['currentMonthCompletedTime'] = this.currentMonthCompletedTime;
    data['currentMonthCompletedTimeString'] =
        this.currentMonthCompletedTimeString;
    data['profileStatus'] = this.profileStatus;
    data['sex'] = this.sex;
    data['dueGapsCount'] = this.dueGapsCount;
    data['patientStatus'] = this.patientStatus;
    data['assigned'] = this.assigned;
    data['rpmStatus'] = this.rpmStatus;
    data['ccmStatus'] = this.ccmStatus;
    data['bhiStatus'] = this.bhiStatus;
    data['ccmMonthlyStatus'] = this.ccmMonthlyStatus;
    data['msQualityChecked'] = this.msQualityChecked;
    data['msQualityCheckedByName'] = this.msQualityCheckedByName;
    data['msQualityCheckedDate'] = this.msQualityCheckedDate;
    data['msQualityCheckedByNameAbbreviation'] =
        this.msQualityCheckedByNameAbbreviation;
    data['dateAssigned'] = this.dateAssigned;
    data['facilityId'] = this.facilityId;
    data['insurancePlanId'] = this.insurancePlanId;
    data['ccmDate'] = this.ccmDate;
    data['ccmMinutes'] = this.ccmMinutes;
    data['lastCcm'] = this.lastCcm;
    data['recentPcpAppointment'] = this.recentPcpAppointment;
    data['isDeleted'] = this.isDeleted;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['emailConfirmed'] = this.emailConfirmed;
    data['isBHIRevoked'] = this.isBHIRevoked;
    data['isCCMRevoked'] = this.isCCMRevoked;
    data['isRPMRevoked'] = this.isRPMRevoked;
    data['ccmFlagged'] = this.ccmFlagged;
    data['lastAppLaunchDate'] = this.lastAppLaunchDate;
    data['countryCallingCode'] = this.countryCallingCode;
    return data;
  }
}


class CareProviders {
  int? careProviderId;
  String? fullName;
  String? nameAbbreviation;

  CareProviders({this.careProviderId, this.fullName, this.nameAbbreviation});

  CareProviders.fromJson(Map<String, dynamic> json) {
    careProviderId = json['careProviderId'];
    fullName = json['fullName'];
    nameAbbreviation = json['nameAbbreviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['careProviderId'] = this.careProviderId;
    data['fullName'] = this.fullName;
    data['nameAbbreviation'] = this.nameAbbreviation;
    return data;
  }
}

class ToolTip {
  String? serviceName;
  String? dateAssigned;
  String? lastEncounterDate;

  ToolTip({this.serviceName, this.dateAssigned, this.lastEncounterDate});

  ToolTip.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    dateAssigned = json['dateAssigned'];
    lastEncounterDate = json['lastEncounterDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceName'] = this.serviceName;
    data['dateAssigned'] = this.dateAssigned;
    data['lastEncounterDate'] = this.lastEncounterDate;
    return data;
  }
}