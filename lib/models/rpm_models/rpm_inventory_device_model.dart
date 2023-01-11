class RpmInventoryDeviceModel {
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
  String? patientName;
  int? facilityId;
  int? phDeviceModelId;

  RpmInventoryDeviceModel(
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
        this.patientName,
        this.facilityId,
        this.phDeviceModelId});

  RpmInventoryDeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manufacturer = json['manufacturer'];
    model = json['model'];
    macAddress = json['macAddress'];
    serialNo = json['serialNo'];
    installationDate = json['installationDate'];
    isIotDevice = json['isIotDevice'];
    cpT99453 = json['cpT99453'];
    modality = json['modality'];
    modalityName = json['modalityName'];
    status = json['status'];
    inventoryStatus = json['inventoryStatus'];
    lastReading = json['lastReading'];
    lastReadingUnit = json['lastReadingUnit'];
    lastReadingContext = json['lastReadingContext'];
    lastReadingDate = json['lastReadingDate'];
    patientId = json['patientId'];
    patientName = json['patientName'];
    facilityId = json['facilityId'];
    phDeviceModelId = json['phDeviceModelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['manufacturer'] = this.manufacturer;
    data['model'] = this.model;
    data['macAddress'] = this.macAddress;
    data['serialNo'] = this.serialNo;
    data['installationDate'] = this.installationDate;
    data['isIotDevice'] = this.isIotDevice;
    data['cpT99453'] = this.cpT99453;
    data['modality'] = this.modality;
    data['modalityName'] = this.modalityName;
    data['status'] = this.status;
    data['inventoryStatus'] = this.inventoryStatus;
    data['lastReading'] = this.lastReading;
    data['lastReadingUnit'] = this.lastReadingUnit;
    data['lastReadingContext'] = this.lastReadingContext;
    data['lastReadingDate'] = this.lastReadingDate;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['facilityId'] = this.facilityId;
    data['phDeviceModelId'] = this.phDeviceModelId;
    return data;
  }
}