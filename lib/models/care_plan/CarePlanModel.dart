class CarePlanModel {
  int? id;
  String? dateUpdated;
  bool? challengesWithTransportation;
  bool? challengesWithVision;
  bool? challengesWithHearing;
  bool? challengesWithMobility;
  String? challengesWithEnglish;
  String? challengesComments;
  bool? religionImpactsOnHealthCare;
  String? religionImpactOnHealthCareComments;
  bool? healthCareAdvancedDirectives;
  String? healthCareAdvancedDirectivesComments;
  bool? polst;
  String? polstComments;
  bool? powerOfAttorney;
  String? powerOfAttorneyComments;
  Null? accomodation;
  String? iLearnBestBy;
  bool? internetAccess;
  bool? dietIssues;
  String? dietIssuesComments;
  bool? concernedAboutManagingChronicCondition;
  String? concernedAboutFinantialIssues;
  String? concernedAboutAccessToHealthCare;
  String? concernedAboutEnergyLevelFatigue;
  bool? concernedAboutEmotionalIssues;
  bool? concernedAboutFamilyIssues;
  bool? concernedAboutSpiritualSupport;
  String? concernedAboutMemoryProblems;
  String? concernedAboutEndOfLife;
  String? concernedAboutOther;
  bool? isApprovedByBillingProvider;
  int? satisfactionWithMedicalCare;
  String? satisfactionComment;
  String? wantToImproveOnComment;
  String? iLive;
  String? iLearnBestByComment;
  bool? isG0506;
  int? patientId;
  String? status;
  CarePlanApproval? carePlanApproval;
  String? currentApprovalUpdatedOn;
  String? lastApprovedDate;

  CarePlanModel(
      {this.id,
        this.dateUpdated,
        this.challengesWithTransportation,
        this.challengesWithVision,
        this.challengesWithHearing,
        this.challengesWithMobility,
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
        this.internetAccess,
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
        this.satisfactionWithMedicalCare,
        this.satisfactionComment,
        this.wantToImproveOnComment,
        this.iLive,
        this.iLearnBestByComment,
        this.isG0506,
        this.patientId,
        this.status,
        this.carePlanApproval,
        this.currentApprovalUpdatedOn,
        this.lastApprovedDate});

  CarePlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateUpdated = json['dateUpdated'];
    challengesWithTransportation = json['challengesWithTransportation'];
    challengesWithVision = json['challengesWithVision'];
    challengesWithHearing = json['challengesWithHearing'];
    challengesWithMobility = json['challengesWithMobility'];
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
    internetAccess = json['internetAccess'];
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
    satisfactionWithMedicalCare = json['satisfactionWithMedicalCare'];
    satisfactionComment = json['satisfactionComment'];
    wantToImproveOnComment = json['wantToImproveOnComment'];
    iLive = json['iLive'];
    iLearnBestByComment = json['iLearnBestByComment'];
    isG0506 = json['isG0506'];
    patientId = json['patientId'];
    status = json['status'];
    carePlanApproval = json['carePlanApproval'] != null
        ? new CarePlanApproval.fromJson(json['carePlanApproval'])
        : null;
    currentApprovalUpdatedOn = json['currentApprovalUpdatedOn'];
    lastApprovedDate = json['lastApprovedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateUpdated'] = this.dateUpdated;
    data['challengesWithTransportation'] = this.challengesWithTransportation;
    data['challengesWithVision'] = this.challengesWithVision;
    data['challengesWithHearing'] = this.challengesWithHearing;
    data['challengesWithMobility'] = this.challengesWithMobility;
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
    data['internetAccess'] = this.internetAccess;
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
    data['satisfactionWithMedicalCare'] = this.satisfactionWithMedicalCare;
    data['satisfactionComment'] = this.satisfactionComment;
    data['wantToImproveOnComment'] = this.wantToImproveOnComment;
    data['iLive'] = this.iLive;
    data['iLearnBestByComment'] = this.iLearnBestByComment;
    data['isG0506'] = this.isG0506;
    data['patientId'] = this.patientId;
    data['status'] = this.status;
    if (this.carePlanApproval != null) {
      data['carePlanApproval'] = this.carePlanApproval!.toJson();
    }
    data['currentApprovalUpdatedOn'] = this.currentApprovalUpdatedOn;
    data['lastApprovedDate'] = this.lastApprovedDate;
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