class ChronicConditionModel {
  int? chronicConditionId;
  int? patientId;
  String? algorithm;
  String? note;

  ChronicConditionModel(
      {this.chronicConditionId, this.patientId, this.algorithm, this.note});

  ChronicConditionModel.fromJson(Map<String, dynamic> json) {
    chronicConditionId = json['chronicConditionId'];
    patientId = json['patientId'];
    algorithm = json['algorithm'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chronicConditionId'] = this.chronicConditionId;
    data['patientId'] = this.patientId;
    data['algorithm'] = this.algorithm;
    data['note'] = this.note;
    return data;
  }
}