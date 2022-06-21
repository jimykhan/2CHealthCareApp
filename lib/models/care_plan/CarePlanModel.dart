class CarePlanModel {
  bool? challengesWithTransportation;
  bool? challengesWithEnglish;
  String? challengesComments;
  bool? religionImpactsOnHealthCare;
  String? religionImpactOnHealthCareComments;
  bool? healthCareAdvancedDirectives;
  String? healthCareAdvancedDirectivesComments;
  bool? polst;
  String? polstComments;
  bool? powerOfAttorney;
  String? powerOfAttorneyComments;
  String? accomodation;
  String? iLearnBestBy;
  bool? dietIssues;
  String? dietIssuesComments;
  bool? concernedAboutManagingChronicCondition;
  bool? concernedAboutFinantialIssues;
  bool? concernedAboutAccessToHealthCare;
  bool? concernedAboutEnergyLevelFatigue;
  bool? concernedAboutEmotionalIssues;
  bool? concernedAboutFamilyIssues;
  bool? concernedAboutSpiritualSupport;
  bool? concernedAboutMemoryProblems;
  bool? concernedAboutEndOfLife;
  String? concernedAboutOther;
  bool? isApprovedByBillingProvider;
  String? iLearnBestByComment;
  bool? isG0506;
  int? patientId;
  String? status;
  CarePlanApproval? carePlanApproval;
  String? currentApprovalUpdatedOn;
  String? lastApprovedDate;
  String? updatedOn;
  String? updatedUser;
  int? id;
  String? physicianSuggestedDietPlan;
  bool? challengesWithVision;
  bool? challengesWithHearing;
  bool? challengesWithMobility;
  String? physicalNote;
  bool? dailyLivingBath;
  bool? dailyLivingWalk;
  bool? dailyLivingDress;
  bool? dailyLivingEat;
  bool? dailyLivingTransfer;
  bool? dailyLivingRestroom;
  bool? dailyLivingNone;
  String? dailyLivingActivitiesNote;
  bool? instrumentalDailyGrocery;
  bool? instrumentalDailyTelephone;
  bool? instrumentalDailyHouseWork;
  bool? instrumentalDailyFinances;
  bool? instrumentalDailyTransportation;
  bool? instrumentalDailyMeals;
  bool? instrumentalDailyMedication;
  bool? instrumentalDailyNone;
  String? instrumentalDailyActivitiesNote;
  int? littleInterest;
  int? feelingDown;
  String? psychosocialNote;
  String? helpWithTransportation;
  String? iLive;
  bool? internetAccess;
  bool? cellPhone;
  String? cellPhoneNumber;
  bool? textMessages;
  String? emergencyContactName;
  String? emergencyContactRelationship;
  String? emergencyContactPrimaryPhoneNo;
  String? emergencyContactSecondaryPhoneNo;
  String? careGiverContactName;
  String? careGiverContactRelationship;
  String? careGiverContactPrimaryPhoneNo;
  String? careGiverContactSecondaryPhoneNo;
  String? careGiverNote;
  String? esl;
  String? utilizingCommunity;
  bool? advancedDirectivesPlans;
  bool? discussWithPhysician;
  String? advanceDirectivesNote;
  int? satisfactionWithMedicalCare;
  String? satisfactionComment;
  String? wantToImproveOnComment;
  bool? isCCMConsentTaken;
  String? ccmStartedDate;
  String? billingProviderName;
  List<String>? careCoordinatorName;
  int? carePlanStatusColor;
  List<String>? dailyLiving;
  List<String>? instrumentalDaily;

  /// not in model
  List<String>? careCoordinatorNameAbbreviation;

  CarePlanModel(
      {this.challengesWithTransportation,
        this.challengesWithEnglish,
        this.challengesComments,
        this.religionImpactsOnHealthCare,
        this.religionImpactOnHealthCareComments,
        this.healthCareAdvancedDirectives,
        this.healthCareAdvancedDirectivesComments,
        this.polst,
        this.polstComments,
        this.powerOfAttorney,
        this.powerOfAttorneyComments,
        this.accomodation,
        this.iLearnBestBy,
        this.dietIssues,
        this.dietIssuesComments,
        this.concernedAboutManagingChronicCondition,
        this.concernedAboutFinantialIssues,
        this.concernedAboutAccessToHealthCare,
        this.concernedAboutEnergyLevelFatigue,
        this.concernedAboutEmotionalIssues,
        this.concernedAboutFamilyIssues,
        this.concernedAboutSpiritualSupport,
        this.concernedAboutMemoryProblems,
        this.concernedAboutEndOfLife,
        this.concernedAboutOther,
        this.isApprovedByBillingProvider,
        this.iLearnBestByComment,
        this.isG0506,
        this.patientId,
        this.status,
        this.carePlanApproval,
        this.currentApprovalUpdatedOn,
        this.lastApprovedDate,
        this.updatedOn,
        this.updatedUser,
        this.id,
        this.physicianSuggestedDietPlan,
        this.challengesWithVision,
        this.challengesWithHearing,
        this.challengesWithMobility,
        this.physicalNote,
        this.dailyLivingBath,
        this.dailyLivingWalk,
        this.dailyLivingDress,
        this.dailyLivingEat,
        this.dailyLivingTransfer,
        this.dailyLivingRestroom,
        this.dailyLivingNone,
        this.dailyLivingActivitiesNote,
        this.instrumentalDailyGrocery,
        this.instrumentalDailyTelephone,
        this.instrumentalDailyHouseWork,
        this.instrumentalDailyFinances,
        this.instrumentalDailyTransportation,
        this.instrumentalDailyMeals,
        this.instrumentalDailyMedication,
        this.instrumentalDailyNone,
        this.instrumentalDailyActivitiesNote,
        this.littleInterest,
        this.feelingDown,
        this.psychosocialNote,
        this.helpWithTransportation,
        this.iLive,
        this.internetAccess,
        this.cellPhone,
        this.cellPhoneNumber,
        this.textMessages,
        this.emergencyContactName,
        this.emergencyContactRelationship,
        this.emergencyContactPrimaryPhoneNo,
        this.emergencyContactSecondaryPhoneNo,
        this.careGiverContactName,
        this.careGiverContactRelationship,
        this.careGiverContactPrimaryPhoneNo,
        this.careGiverContactSecondaryPhoneNo,
        this.careGiverNote,
        this.esl,
        this.utilizingCommunity,
        this.advancedDirectivesPlans,
        this.discussWithPhysician,
        this.advanceDirectivesNote,
        this.satisfactionWithMedicalCare,
        this.satisfactionComment,
        this.wantToImproveOnComment,
        this.isCCMConsentTaken,
        this.ccmStartedDate,
        this.billingProviderName,
        this.careCoordinatorName,
        this.carePlanStatusColor,
        this.dailyLiving,
        this.instrumentalDaily,
        this.careCoordinatorNameAbbreviation
      });

  CarePlanModel.fromJson(Map<String, dynamic> json) {
    challengesWithTransportation = json['challengesWithTransportation'];
    challengesWithEnglish = json['challengesWithEnglish'];
    challengesComments = json['challengesComments'];
    religionImpactsOnHealthCare = json['religionImpactsOnHealthCare'];
    religionImpactOnHealthCareComments =
    json['religionImpactOnHealthCareComments'];
    healthCareAdvancedDirectives = json['healthCareAdvancedDirectives'];
    healthCareAdvancedDirectivesComments =
    json['healthCareAdvancedDirectivesComments'];
    polst = json['polst'];
    polstComments = json['polstComments'];
    powerOfAttorney = json['powerOfAttorney'];
    powerOfAttorneyComments = json['powerOfAttorneyComments'];
    accomodation = json['accomodation'];
    iLearnBestBy = json['iLearnBestBy'];
    dietIssues = json['dietIssues'];
    dietIssuesComments = json['dietIssuesComments'];
    concernedAboutManagingChronicCondition =
    json['concernedAboutManagingChronicCondition'];
    concernedAboutFinantialIssues = json['concernedAboutFinantialIssues'];
    concernedAboutAccessToHealthCare = json['concernedAboutAccessToHealthCare'];
    concernedAboutEnergyLevelFatigue = json['concernedAboutEnergyLevelFatigue'];
    concernedAboutEmotionalIssues = json['concernedAboutEmotionalIssues'];
    concernedAboutFamilyIssues = json['concernedAboutFamilyIssues'];
    concernedAboutSpiritualSupport = json['concernedAboutSpiritualSupport'];
    concernedAboutMemoryProblems = json['concernedAboutMemoryProblems'];
    concernedAboutEndOfLife = json['concernedAboutEndOfLife'];
    concernedAboutOther = json['concernedAboutOther'];
    isApprovedByBillingProvider = json['isApprovedByBillingProvider'];
    iLearnBestByComment = json['iLearnBestByComment'];
    isG0506 = json['isG0506'];
    patientId = json['patientId'];
    status = json['status'];
    carePlanApproval = json['carePlanApproval'] != null
        ? new CarePlanApproval.fromJson(json['carePlanApproval'])
        : null;
    currentApprovalUpdatedOn = json['currentApprovalUpdatedOn'];
    lastApprovedDate = json['lastApprovedDate'];
    updatedOn = json['updatedOn'];
    updatedUser = json['updatedUser'];
    id = json['id'];
    physicianSuggestedDietPlan = json['physicianSuggestedDietPlan'];
    challengesWithVision = json['challengesWithVision'];
    challengesWithHearing = json['challengesWithHearing'];
    challengesWithMobility = json['challengesWithMobility'];
    physicalNote = json['physicalNote'];
    dailyLivingBath = json['dailyLivingBath'];
    dailyLivingWalk = json['dailyLivingWalk'];
    dailyLivingDress = json['dailyLivingDress'];
    dailyLivingEat = json['dailyLivingEat'];
    dailyLivingTransfer = json['dailyLivingTransfer'];
    dailyLivingRestroom = json['dailyLivingRestroom'];
    dailyLivingNone = json['dailyLivingNone'];
    dailyLivingActivitiesNote = json['dailyLivingActivitiesNote'];
    instrumentalDailyGrocery = json['instrumentalDailyGrocery'];
    instrumentalDailyTelephone = json['instrumentalDailyTelephone'];
    instrumentalDailyHouseWork = json['instrumentalDailyHouseWork'];
    instrumentalDailyFinances = json['instrumentalDailyFinances'];
    instrumentalDailyTransportation = json['instrumentalDailyTransportation'];
    instrumentalDailyMeals = json['instrumentalDailyMeals'];
    instrumentalDailyMedication = json['instrumentalDailyMedication'];
    instrumentalDailyNone = json['instrumentalDailyNone'];
    instrumentalDailyActivitiesNote = json['instrumentalDailyActivitiesNote'];
    littleInterest = json['littleInterest'];
    feelingDown = json['feelingDown'];
    psychosocialNote = json['psychosocialNote'];
    helpWithTransportation = json['helpWithTransportation'];
    iLive = json['iLive'];
    internetAccess = json['internetAccess'];
    cellPhone = json['cellPhone'];
    cellPhoneNumber = json['cellPhoneNumber'];
    textMessages = json['textMessages'];
    emergencyContactName = json['emergencyContactName'];
    emergencyContactRelationship = json['emergencyContactRelationship'];
    emergencyContactPrimaryPhoneNo = json['emergencyContactPrimaryPhoneNo'];
    emergencyContactSecondaryPhoneNo = json['emergencyContactSecondaryPhoneNo'];
    careGiverContactName = json['careGiverContactName'];
    careGiverContactRelationship = json['careGiverContactRelationship'];
    careGiverContactPrimaryPhoneNo = json['careGiverContactPrimaryPhoneNo'];
    careGiverContactSecondaryPhoneNo = json['careGiverContactSecondaryPhoneNo'];
    careGiverNote = json['careGiverNote'];
    esl = json['esl'];
    utilizingCommunity = json['utilizingCommunity'];
    advancedDirectivesPlans = json['advancedDirectivesPlans'];
    discussWithPhysician = json['discussWithPhysician'];
    advanceDirectivesNote = json['advanceDirectivesNote'];
    satisfactionWithMedicalCare = json['satisfactionWithMedicalCare'];
    satisfactionComment = json['satisfactionComment'];
    wantToImproveOnComment = json['wantToImproveOnComment'];
    isCCMConsentTaken = json['isCCMConsentTaken'];
    ccmStartedDate = json['ccmStartedDate'];
    billingProviderName = json['billingProviderName'];
    careCoordinatorName = json['careCoordinatorName'] != null ? json['careCoordinatorName'].cast<String>() : [];
    carePlanStatusColor = json['carePlanStatusColor'];
    dailyLiving = json['dailyLiving'] != null ? json['dailyLiving'].cast<String>() : [];
    instrumentalDaily = json['instrumentalDaily'] != null ? json['instrumentalDaily'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['challengesWithTransportation'] = this.challengesWithTransportation;
    data['challengesWithEnglish'] = this.challengesWithEnglish;
    data['challengesComments'] = this.challengesComments;
    data['religionImpactsOnHealthCare'] = this.religionImpactsOnHealthCare;
    data['religionImpactOnHealthCareComments'] =
        this.religionImpactOnHealthCareComments;
    data['healthCareAdvancedDirectives'] = this.healthCareAdvancedDirectives;
    data['healthCareAdvancedDirectivesComments'] =
        this.healthCareAdvancedDirectivesComments;
    data['polst'] = this.polst;
    data['polstComments'] = this.polstComments;
    data['powerOfAttorney'] = this.powerOfAttorney;
    data['powerOfAttorneyComments'] = this.powerOfAttorneyComments;
    data['accomodation'] = this.accomodation;
    data['iLearnBestBy'] = this.iLearnBestBy;
    data['dietIssues'] = this.dietIssues;
    data['dietIssuesComments'] = this.dietIssuesComments;
    data['concernedAboutManagingChronicCondition'] =
        this.concernedAboutManagingChronicCondition;
    data['concernedAboutFinantialIssues'] = this.concernedAboutFinantialIssues;
    data['concernedAboutAccessToHealthCare'] =
        this.concernedAboutAccessToHealthCare;
    data['concernedAboutEnergyLevelFatigue'] =
        this.concernedAboutEnergyLevelFatigue;
    data['concernedAboutEmotionalIssues'] = this.concernedAboutEmotionalIssues;
    data['concernedAboutFamilyIssues'] = this.concernedAboutFamilyIssues;
    data['concernedAboutSpiritualSupport'] =
        this.concernedAboutSpiritualSupport;
    data['concernedAboutMemoryProblems'] = this.concernedAboutMemoryProblems;
    data['concernedAboutEndOfLife'] = this.concernedAboutEndOfLife;
    data['concernedAboutOther'] = this.concernedAboutOther;
    data['isApprovedByBillingProvider'] = this.isApprovedByBillingProvider;
    data['iLearnBestByComment'] = this.iLearnBestByComment;
    data['isG0506'] = this.isG0506;
    data['patientId'] = this.patientId;
    data['status'] = this.status;
    if (this.carePlanApproval != null) {
      data['carePlanApproval'] = this.carePlanApproval!.toJson();
    }
    data['currentApprovalUpdatedOn'] = this.currentApprovalUpdatedOn;
    data['lastApprovedDate'] = this.lastApprovedDate;
    data['updatedOn'] = this.updatedOn;
    data['updatedUser'] = this.updatedUser;
    data['id'] = this.id;
    data['physicianSuggestedDietPlan'] = this.physicianSuggestedDietPlan;
    data['challengesWithVision'] = this.challengesWithVision;
    data['challengesWithHearing'] = this.challengesWithHearing;
    data['challengesWithMobility'] = this.challengesWithMobility;
    data['physicalNote'] = this.physicalNote;
    data['dailyLivingBath'] = this.dailyLivingBath;
    data['dailyLivingWalk'] = this.dailyLivingWalk;
    data['dailyLivingDress'] = this.dailyLivingDress;
    data['dailyLivingEat'] = this.dailyLivingEat;
    data['dailyLivingTransfer'] = this.dailyLivingTransfer;
    data['dailyLivingRestroom'] = this.dailyLivingRestroom;
    data['dailyLivingNone'] = this.dailyLivingNone;
    data['dailyLivingActivitiesNote'] = this.dailyLivingActivitiesNote;
    data['instrumentalDailyGrocery'] = this.instrumentalDailyGrocery;
    data['instrumentalDailyTelephone'] = this.instrumentalDailyTelephone;
    data['instrumentalDailyHouseWork'] = this.instrumentalDailyHouseWork;
    data['instrumentalDailyFinances'] = this.instrumentalDailyFinances;
    data['instrumentalDailyTransportation'] =
        this.instrumentalDailyTransportation;
    data['instrumentalDailyMeals'] = this.instrumentalDailyMeals;
    data['instrumentalDailyMedication'] = this.instrumentalDailyMedication;
    data['instrumentalDailyNone'] = this.instrumentalDailyNone;
    data['instrumentalDailyActivitiesNote'] =
        this.instrumentalDailyActivitiesNote;
    data['littleInterest'] = this.littleInterest;
    data['feelingDown'] = this.feelingDown;
    data['psychosocialNote'] = this.psychosocialNote;
    data['helpWithTransportation'] = this.helpWithTransportation;
    data['iLive'] = this.iLive;
    data['internetAccess'] = this.internetAccess;
    data['cellPhone'] = this.cellPhone;
    data['cellPhoneNumber'] = this.cellPhoneNumber;
    data['textMessages'] = this.textMessages;
    data['emergencyContactName'] = this.emergencyContactName;
    data['emergencyContactRelationship'] = this.emergencyContactRelationship;
    data['emergencyContactPrimaryPhoneNo'] =
        this.emergencyContactPrimaryPhoneNo;
    data['emergencyContactSecondaryPhoneNo'] =
        this.emergencyContactSecondaryPhoneNo;
    data['careGiverContactName'] = this.careGiverContactName;
    data['careGiverContactRelationship'] = this.careGiverContactRelationship;
    data['careGiverContactPrimaryPhoneNo'] =
        this.careGiverContactPrimaryPhoneNo;
    data['careGiverContactSecondaryPhoneNo'] =
        this.careGiverContactSecondaryPhoneNo;
    data['careGiverNote'] = this.careGiverNote;
    data['esl'] = this.esl;
    data['utilizingCommunity'] = this.utilizingCommunity;
    data['advancedDirectivesPlans'] = this.advancedDirectivesPlans;
    data['discussWithPhysician'] = this.discussWithPhysician;
    data['advanceDirectivesNote'] = this.advanceDirectivesNote;
    data['satisfactionWithMedicalCare'] = this.satisfactionWithMedicalCare;
    data['satisfactionComment'] = this.satisfactionComment;
    data['wantToImproveOnComment'] = this.wantToImproveOnComment;
    data['isCCMConsentTaken'] = this.isCCMConsentTaken;
    data['ccmStartedDate'] = this.ccmStartedDate;
    data['billingProviderName'] = this.billingProviderName;
    data['careCoordinatorName'] = this.careCoordinatorName;
    data['carePlanStatusColor'] = this.carePlanStatusColor;
    data['dailyLiving'] = this.dailyLiving;
    data['instrumentalDaily'] = this.instrumentalDaily;
    return data;
  }
}

class CarePlanApproval {
  int? id;
  String? status;
  String? approvedDate;
  String? comments;
  String? billingAppUserId;

  CarePlanApproval(
      {this.id,
        this.status,
        this.approvedDate,
        this.comments,
        this.billingAppUserId});

  CarePlanApproval.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    approvedDate = json['approvedDate'];
    comments = json['comments'];
    billingAppUserId = json['billingAppUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['approvedDate'] = this.approvedDate;
    data['comments'] = this.comments;
    data['billingAppUserId'] = this.billingAppUserId;
    return data;
  }
}