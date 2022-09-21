class DexcomAvgs {
  String? unit;
  String? rateUnit;
  List<Egvs>? egvs;

  DexcomAvgs({this.unit, this.rateUnit, this.egvs});

  DexcomAvgs.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    rateUnit = json['rateUnit'];
    if (json['egvs'] != null) {
      egvs = [];
      json['egvs'].forEach((v) {
        egvs!.add(new Egvs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit'] = this.unit;
    data['rateUnit'] = this.rateUnit;
    if (this.egvs != null) {
      data['egvs'] = this.egvs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Egvs {
  String? systemTime;
  String? displayTime;
  int? value;
  int? realtimeValue;
  int? smoothedValue;
  String? status;
  String? trend;
  double? trendRate;

  Egvs(
      {this.systemTime,
      this.displayTime,
      this.value,
      this.realtimeValue,
      this.smoothedValue,
      this.status,
      this.trend,
      this.trendRate});

  Egvs.fromJson(Map<String, dynamic> json) {
    systemTime = json['systemTime'];
    displayTime = json['displayTime'];
    value = json['value'];
    realtimeValue = json['realtimeValue'];
    smoothedValue = json['smoothedValue'];
    status = json['status'];
    trend = json['trend'];
    trendRate = json['trendRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['systemTime'] = this.systemTime;
    data['displayTime'] = this.displayTime;
    data['value'] = this.value;
    data['realtimeValue'] = this.realtimeValue;
    data['smoothedValue'] = this.smoothedValue;
    data['status'] = this.status;
    data['trend'] = this.trend;
    data['trendRate'] = this.trendRate;
    return data;
  }
}
