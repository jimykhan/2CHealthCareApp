class DiagnoseModel {
  int? id;
  String? practiceId;
  String? practiceName;
  String? encounterId;
  String? encounterTimestamp;
  String? icdCode;
  String? icdCodeSystem;
  String? diagnosisCodeId;
  String? description;
  String? diagnosisDate;
  String? resolvedDate;
  bool? isChronic;
  bool? isOnRpm;
  bool? isOnCcm;
  bool? isPrCMDiagnose;
  String? note;
  int? status;
  int? patientId;
  String? patientName;

  DiagnoseModel(
      {this.id,
        this.practiceId,
        this.practiceName,
        this.encounterId,
        this.encounterTimestamp,
        this.icdCode,
        this.icdCodeSystem,
        this.diagnosisCodeId,
        this.description,
        this.diagnosisDate,
        this.resolvedDate,
        this.isChronic,
        this.isOnRpm,
        this.isOnCcm,
        this.isPrCMDiagnose,
        this.note,
        this.status,
        this.patientId,
        this.patientName});

  DiagnoseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    practiceId = json['practiceId'];
    practiceName = json['practiceName'];
    encounterId = json['encounterId'];
    encounterTimestamp = json['encounterTimestamp'];
    icdCode = json['icdCode'];
    icdCodeSystem = json['icdCodeSystem'];
    diagnosisCodeId = json['diagnosisCodeId'];
    description = json['description'];
    diagnosisDate = json['diagnosisDate'];
    resolvedDate = json['resolvedDate'];
    isChronic = json['isChronic'];
    isOnRpm = json['isOnRpm'];
    isOnCcm = json['isOnCcm'];
    isPrCMDiagnose = json['isPrCMDiagnose'];
    note = json['note'];
    status = json['status'];
    patientId = json['patientId'];
    patientName = json['patientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['practiceId'] = this.practiceId;
    data['practiceName'] = this.practiceName;
    data['encounterId'] = this.encounterId;
    data['encounterTimestamp'] = this.encounterTimestamp;
    data['icdCode'] = this.icdCode;
    data['icdCodeSystem'] = this.icdCodeSystem;
    data['diagnosisCodeId'] = this.diagnosisCodeId;
    data['description'] = this.description;
    data['diagnosisDate'] = this.diagnosisDate;
    data['resolvedDate'] = this.resolvedDate;
    data['isChronic'] = this.isChronic;
    data['isOnRpm'] = this.isOnRpm;
    data['isOnCcm'] = this.isOnCcm;
    data['isPrCMDiagnose'] = this.isPrCMDiagnose;
    data['note'] = this.note;
    data['status'] = this.status;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    return data;
  }
}