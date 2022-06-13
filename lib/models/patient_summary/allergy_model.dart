class AllergyModel {
  int? id;
  String? agent;
  String? reaction;
  int? type;
  int? criticality;
  int? clinicalStatus;
  int? category;
  int? patientId;
  String? patient;
  String? tenantId;
  String? createdOn;
  String? createdUser;
  String? updatedOn;
  String? updatedUser;
  bool? isActiveState;
  bool? isDeletedState;

  /// will be filled from enum in service not in backend dto
  String? typeString;
  String? categoryString;
  String? clinicStatusString;

  AllergyModel(
      {this.id,
        this.agent,
        this.reaction,
        this.type,
        this.criticality,
        this.clinicalStatus,
        this.category,
        this.patientId,
        this.patient,
        this.tenantId,
        this.createdOn,
        this.createdUser,
        this.updatedOn,
        this.updatedUser,
        this.isActiveState,
        this.isDeletedState,
        this.categoryString,
        this.clinicStatusString,
        this.typeString,
      });

  AllergyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agent = json['agent'];
    reaction = json['reaction'];
    type = json['type'];
    criticality = json['criticality'];
    clinicalStatus = json['clinicalStatus'];
    category = json['category'];
    patientId = json['patientId'];
    patient = json['patient'];
    tenantId = json['tenantId'];
    createdOn = json['createdOn'];
    createdUser = json['createdUser'];
    updatedOn = json['updatedOn'];
    updatedUser = json['updatedUser'];
    isActiveState = json['isActiveState'];
    isDeletedState = json['isDeletedState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agent'] = this.agent;
    data['reaction'] = this.reaction;
    data['type'] = this.type;
    data['criticality'] = this.criticality;
    data['clinicalStatus'] = this.clinicalStatus;
    data['category'] = this.category;
    data['patientId'] = this.patientId;
    data['patient'] = this.patient;
    data['tenantId'] = this.tenantId;
    data['createdOn'] = this.createdOn;
    data['createdUser'] = this.createdUser;
    data['updatedOn'] = this.updatedOn;
    data['updatedUser'] = this.updatedUser;
    data['isActiveState'] = this.isActiveState;
    data['isDeletedState'] = this.isDeletedState;
    return data;
  }
}
