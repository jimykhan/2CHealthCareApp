
import 'package:twochealthcare/models/rpm_models/dex_com_models/AlertScheduleSettings.dart';
import 'package:twochealthcare/models/rpm_models/dex_com_models/AlertSettings.dart';

class AlertScheduleList {
  AlertScheduleSettings? alertScheduleSettings;
  List<AlertSettings>? alertSettings;

  AlertScheduleList({this.alertScheduleSettings, this.alertSettings});

  AlertScheduleList.fromJson(Map<String, dynamic> json) {
    alertScheduleSettings = json['alertScheduleSettings'] != null
        ? new AlertScheduleSettings.fromJson(json['alertScheduleSettings'])
        : null;
    if (json['alertSettings'] != null) {
      alertSettings = [];
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
