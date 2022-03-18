class SurgicalHistoryModel {
  int? id;
  String? dateOperated;
  int? surgicalProcedureId;
  String? surgeonName;
  String? procedure;
  String? notes;
  int? surgicalSystemId;
  String? surgicalSystemName;
  String? createdOn;
  String? createdUser;
  int? patientId;

  SurgicalHistoryModel(
      {this.id,
        this.dateOperated,
        this.surgicalProcedureId,
        this.surgeonName,
        this.procedure,
        this.notes,
        this.surgicalSystemId,
        this.surgicalSystemName,
        this.createdOn,
        this.createdUser,
        this.patientId});

  SurgicalHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateOperated = json['dateOperated'];
    surgicalProcedureId = json['surgicalProcedureId'];
    surgeonName = json['surgeonName'];
    procedure = json['procedure'];
    notes = json['notes'];
    surgicalSystemId = json['surgicalSystemId'];
    surgicalSystemName = json['surgicalSystemName'];
    createdOn = json['createdOn'];
    createdUser = json['createdUser'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateOperated'] = this.dateOperated;
    data['surgicalProcedureId'] = this.surgicalProcedureId;
    data['surgeonName'] = this.surgeonName;
    data['procedure'] = this.procedure;
    data['notes'] = this.notes;
    data['surgicalSystemId'] = this.surgicalSystemId;
    data['surgicalSystemName'] = this.surgicalSystemName;
    data['createdOn'] = this.createdOn;
    data['createdUser'] = this.createdUser;
    data['patientId'] = this.patientId;
    return data;
  }
}