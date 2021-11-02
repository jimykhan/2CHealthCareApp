import 'package:json_annotation/json_annotation.dart';
part 'blood_pressure_reading_model.g.dart';
@JsonSerializable()
class BloodPressureReadingModel {
  int? id;
  int? bpl;
  double? highPressure;
  int? heartRate;
  int? isArr;
  double? lowPressure;
  double? lat;
  double? lon;
  String? dataID;
  String? measurementDate;
  String? note;
  String? lastChangeTime;
  String? dataSource;
  String? userid;
  String? timeZone;
  String? bpUnit;
  int? patientId;
  String? patient;
  int? deviceVendorId;
  String? deviceVendor;
  bool? isOutOfRange;
  bool? isNotificationSent;

  BloodPressureReadingModel(
      {this.id,
        this.bpl,
        this.highPressure,
        this.heartRate,
        this.isArr,
        this.lowPressure,
        this.lat,
        this.lon,
        this.dataID,
        this.measurementDate,
        this.note,
        this.lastChangeTime,
        this.dataSource,
        this.userid,
        this.timeZone,
        this.bpUnit,
        this.patientId,
        this.patient,
        this.deviceVendorId,
        this.deviceVendor,
        this.isOutOfRange,
        this.isNotificationSent});
  factory BloodPressureReadingModel.fromJson(Map<String, dynamic> data) => _$BloodPressureReadingModelFromJson(data);
  Map<String, dynamic> toJson() => _$BloodPressureReadingModelToJson(this);
}
