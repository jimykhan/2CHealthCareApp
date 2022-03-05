class ImmunizationModel {
  int? id;
  String? date;
  String? note;
  int? vaccinationCodeId;
  String? vaccinationCode;
  String? vaccinationDescription;
  int? patientId;
  String? patientName;

  ImmunizationModel(
      {this.id,
        this.date,
        this.note,
        this.vaccinationCodeId,
        this.vaccinationCode,
        this.vaccinationDescription,
        this.patientId,
        this.patientName});

  ImmunizationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    note = json['note'];
    vaccinationCodeId = json['vaccinationCodeId'];
    vaccinationCode = json['vaccinationCode'];
    vaccinationDescription = json['vaccinationDescription'];
    patientId = json['patientId'];
    patientName = json['patientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['note'] = this.note;
    data['vaccinationCodeId'] = this.vaccinationCodeId;
    data['vaccinationCode'] = this.vaccinationCode;
    data['vaccinationDescription'] = this.vaccinationDescription;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    return data;
  }
}