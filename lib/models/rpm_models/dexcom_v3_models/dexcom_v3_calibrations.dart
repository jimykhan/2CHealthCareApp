class DexcomV3Calibrations {
  String? recordType;
  String? recordVersion;
  String? userId;
  List<Records>? records;

  DexcomV3Calibrations(
      {this.recordType, this.recordVersion, this.userId, this.records});

  DexcomV3Calibrations.fromJson(Map<String, dynamic> json) {
    recordType = json['recordType'];
    recordVersion = json['recordVersion'];
    userId = json['userId'];
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordType'] = this.recordType;
    data['recordVersion'] = this.recordVersion;
    data['userId'] = this.userId;
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  String? recordId;
  String? systemTime;
  String? displayTime;
  String? unit;
  int? value;
  String? displayDevice;
  String? transmitterId;
  int? transmitterTicks;
  String? transmitterGeneration;

  Records(
      {this.recordId,
      this.systemTime,
      this.displayTime,
      this.unit,
      this.value,
      this.displayDevice,
      this.transmitterId,
      this.transmitterTicks,
      this.transmitterGeneration});

  Records.fromJson(Map<String, dynamic> json) {
    recordId = json['recordId'];
    systemTime = json['systemTime'];
    displayTime = json['displayTime'];
    unit = json['unit'];
    value = json['value'];
    displayDevice = json['displayDevice'];
    transmitterId = json['transmitterId'];
    transmitterTicks = json['transmitterTicks'];
    transmitterGeneration = json['transmitterGeneration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordId'] = this.recordId;
    data['systemTime'] = this.systemTime;
    data['displayTime'] = this.displayTime;
    data['unit'] = this.unit;
    data['value'] = this.value;
    data['displayDevice'] = this.displayDevice;
    data['transmitterId'] = this.transmitterId;
    data['transmitterTicks'] = this.transmitterTicks;
    data['transmitterGeneration'] = this.transmitterGeneration;
    return data;
  }
}