// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_reading_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodPressureReadingModel _$BloodPressureReadingModelFromJson(
        Map<String, dynamic> json) =>
    BloodPressureReadingModel(
      id: json['id'] as int?,
      bpl: json['bpl'] as int?,
      highPressure: (json['highPressure'] as num?)?.toDouble(),
      heartRate: json['heartRate'] as int?,
      isArr: json['isArr'] as int?,
      lowPressure: (json['lowPressure'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      dataID: json['dataID'] as String?,
      measurementDate: json['measurementDate'] as String?,
      note: json['note'] as String?,
      lastChangeTime: json['lastChangeTime'] as String?,
      dataSource: json['dataSource'] as String?,
      userid: json['userid'] as String?,
      timeZone: json['timeZone'] as String?,
      bpUnit: json['bpUnit'] as String?,
      patientId: json['patientId'] as int?,
      patient: json['patient'] as String?,
      deviceVendorId: json['deviceVendorId'] as int?,
      deviceVendor: json['deviceVendor'] as String?,
      isOutOfRange: json['isOutOfRange'] as bool?,
      isNotificationSent: json['isNotificationSent'] as bool?,
    );

Map<String, dynamic> _$BloodPressureReadingModelToJson(
        BloodPressureReadingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bpl': instance.bpl,
      'highPressure': instance.highPressure,
      'heartRate': instance.heartRate,
      'isArr': instance.isArr,
      'lowPressure': instance.lowPressure,
      'lat': instance.lat,
      'lon': instance.lon,
      'dataID': instance.dataID,
      'measurementDate': instance.measurementDate,
      'note': instance.note,
      'lastChangeTime': instance.lastChangeTime,
      'dataSource': instance.dataSource,
      'userid': instance.userid,
      'timeZone': instance.timeZone,
      'bpUnit': instance.bpUnit,
      'patientId': instance.patientId,
      'patient': instance.patient,
      'deviceVendorId': instance.deviceVendorId,
      'deviceVendor': instance.deviceVendor,
      'isOutOfRange': instance.isOutOfRange,
      'isNotificationSent': instance.isNotificationSent,
    };
