import 'package:twochealthcare/models/rpm_models/dex_com_models/GetStatisticsDataModel.dart';

class DexcomV3DevicesAndSatistic {
  DexcomV3Devices? dexcomV3Devices;
  GetStatisticsDataModel? statistic;
  DexcomV3DevicesAndSatistic({this.dexcomV3Devices, this.statistic});
}

class DexcomV3Devices {
  String? recordType;
  String? recordVersion;
  String? userId;
  List<Records>? records;

  DexcomV3Devices(
      {this.recordType, this.recordVersion, this.userId, this.records});

  DexcomV3Devices.fromJson(Map<String, dynamic> json) {
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
  String? transmitterGeneration;
  String? displayDevice;
  String? displayApp;
  String? lastUploadDate;
  List<AlertSchedules>? alertSchedules;
  String? transmitterId;
  String? softwareVersion;
  String? softwareNumber;
  String? language;
  bool? isMmolDisplayMode;
  bool? isBlindedMode;
  bool? is24HourMode;
  int? displayTimeOffset;
  int? systemTimeOffset;

  Records(
      {this.transmitterGeneration,
      this.displayDevice,
      this.displayApp,
      this.lastUploadDate,
      this.alertSchedules,
      this.transmitterId,
      this.softwareVersion,
      this.softwareNumber,
      this.language,
      this.isMmolDisplayMode,
      this.isBlindedMode,
      this.is24HourMode,
      this.displayTimeOffset,
      this.systemTimeOffset});

  Records.fromJson(Map<String, dynamic> json) {
    transmitterGeneration = json['transmitterGeneration'];
    displayDevice = json['displayDevice'];
    displayApp = json['displayApp'];
    lastUploadDate = json['lastUploadDate'];
    if (json['alertSchedules'] != null) {
      alertSchedules = <AlertSchedules>[];
      json['alertSchedules'].forEach((v) {
        alertSchedules!.add(new AlertSchedules.fromJson(v));
      });
    }
    transmitterId = json['transmitterId'];
    softwareVersion = json['softwareVersion'];
    softwareNumber = json['softwareNumber'];
    language = json['language'];
    isMmolDisplayMode = json['isMmolDisplayMode'];
    isBlindedMode = json['isBlindedMode'];
    is24HourMode = json['is24HourMode'];
    displayTimeOffset = json['displayTimeOffset'];
    systemTimeOffset = json['systemTimeOffset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transmitterGeneration'] = this.transmitterGeneration;
    data['displayDevice'] = this.displayDevice;
    data['displayApp'] = this.displayApp;
    data['lastUploadDate'] = this.lastUploadDate;
    if (this.alertSchedules != null) {
      data['alertSchedules'] =
          this.alertSchedules!.map((v) => v.toJson()).toList();
    }
    data['transmitterId'] = this.transmitterId;
    data['softwareVersion'] = this.softwareVersion;
    data['softwareNumber'] = this.softwareNumber;
    data['language'] = this.language;
    data['isMmolDisplayMode'] = this.isMmolDisplayMode;
    data['isBlindedMode'] = this.isBlindedMode;
    data['is24HourMode'] = this.is24HourMode;
    data['displayTimeOffset'] = this.displayTimeOffset;
    data['systemTimeOffset'] = this.systemTimeOffset;
    return data;
  }
}

class AlertSchedules {
  AlertScheduleSettings? alertScheduleSettings;
  List<AlertSettings>? alertSettings;

  AlertSchedules({this.alertScheduleSettings, this.alertSettings});

  AlertSchedules.fromJson(Map<String, dynamic> json) {
    alertScheduleSettings = json['alertScheduleSettings'] != null
        ? new AlertScheduleSettings.fromJson(json['alertScheduleSettings'])
        : null;
    if (json['alertSettings'] != null) {
      alertSettings = <AlertSettings>[];
      json['alertSettings'].forEach((v) {
        alertSettings!.add(new AlertSettings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alertScheduleSettings != null) {
      data['alertScheduleSettings'] = this.alertScheduleSettings!.toJson();
    }
    if (this.alertSettings != null) {
      data['alertSettings'] =
          this.alertSettings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AlertScheduleSettings {
  String? alertScheduleName;
  bool? isEnabled;
  String? startTime;
  String? endTime;
  bool? isActive;
  Override? override;
  List<String>? daysOfWeek;

  AlertScheduleSettings(
      {this.alertScheduleName,
      this.isEnabled,
      this.startTime,
      this.endTime,
      this.isActive,
      this.override,
      this.daysOfWeek});

  AlertScheduleSettings.fromJson(Map<String, dynamic> json) {
    alertScheduleName = json['alertScheduleName'];
    isEnabled = json['isEnabled'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isActive = json['isActive'];
    override = json['override'] != null
        ? new Override.fromJson(json['override'])
        : null;
    daysOfWeek = json['daysOfWeek'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alertScheduleName'] = this.alertScheduleName;
    data['isEnabled'] = this.isEnabled;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['isActive'] = this.isActive;
    if (this.override != null) {
      data['override'] = this.override!.toJson();
    }
    data['daysOfWeek'] = this.daysOfWeek;
    return data;
  }
}

class Override {
  bool? isOverrideEnabled;
  String? mode;
  String? endTime;

  Override({this.isOverrideEnabled, this.mode, this.endTime});

  Override.fromJson(Map<String, dynamic> json) {
    isOverrideEnabled = json['isOverrideEnabled'];
    mode = json['mode'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOverrideEnabled'] = this.isOverrideEnabled;
    data['mode'] = this.mode;
    data['endTime'] = this.endTime;
    return data;
  }
}

class AlertSettings {
  String? systemTime;
  String? displayTime;
  String? alertName;
  double? value;
  String? unit;
  int? snooze;
  bool? enabled;
  int? secondaryTriggerCondition;
  String? soundTheme;
  String? soundOutputMode;

  AlertSettings(
      {this.systemTime,
      this.displayTime,
      this.alertName,
      this.value,
      this.unit,
      this.snooze,
      this.enabled,
      this.secondaryTriggerCondition,
      this.soundTheme,
      this.soundOutputMode});

  AlertSettings.fromJson(Map<String, dynamic> json) {
    systemTime = json['systemTime'];
    displayTime = json['displayTime'];
    alertName = json['alertName'];
    value = json['value'].toDouble();
    unit = json['unit'];
    snooze = json['snooze'];
    enabled = json['enabled'];
    secondaryTriggerCondition = json['secondaryTriggerCondition'];
    soundTheme = json['soundTheme'];
    soundOutputMode = json['soundOutputMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['systemTime'] = this.systemTime;
    data['displayTime'] = this.displayTime;
    data['alertName'] = this.alertName;
    data['value'] = this.value;
    data['unit'] = this.unit;
    data['snooze'] = this.snooze;
    data['enabled'] = this.enabled;
    data['secondaryTriggerCondition'] = this.secondaryTriggerCondition;
    data['soundTheme'] = this.soundTheme;
    data['soundOutputMode'] = this.soundOutputMode;
    return data;
  }
}
