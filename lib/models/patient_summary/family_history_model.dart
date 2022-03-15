class FamilyHistoryModel {
  int? id;
  String? relation;
  String? condition;
  String? note;
  String? updatedOn;
  int? patientId;

  FamilyHistoryModel(
      {this.id,
        this.relation,
        this.condition,
        this.note,
        this.updatedOn,
        this.patientId});

  FamilyHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relation = json['relation'];
    condition = json['condition'];
    note = json['note'];
    updatedOn = json['updatedOn'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['relation'] = this.relation;
    data['condition'] = this.condition;
    data['note'] = this.note;
    data['updatedOn'] = this.updatedOn;
    data['patientId'] = this.patientId;
    return data;
  }
}