class WeightReadingModel {
  int? id;
  double? bmi;
  double? boneValue;
  double? dci;
  double? fatValue;
  double? muscaleValue;
  double? waterValue;
  double? weightValue;
  String? dataID;
  String? measurementDate;
  String? note;
  String? lastChangeTime;
  String? dataSource;
  String? userid;
  String? timeZone;
  String? weightUnit;
  int? patientId;
  String? patient;
  int? deviceVendorId;
  String? deviceVendor;
  bool? isOutOfRange;
  bool? isNotificationSent;

  WeightReadingModel(
      {this.id,
        this.bmi,
        this.boneValue,
        this.dci,
        this.fatValue,
        this.muscaleValue,
        this.waterValue,
        this.weightValue,
        this.dataID,
        this.measurementDate,
        this.note,
        this.lastChangeTime,
        this.dataSource,
        this.userid,
        this.timeZone,
        this.weightUnit,
        this.patientId,
        this.patient,
        this.deviceVendorId,
        this.deviceVendor,
        this.isOutOfRange,
        this.isNotificationSent});

  WeightReadingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bmi = json['bmi'];
    boneValue = json['boneValue'];
    dci = json['dci'];
    fatValue = json['fatValue'];
    muscaleValue = json['muscaleValue'];
    waterValue = json['waterValue'];
    weightValue = json['weightValue'];
    dataID = json['dataID'];
    measurementDate = json['measurementDate'];
    note = json['note'];
    lastChangeTime = json['lastChangeTime'];
    dataSource = json['dataSource'];
    userid = json['userid'];
    timeZone = json['timeZone'];
    weightUnit = json['weightUnit'];
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
    data['bmi'] = this.bmi;
    data['boneValue'] = this.boneValue;
    data['dci'] = this.dci;
    data['fatValue'] = this.fatValue;
    data['muscaleValue'] = this.muscaleValue;
    data['waterValue'] = this.waterValue;
    data['weightValue'] = this.weightValue;
    data['dataID'] = this.dataID;
    data['measurementDate'] = this.measurementDate;
    data['note'] = this.note;
    data['lastChangeTime'] = this.lastChangeTime;
    data['dataSource'] = this.dataSource;
    data['userid'] = this.userid;
    data['timeZone'] = this.timeZone;
    data['weightUnit'] = this.weightUnit;
    data['patientId'] = this.patientId;
    data['patient'] = this.patient;
    data['deviceVendorId'] = this.deviceVendorId;
    data['deviceVendor'] = this.deviceVendor;
    data['isOutOfRange'] = this.isOutOfRange;
    data['isNotificationSent'] = this.isNotificationSent;
    return data;
  }
}