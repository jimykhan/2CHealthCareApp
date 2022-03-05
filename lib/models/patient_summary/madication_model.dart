class MedicationModel {
  int? id;
  String? medicationName;
  String? dose;
  String? startDate;
  String? stopDate;
  String? status;
  int? patientId;
  String? patientName;

  MedicationModel(
      {this.id,
        this.medicationName,
        this.dose,
        this.startDate,
        this.stopDate,
        this.status,
        this.patientId,
        this.patientName});

  MedicationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicationName = json['medicationName'];
    dose = json['dose'];
    startDate = json['startDate'];
    stopDate = json['stopDate'];
    status = json['status'];
    patientId = json['patientId'];
    patientName = json['patientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['medicationName'] = this.medicationName;
    data['dose'] = this.dose;
    data['startDate'] = this.startDate;
    data['stopDate'] = this.stopDate;
    data['status'] = this.status;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    return data;
  }
}