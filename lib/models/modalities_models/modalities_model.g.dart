// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modalities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModalitiesModel _$ModalitiesModelFromJson(Map<String, dynamic> json) =>
    ModalitiesModel(
      id: json['id'] as int?,
      manufacturer: json['manufacturer'] as String?,
      model: json['model'] as String?,
      macAddress: json['macAddress'] as String?,
      serialNo: json['serialNo'] as String?,
      installationDate: json['installationDate'] as String?,
      isIotDevice: json['isIotDevice'] as bool?,
      cpT99453: json['cpT99453'] as bool?,
      modality: json['modality'] as String?,
      modalityName: json['modalityName'] as String?,
      status: json['status'] as int?,
      inventoryStatus: json['inventoryStatus'] as int?,
      lastReading: json['lastReading'] as String?,
      lastReadingUnit: json['lastReadingUnit'] as String?,
      lastReadingContext: json['lastReadingContext'] as String?,
      lastReadingDate: json['lastReadingDate'] as String?,
      patientId: json['patientId'] as int?,
      facilityId: json['facilityId'] as int?,
      phDeviceModelId: json['phDeviceModelId'] as int?,
    );

Map<String, dynamic> _$ModalitiesModelToJson(ModalitiesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'macAddress': instance.macAddress,
      'serialNo': instance.serialNo,
      'installationDate': instance.installationDate,
      'isIotDevice': instance.isIotDevice,
      'cpT99453': instance.cpT99453,
      'modality': instance.modality,
      'modalityName': instance.modalityName,
      'status': instance.status,
      'inventoryStatus': instance.inventoryStatus,
      'lastReading': instance.lastReading,
      'lastReadingUnit': instance.lastReadingUnit,
      'lastReadingContext': instance.lastReadingContext,
      'lastReadingDate': instance.lastReadingDate,
      'patientId': instance.patientId,
      'facilityId': instance.facilityId,
      'phDeviceModelId': instance.phDeviceModelId,
    };
