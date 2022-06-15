class RpmLogModel {
  int? id;
  String? startTime;
  String? endTime;
  String? duration;
  String? encounterDate;
  String? note;
  int? patientId;
  String? patientName;
  int? facilityUserId;
  String? facilityUserName;
  int? billingProviderId;
  String? billingProviderName;
  bool? isProviderRpm;
  int? rpmServiceType;
  String? rpmServiceTypeString;

  int durationInMints = 0;
  DateTime? dateTime;

  RpmLogModel(
      {this.id,
        this.startTime,
        this.endTime,
        this.duration,
        this.encounterDate,
        this.note,
        this.patientId,
        this.patientName,
        this.facilityUserId,
        this.facilityUserName,
        this.billingProviderId,
        this.billingProviderName,
        this.isProviderRpm,
        this.rpmServiceType,
        this.durationInMints = 0,
        this.rpmServiceTypeString,
        this.dateTime
      });

  RpmLogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    duration = json['duration'];
    encounterDate = json['encounterDate'];
    note = json['note'];
    patientId = json['patientId'];
    patientName = json['patientName'];
    facilityUserId = json['facilityUserId'];
    facilityUserName = json['facilityUserName'];
    billingProviderId = json['billingProviderId'];
    billingProviderName = json['billingProviderName'];
    isProviderRpm = json['isProviderRpm'];
    rpmServiceType = json['rpmServiceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['duration'] = this.duration;
    data['encounterDate'] = this.encounterDate;
    data['note'] = this.note;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['facilityUserId'] = this.facilityUserId;
    data['facilityUserName'] = this.facilityUserName;
    data['billingProviderId'] = this.billingProviderId;
    data['billingProviderName'] = this.billingProviderName;
    data['isProviderRpm'] = this.isProviderRpm;
    data['rpmServiceType'] = this.rpmServiceType;
    return data;
  }
}