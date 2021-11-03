class DiagnosesList {
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
  bool? isPrCMDiagnose;
  String? note;
  int? status;
  int? patientId;
  String? patientName;

  DiagnosesList(
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
        this.isPrCMDiagnose,
        this.note,
        this.status,
        this.patientId,
        this.patientName});

  DiagnosesList.fromJson(Map<String, dynamic> json) {
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
    data['isPrCMDiagnose'] = this.isPrCMDiagnose;
    data['note'] = this.note;
    data['status'] = this.status;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    return data;
  }
}