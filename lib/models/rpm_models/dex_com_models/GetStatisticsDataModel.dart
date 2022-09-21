// {hypoglycemiaRisk: null, min: 39, max: 164, mean: 118.69639318271894, median: 119.0, variance: 183.29585302337,
// stdDev: 13.53867988481041, sum: 299471.0, q1: 111.0, q2: 119.0, q3: 126.0, utilizationPercent: 79.64015151515152,
// meanDailyCalibrations: 0.0, nDays: 11, nValues: 2523, nUrgentLow: 4, nBelowRange: 17, nWithinRange: 2502, nAboveRange: 0,
// percentUrgentLow: 0.15854141894569956, percentBelowRange: 0.6738010305192231, percentWithinRange: 99.16765755053508,
// percentAboveRange: 0.0}
class GetStatisticsDataModel {
  String? hypoglycemiaRisk;
  int? min;
  int? max;
  double? mean;
  double? median;
  double? variance;
  double? stdDev;
  double? sum;
  double? q1;
  double? q2;
  double? q3;
  double? utilizationPercent;
  double? meanDailyCalibrations;
  int? nDays;
  int? nValues;
  int? nUrgentLow;
  int? nBelowRange;
  int? nWithinRange;
  int? nAboveRange;
  double? percentUrgentLow;
  double? percentBelowRange;
  double? percentWithinRange;
  double? percentAboveRange;

  GetStatisticsDataModel(
      {this.hypoglycemiaRisk,
        this.min,
        this.max,
        this.mean,
        this.median,
        this.variance,
        this.stdDev,
        this.sum,
        this.q1,
        this.q2,
        this.q3,
        this.utilizationPercent,
        this.meanDailyCalibrations,
        this.nDays,
        this.nValues,
        this.nUrgentLow,
        this.nBelowRange,
        this.nWithinRange,
        this.nAboveRange,
        this.percentUrgentLow,
        this.percentBelowRange,
        this.percentWithinRange,
        this.percentAboveRange});

  GetStatisticsDataModel.fromJson(Map<String, dynamic> json) {
    hypoglycemiaRisk = json['hypoglycemiaRisk'];
    min = json['min'];
    max = json['max'];
    mean = json['mean'];
    median = json['median'];
    variance = json['variance'];
    stdDev = json['stdDev'];
    sum = json['sum'];
    q1 = json['q1'];
    q2 = json['q2'];
    q3 = json['q3'];
    utilizationPercent = json['utilizationPercent'];
    meanDailyCalibrations = json['meanDailyCalibrations'];
    nDays = json['nDays'];
    nValues = json['nValues'];
    nUrgentLow = json['nUrgentLow'];
    nBelowRange = json['nBelowRange'];
    nWithinRange = json['nWithinRange'];
    nAboveRange = json['nAboveRange'];
    percentUrgentLow = json['percentUrgentLow'];
    percentBelowRange = json['percentBelowRange'];
    percentWithinRange = json['percentWithinRange'];
    percentAboveRange = json['percentAboveRange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hypoglycemiaRisk'] = this.hypoglycemiaRisk;
    data['min'] = this.min;
    data['max'] = this.max;
    data['mean'] = this.mean;
    data['median'] = this.median;
    data['variance'] = this.variance;
    data['stdDev'] = this.stdDev;
    data['sum'] = this.sum;
    data['q1'] = this.q1;
    data['q2'] = this.q2;
    data['q3'] = this.q3;
    data['utilizationPercent'] = this.utilizationPercent;
    data['meanDailyCalibrations'] = this.meanDailyCalibrations;
    data['nDays'] = this.nDays;
    data['nValues'] = this.nValues;
    data['nUrgentLow'] = this.nUrgentLow;
    data['nBelowRange'] = this.nBelowRange;
    data['nWithinRange'] = this.nWithinRange;
    data['nAboveRange'] = this.nAboveRange;
    data['percentUrgentLow'] = this.percentUrgentLow;
    data['percentBelowRange'] = this.percentBelowRange;
    data['percentWithinRange'] = this.percentWithinRange;
    data['percentAboveRange'] = this.percentAboveRange;
    return data;
  }
}