import 'package:twochealthcare/models/profile_models/care_plan_approval_model.dart';
import 'package:twochealthcare/models/profile_models/care_provider_model.dart';
import 'package:twochealthcare/models/profile_models/diagnoses_model.dart';
import 'package:twochealthcare/models/profile_models/medications_model.dart';
import 'package:twochealthcare/models/profile_models/patient_consents_model.dart';
import 'package:twochealthcare/models/profile_models/specialists_model.dart';

class CurrentUserInfo {
  int? id;
  String? patientEmrId;
  String? nextGenId;
  String? socialSecurityNumber;
  String? medicalRecordNumber;
  String? otherIdNumber;
  String? insuranceNumber;
  String? medicareNumber;
  String? planAYear;
  String? planAMonth;
  String? planBYear;
  String? planBMonth;
  String? email;
  String? userName;
  String? password;
  bool? isDeleted;
  bool? isBHIRevoked;
  bool? isCCMRevoked;
  bool? isRPMRevoked;
  bool? hasAuthenticator;
  bool? twoFactorEnabled;
  bool? ccmNotBillable;
  int? patientStatus;
  int? assigned;
  int? rpmStatus;
  int? ccmStatus;
  int? bhiStatus;
  int? ccmMonthlyStatus;
  bool? msQualityChecked;
  String? msQualityCheckedByName;
  String? firstName;
  String? lastName;
  String? middleName;
  String? fullName;
  String? nickname;
  String? currentAddress;
  String? mailingAddress;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? homePhone;
  bool? phoneNumberConfirmed;
  String? dateOfBirth;
  int? consentType;
  String? consentDocUrl;
  bool? isConsentTaken;
  String? consentDate;
  String? sex;
  String? personNumber;
  String? dateAssigned;
  String? currentMonthCompletedTime;
  String? currentMonthRemainingTime;
  String? bestTimeToCall;
  String? preferredLanguage;
  String? emergencyContactName;
  String? emergencyContactRelationship;
  String? emergencyContactPrimaryPhoneNo;
  String? emergencyContactSecondaryPhoneNo;
  String? emergencyPlan;
  String? maillingAddressState;
  String? maillingAddressCity;
  String? maillingAddressZipCode;
  String? billingProviderName;
  List<CareProviders>? careProviders;
  String? careFacilitatorName;
  String? careFacilitatorNameAbbreviation;
  int? careFacilitatorId;
  int? billingProviderId;
  int? facilityId;
  int? bhiCareManagerId;
  int? psychiatristId;
  int? insurancePlanId;
  String? insurancePlanName;
  bool? profileStatus;
  String? userId;
  List<int>? chronicDiseasesIds;
  List<DiagnosesList>? diagnosesList;
  List<Medications>? medications;
  List<Specialists>? specialists;
  List<CarePlanApproval>? carePlanApproval;
  List<PatientConsents>? patientConsents;

  CurrentUserInfo(
      {this.id,
        this.patientEmrId,
        this.nextGenId,
        this.socialSecurityNumber,
        this.medicalRecordNumber,
        this.otherIdNumber,
        this.insuranceNumber,
        this.medicareNumber,
        this.planAYear,
        this.planAMonth,
        this.planBYear,
        this.planBMonth,
        this.email,
        this.userName,
        this.password,
        this.isDeleted,
        this.isBHIRevoked,
        this.isCCMRevoked,
        this.isRPMRevoked,
        this.hasAuthenticator,
        this.twoFactorEnabled,
        this.ccmNotBillable,
        this.patientStatus,
        this.assigned,
        this.rpmStatus,
        this.ccmStatus,
        this.bhiStatus,
        this.ccmMonthlyStatus,
        this.msQualityChecked,
        this.msQualityCheckedByName,
        this.firstName,
        this.lastName,
        this.middleName,
        this.fullName,
        this.nickname,
        this.currentAddress,
        this.mailingAddress,
        this.city,
        this.state,
        this.zip,
        this.country,
        this.homePhone,
        this.phoneNumberConfirmed,
        this.dateOfBirth,
        this.consentType,
        this.consentDocUrl,
        this.isConsentTaken,
        this.consentDate,
        this.sex,
        this.personNumber,
        this.dateAssigned,
        this.currentMonthCompletedTime,
        this.currentMonthRemainingTime,
        this.bestTimeToCall,
        this.preferredLanguage,
        this.emergencyContactName,
        this.emergencyContactRelationship,
        this.emergencyContactPrimaryPhoneNo,
        this.emergencyContactSecondaryPhoneNo,
        this.emergencyPlan,
        this.maillingAddressState,
        this.maillingAddressCity,
        this.maillingAddressZipCode,
        this.billingProviderName,
        this.careProviders,
        this.careFacilitatorName,
        this.careFacilitatorNameAbbreviation,
        this.careFacilitatorId,
        this.billingProviderId,
        this.facilityId,
        this.bhiCareManagerId,
        this.psychiatristId,
        this.insurancePlanId,
        this.insurancePlanName,
        this.profileStatus,
        this.userId,
        this.chronicDiseasesIds,
        this.diagnosesList,
        this.medications,
        this.specialists,
        this.carePlanApproval,
        this.patientConsents});

  CurrentUserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientEmrId = json['patientEmrId'];
    nextGenId = json['nextGenId'];
    socialSecurityNumber = json['socialSecurityNumber'];
    medicalRecordNumber = json['medicalRecordNumber'];
    otherIdNumber = json['otherIdNumber'];
    insuranceNumber = json['insuranceNumber'];
    medicareNumber = json['medicareNumber'];
    planAYear = json['planAYear'];
    planAMonth = json['planAMonth'];
    planBYear = json['planBYear'];
    planBMonth = json['planBMonth'];
    email = json['email'];
    userName = json['userName'];
    password = json['password'];
    isDeleted = json['isDeleted'];
    isBHIRevoked = json['isBHIRevoked'];
    isCCMRevoked = json['isCCMRevoked'];
    isRPMRevoked = json['isRPMRevoked'];
    hasAuthenticator = json['hasAuthenticator'];
    twoFactorEnabled = json['twoFactorEnabled'];
    ccmNotBillable = json['ccmNotBillable'];
    patientStatus = json['patientStatus'];
    assigned = json['assigned'];
    rpmStatus = json['rpmStatus'];
    ccmStatus = json['ccmStatus'];
    bhiStatus = json['bhiStatus'];
    ccmMonthlyStatus = json['ccmMonthlyStatus'];
    msQualityChecked = json['msQualityChecked'];
    msQualityCheckedByName = json['msQualityCheckedByName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    fullName = json['fullName'];
    nickname = json['nickname'];
    currentAddress = json['currentAddress'];
    mailingAddress = json['mailingAddress'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    homePhone = json['homePhone'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    dateOfBirth = json['dateOfBirth'];
    consentType = json['consentType'];
    consentDocUrl = json['consentDocUrl'];
    isConsentTaken = json['isConsentTaken'];
    consentDate = json['consentDate'];
    sex = json['sex'];
    personNumber = json['personNumber'];
    dateAssigned = json['dateAssigned'];
    currentMonthCompletedTime = json['currentMonthCompletedTime'];
    currentMonthRemainingTime = json['currentMonthRemainingTime'];
    bestTimeToCall = json['bestTimeToCall'];
    preferredLanguage = json['preferredLanguage'];
    emergencyContactName = json['emergencyContactName'];
    emergencyContactRelationship = json['emergencyContactRelationship'];
    emergencyContactPrimaryPhoneNo = json['emergencyContactPrimaryPhoneNo'];
    emergencyContactSecondaryPhoneNo = json['emergencyContactSecondaryPhoneNo'];
    emergencyPlan = json['emergencyPlan'];
    maillingAddressState = json['maillingAddressState'];
    maillingAddressCity = json['maillingAddressCity'];
    maillingAddressZipCode = json['maillingAddressZipCode'];
    billingProviderName = json['billingProviderName'];
    if (json['careProviders'] != null) {
      careProviders = <CareProviders>[];
      json['careProviders'].forEach((v) {
        careProviders!.add(CareProviders.fromJson(v));
      });
    }
    careFacilitatorName = json['careFacilitatorName'];
    careFacilitatorNameAbbreviation = json['careFacilitatorNameAbbreviation'];
    careFacilitatorId = json['careFacilitatorId'];
    billingProviderId = json['billingProviderId'];
    facilityId = json['facilityId'];
    bhiCareManagerId = json['bhiCareManagerId'];
    psychiatristId = json['psychiatristId'];
    insurancePlanId = json['insurancePlanId'];
    insurancePlanName = json['insurancePlanName'];
    profileStatus = json['profileStatus'];
    userId = json['userId'];
    chronicDiseasesIds = json['chronicDiseasesIds'].cast<int>();
    if (json['diagnosesList'] != null) {
      diagnosesList = <DiagnosesList>[];
      json['diagnosesList'].forEach((v) {
        diagnosesList!.add(new DiagnosesList.fromJson(v));
      });
    }
    if (json['medications'] != null) {
      medications = <Medications>[];
      json['medications'].forEach((v) {
        medications!.add(new Medications.fromJson(v));
      });
    }
    if (json['specialists'] != null) {
      specialists =  <Specialists>[];
      json['specialists'].forEach((v) {
        specialists!.add(new Specialists.fromJson(v));
      });
    }
    if (json['carePlanApproval'] != null) {
      carePlanApproval = <CarePlanApproval>[];
      json['carePlanApproval'].forEach((v) {
        carePlanApproval!.add(new CarePlanApproval.fromJson(v));
      });
    }
    if (json['patientConsents'] != null) {
      patientConsents = <PatientConsents>[];
      json['patientConsents'].forEach((v) {
        patientConsents!.add(PatientConsents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientEmrId'] = this.patientEmrId;
    data['nextGenId'] = this.nextGenId;
    data['socialSecurityNumber'] = this.socialSecurityNumber;
    data['medicalRecordNumber'] = this.medicalRecordNumber;
    data['otherIdNumber'] = this.otherIdNumber;
    data['insuranceNumber'] = this.insuranceNumber;
    data['medicareNumber'] = this.medicareNumber;
    data['planAYear'] = this.planAYear;
    data['planAMonth'] = this.planAMonth;
    data['planBYear'] = this.planBYear;
    data['planBMonth'] = this.planBMonth;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['isDeleted'] = this.isDeleted;
    data['isBHIRevoked'] = this.isBHIRevoked;
    data['isCCMRevoked'] = this.isCCMRevoked;
    data['isRPMRevoked'] = this.isRPMRevoked;
    data['hasAuthenticator'] = this.hasAuthenticator;
    data['twoFactorEnabled'] = this.twoFactorEnabled;
    data['ccmNotBillable'] = this.ccmNotBillable;
    data['patientStatus'] = this.patientStatus;
    data['assigned'] = this.assigned;
    data['rpmStatus'] = this.rpmStatus;
    data['ccmStatus'] = this.ccmStatus;
    data['bhiStatus'] = this.bhiStatus;
    data['ccmMonthlyStatus'] = this.ccmMonthlyStatus;
    data['msQualityChecked'] = this.msQualityChecked;
    data['msQualityCheckedByName'] = this.msQualityCheckedByName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['fullName'] = this.fullName;
    data['nickname'] = this.nickname;
    data['currentAddress'] = this.currentAddress;
    data['mailingAddress'] = this.mailingAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['homePhone'] = this.homePhone;
    data['phoneNumberConfirmed'] = this.phoneNumberConfirmed;
    data['dateOfBirth'] = this.dateOfBirth;
    data['consentType'] = this.consentType;
    data['consentDocUrl'] = this.consentDocUrl;
    data['isConsentTaken'] = this.isConsentTaken;
    data['consentDate'] = this.consentDate;
    data['sex'] = this.sex;
    data['personNumber'] = this.personNumber;
    data['dateAssigned'] = this.dateAssigned;
    data['currentMonthCompletedTime'] = this.currentMonthCompletedTime;
    data['currentMonthRemainingTime'] = this.currentMonthRemainingTime;
    data['bestTimeToCall'] = this.bestTimeToCall;
    data['preferredLanguage'] = this.preferredLanguage;
    data['emergencyContactName'] = this.emergencyContactName;
    data['emergencyContactRelationship'] = this.emergencyContactRelationship;
    data['emergencyContactPrimaryPhoneNo'] =
        this.emergencyContactPrimaryPhoneNo;
    data['emergencyContactSecondaryPhoneNo'] =
        this.emergencyContactSecondaryPhoneNo;
    data['emergencyPlan'] = this.emergencyPlan;
    data['maillingAddressState'] = this.maillingAddressState;
    data['maillingAddressCity'] = this.maillingAddressCity;
    data['maillingAddressZipCode'] = this.maillingAddressZipCode;
    data['billingProviderName'] = this.billingProviderName;
    if (this.careProviders != null) {
      data['careProviders'] =
          this.careProviders!.map((v) => v.toJson()).toList();
    }
    data['careFacilitatorName'] = this.careFacilitatorName;
    data['careFacilitatorNameAbbreviation'] =
        this.careFacilitatorNameAbbreviation;
    data['careFacilitatorId'] = this.careFacilitatorId;
    data['billingProviderId'] = this.billingProviderId;
    data['facilityId'] = this.facilityId;
    data['bhiCareManagerId'] = this.bhiCareManagerId;
    data['psychiatristId'] = this.psychiatristId;
    data['insurancePlanId'] = this.insurancePlanId;
    data['insurancePlanName'] = this.insurancePlanName;
    data['profileStatus'] = this.profileStatus;
    data['userId'] = this.userId;
    data['chronicDiseasesIds'] = this.chronicDiseasesIds;
    if (this.diagnosesList != null) {
      data['diagnosesList'] =
          this.diagnosesList!.map((v) => v.toJson()).toList();
    }
    if (this.medications != null) {
      data['medications'] = this.medications!.map((v) => v.toJson()).toList();
    }
    if (this.specialists != null) {
      data['specialists'] = this.specialists!.map((v) => v.toJson()).toList();
    }
    if (this.carePlanApproval != null) {
      data['carePlanApproval'] =
          this.carePlanApproval!.map((v) => v.toJson()).toList();
    }
    if (this.patientConsents != null) {
      data['patientConsents'] =
          this.patientConsents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}