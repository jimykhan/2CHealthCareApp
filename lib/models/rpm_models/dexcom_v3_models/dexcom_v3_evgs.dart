class DexcomV3Evgs {
  String? recordType;
  String? recordVersion;
  String? userId;
  List<Records>? records;

  DexcomV3Evgs(
      {this.recordType, this.recordVersion, this.userId, this.records});

  DexcomV3Evgs.fromJson(Map<String, dynamic> json) {
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
  String? transmitterId;
  int? transmitterTicks;
  int? value;
  String? trend;
  double? trendRate;
  String? unit;
  String? rateUnit;
  String? displayDevice;
  String? transmitterGeneration;

  Records(
      {this.recordId,
        this.systemTime,
        this.displayTime,
        this.transmitterId,
        this.transmitterTicks,
        this.value,
        this.trend,
        this.trendRate,
        this.unit,
        this.rateUnit,
        this.displayDevice,
        this.transmitterGeneration});

  Records.fromJson(Map<String, dynamic> json) {
    recordId = json['recordId'];
    systemTime = json['systemTime'];
    displayTime = json['displayTime'];
    transmitterId = json['transmitterId'];
    transmitterTicks = json['transmitterTicks'];
    value = json['value'];
    trend = json['trend'];
    trendRate = json['trendRate'];
    unit = json['unit'];
    rateUnit = json['rateUnit'];
    displayDevice = json['displayDevice'];
    transmitterGeneration = json['transmitterGeneration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordId'] = this.recordId;
    data['systemTime'] = this.systemTime;
    data['displayTime'] = this.displayTime;
    data['transmitterId'] = this.transmitterId;
    data['transmitterTicks'] = this.transmitterTicks;
    data['value'] = this.value;
    data['trend'] = this.trend;
    data['trendRate'] = this.trendRate;
    data['unit'] = this.unit;
    data['rateUnit'] = this.rateUnit;
    data['displayDevice'] = this.displayDevice;
    data['transmitterGeneration'] = this.transmitterGeneration;
    return data;
  }
}