class BGDataModel {
  int? id;
  double? bg;
  String? dinnerSituation;
  String? drugSituation;
  String? measurementDate;
  String? note;
  double? lat;
  double? lon;
  String? dataID;
  String? lastChangeTime;
  String? dataSource;
  String? userid;
  String? timeZone;
  String? status;
  String? trend;
  String? trendRate;
  String? bgUnit;
  int? patientId;
  String? patient;
  int? deviceVendorId;
  String? deviceVendor;
  bool? isOutOfRange;
  bool? isNotificationSent;

  BGDataModel(
      {this.id,
        this.bg,
        this.dinnerSituation,
        this.drugSituation,
        this.measurementDate,
        this.note,
        this.lat,
        this.lon,
        this.dataID,
        this.lastChangeTime,
        this.dataSource,
        this.userid,
        this.timeZone,
        this.status,
        this.trend,
        this.trendRate,
        this.bgUnit,
        this.patientId,
        this.patient,
        this.deviceVendorId,
        this.deviceVendor,
        this.isOutOfRange,
        this.isNotificationSent});

  BGDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bg = json['bg'];
    dinnerSituation = json['dinnerSituation'];
    drugSituation = json['drugSituation'];
    measurementDate = json['measurementDate'];
    note = json['note'];
    lat = json['lat'];
    lon = json['lon'];
    dataID = json['dataID'];
    lastChangeTime = json['lastChangeTime'];
    dataSource = json['dataSource'];
    userid = json['userid'];
    timeZone = json['timeZone'];
    status = json['status'];
    trend = json['trend'];
    trendRate = json['trendRate'];
    bgUnit = json['bgUnit'];
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
    data['bg'] = this.bg;
    data['dinnerSituation'] = this.dinnerSituation;
    data['drugSituation'] = this.drugSituation;
    data['measurementDate'] = this.measurementDate;
    data['note'] = this.note;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['dataID'] = this.dataID;
    data['lastChangeTime'] = this.lastChangeTime;
    data['dataSource'] = this.dataSource;
    data['userid'] = this.userid;
    data['timeZone'] = this.timeZone;
    data['status'] = this.status;
    data['trend'] = this.trend;
    data['trendRate'] = this.trendRate;
    data['bgUnit'] = this.bgUnit;
    data['patientId'] = this.patientId;
    data['patient'] = this.patient;
    data['deviceVendorId'] = this.deviceVendorId;
    data['deviceVendor'] = this.deviceVendor;
    data['isOutOfRange'] = this.isOutOfRange;
    data['isNotificationSent'] = this.isNotificationSent;
    return data;
  }
}