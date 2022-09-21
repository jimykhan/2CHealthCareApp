class AlertSettings {
  String? systemTime;
  String? displayTime;
  String? alertName;
  int? value;
  String? unit;
  int? snooze;
  bool? enabled;

  AlertSettings(
      {this.systemTime,
        this.displayTime,
        this.alertName,
        this.value,
        this.unit,
        this.snooze,
        this.enabled});

  AlertSettings.fromJson(Map<String, dynamic> json) {
    systemTime = json['systemTime'];
    displayTime = json['displayTime'];
    alertName = json['alertName'];
    value = json['value'];
    unit = json['unit'];
    snooze = json['snooze'];
    enabled = json['enabled'];
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
    return data;
  }
}