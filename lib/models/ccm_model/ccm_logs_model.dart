class CcmLogs {
  String? ccmTimeCompleted;
  String? consentDate;
  String? followUpDate;
  List<CcmEncountersList>? ccmEncountersList;

  CcmLogs(
      {this.ccmTimeCompleted,
        this.consentDate,
        this.followUpDate,
        this.ccmEncountersList});

  CcmLogs.fromJson(Map<String, dynamic> json) {
    ccmTimeCompleted = json['ccmTimeCompleted'];
    consentDate = json['consentDate'];
    followUpDate = json['followUpDate'];
    if (json['ccmEncountersList'] != null) {
      ccmEncountersList = <CcmEncountersList>[];
      json['ccmEncountersList'].forEach((v) {
        ccmEncountersList!.add(new CcmEncountersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ccmTimeCompleted'] = this.ccmTimeCompleted;
    data['consentDate'] = this.consentDate;
    data['followUpDate'] = this.followUpDate;
    if (this.ccmEncountersList != null) {
      data['ccmEncountersList'] =
          this.ccmEncountersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CcmEncountersList {
  int? id;
  String? startTime;
  String? endTime;
  String? duration;
  String? encounterDate;
  String? note;
  int? ccmServiceTypeId;
  String? ccmServiceType;
  bool? claimGenerated;
  int? careProviderId;
  String? careProviderName;
  int? patientId;

  int durationInMints = 0;
  DateTime? dateTime;
  int startTimeHour = 0;
  int startTimeMints = 0;


  CcmEncountersList(
      {this.id,
        this.startTime,
        this.endTime,
        this.duration,
        this.encounterDate,
        this.note,
        this.ccmServiceTypeId,
        this.ccmServiceType,
        this.claimGenerated,
        this.careProviderId,
        this.careProviderName,
        this.patientId,
        this.durationInMints = 0,
        this.dateTime,
        this.startTimeHour = 0,
        this.startTimeMints = 0,
      });

  CcmEncountersList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    duration = json['duration'];
    encounterDate = json['encounterDate'];
    note = json['note'];
    ccmServiceTypeId = json['ccmServiceTypeId'];
    ccmServiceType = json['ccmServiceType'];
    claimGenerated = json['claimGenerated'];
    careProviderId = json['careProviderId'];
    careProviderName = json['careProviderName'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['duration'] = this.duration;
    data['encounterDate'] = this.encounterDate;
    data['note'] = this.note;
    data['ccmServiceTypeId'] = this.ccmServiceTypeId;
    data['ccmServiceType'] = this.ccmServiceType;
    data['claimGenerated'] = this.claimGenerated;
    data['careProviderId'] = this.careProviderId;
    data['careProviderName'] = this.careProviderName;
    data['patientId'] = this.patientId;
    return data;
  }
}