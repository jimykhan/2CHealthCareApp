class PulseOxReadingModel {
  int? id;
  double? bloodOxygen;
  double? heartRate;
  String? measurementDate;
  Null? note;
  double? lon;
  double? lat;
  String? dataID;
  String? lastChangeTime;
  String? dataSource;
  String? userid;
  String? timeZone;
  String? boUnit;
  int? patientId;
  String? patient;
  int? deviceVendorId;
  String? deviceVendor;
  bool? isOutOfRange;
  bool? isNotificationSent;

  PulseOxReadingModel(
      {this.id,
        this.bloodOxygen,
        this.heartRate,
        this.measurementDate,
        this.note,
        this.lon,
        this.lat,
        this.dataID,
        this.lastChangeTime,
        this.dataSource,
        this.userid,
        this.timeZone,
        this.boUnit,
        this.patientId,
        this.patient,
        this.deviceVendorId,
        this.deviceVendor,
        this.isOutOfRange,
        this.isNotificationSent});

  PulseOxReadingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bloodOxygen = json['bloodOxygen'];
    heartRate = json['heartRate'];
    measurementDate = json['measurementDate'];
    note = json['note'];
    lon = json['lon'];
    lat = json['lat'];
    dataID = json['dataID'];
    lastChangeTime = json['lastChangeTime'];
    dataSource = json['dataSource'];
    userid = json['userid'];
    timeZone = json['timeZone'];
    boUnit = json['boUnit'];
    patientId = json['patientId'];
    patient = json['patient'];
    deviceVendorId = json['deviceVendorId'];
    deviceVendor = json['deviceVendor'];
    isOutOfRange = json['isOutOfRange'];
    isNotificationSent = json['isNotificationSent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bloodOxygen'] = this.bloodOxygen;
    data['heartRate'] = this.heartRate;
    data['measurementDate'] = this.measurementDate;
    data['note'] = this.note;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['dataID'] = this.dataID;
    data['lastChangeTime'] = this.lastChangeTime;
    data['dataSource'] = this.dataSource;
    data['userid'] = this.userid;
    data['timeZone'] = this.timeZone;
    data['boUnit'] = this.boUnit;
    data['patientId'] = this.patientId;
    data['patient'] = this.patient;
    data['deviceVendorId'] = this.deviceVendorId;
    data['deviceVendor'] = this.deviceVendor;
    data['isOutOfRange'] = this.isOutOfRange;
    data['isNotificationSent'] = this.isNotificationSent;
    return data;
  }
}