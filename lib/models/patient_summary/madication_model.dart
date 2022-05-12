class MedicationModel {
  int? id;
  String? medicationName;
  String? rxCui;
  String? dose;
  String? startDate;
  String? stopDate;
  String? status;
  int? patientId;
  String? patientName;

  /// not in api response
  String? medlineUrl;


  MedicationModel(
      {this.id,
        this.medicationName,
        this.rxCui,
        this.dose,
        this.startDate,
        this.stopDate,
        this.status,
        this.patientId,
        this.patientName,
        this.medlineUrl
      });

  MedicationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicationName = json['medicationName'];
    rxCui = json['rxCui'];
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
    data['rxCui'] = this.rxCui;
    data['dose'] = this.dose;
    data['startDate'] = this.startDate;
    data['stopDate'] = this.stopDate;
    data['status'] = this.status;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    return data;
  }
}