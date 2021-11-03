class Medications {
  int? id;
  String? medicationName;
  String? genericName;
  String? brandName;
  String? dose;
  String? route;
  String? doseForm;
  String? originalStartDate;
  String? startDate;
  String? stopDate;
  String? sigDescription;
  String? ndcId;
  String? rxNormCode;
  String? status;
  int? patientId;

  Medications(
      {this.id,
        this.medicationName,
        this.genericName,
        this.brandName,
        this.dose,
        this.route,
        this.doseForm,
        this.originalStartDate,
        this.startDate,
        this.stopDate,
        this.sigDescription,
        this.ndcId,
        this.rxNormCode,
        this.status,
        this.patientId});

  Medications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicationName = json['medicationName'];
    genericName = json['genericName'];
    brandName = json['brandName'];
    dose = json['dose'];
    route = json['route'];
    doseForm = json['doseForm'];
    originalStartDate = json['originalStartDate'];
    startDate = json['startDate'];
    stopDate = json['stopDate'];
    sigDescription = json['sigDescription'];
    ndcId = json['ndcId'];
    rxNormCode = json['rxNormCode'];
    status = json['status'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['medicationName'] = this.medicationName;
    data['genericName'] = this.genericName;
    data['brandName'] = this.brandName;
    data['dose'] = this.dose;
    data['route'] = this.route;
    data['doseForm'] = this.doseForm;
    data['originalStartDate'] = this.originalStartDate;
    data['startDate'] = this.startDate;
    data['stopDate'] = this.stopDate;
    data['sigDescription'] = this.sigDescription;
    data['ndcId'] = this.ndcId;
    data['rxNormCode'] = this.rxNormCode;
    data['status'] = this.status;
    data['patientId'] = this.patientId;
    return data;
  }
}