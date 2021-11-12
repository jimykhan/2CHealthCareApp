
import 'package:json_annotation/json_annotation.dart';
part 'modalities_model.g.dart';
@JsonSerializable()
class ModalitiesModel {
  int? id;
  String? manufacturer;
  String? model;
  String? macAddress;
  String? serialNo;
  String? installationDate;
  bool? isIotDevice;
  bool? cpT99453;
  String? modality;
  String? modalityName;
  int? status;
  int? inventoryStatus;
  String? lastReading;
  String? lastReadingUnit;
  String? lastReadingContext;
  String? lastReadingDate;
  int? patientId;
  int? facilityId;
  int? phDeviceModelId;
  String? patientName;

  ModalitiesModel(
      {this.id,
        this.manufacturer,
        this.model,
        this.macAddress,
        this.serialNo,
        this.installationDate,
        this.isIotDevice,
        this.cpT99453,
        this.modality,
        this.modalityName,
        this.status,
        this.inventoryStatus,
        this.lastReading,
        this.lastReadingUnit,
        this.lastReadingContext,
        this.lastReadingDate,
        this.patientId,
        this.facilityId,
        this.phDeviceModelId,
      this.patientName,
      });
  factory ModalitiesModel.fromJson(Map<String, dynamic> data) => _$ModalitiesModelFromJson(data);
  Map<String, dynamic> toJson() => _$ModalitiesModelToJson(this);
}