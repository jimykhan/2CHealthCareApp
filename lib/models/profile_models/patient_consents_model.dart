class PatientConsents {
  int? id;
  String? consentDate;
  String? note;
  bool? isConsentTaken;
  String? consentDocUrl;
  String? consentDocVersion;
  String? consentSignature;
  String? consentNature;
  int? consentType;
  int? consentNature1;
  bool? isRevoked;
  String? revokeDate;
  String? revokedReason;
  int? patientId;
  String? patientName;
  String? patientBillingProviderName;
  String? createdUser;
  String? createdBy;

  PatientConsents(
      {this.id,
        this.consentDate,
        this.note,
        this.isConsentTaken,
        this.consentDocUrl,
        this.consentDocVersion,
        this.consentSignature,
        this.consentNature,
        this.consentType,
        this.consentNature1,
        this.isRevoked,
        this.revokeDate,
        this.revokedReason,
        this.patientId,
        this.patientName,
        this.patientBillingProviderName,
        this.createdUser,
        this.createdBy});

  PatientConsents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consentDate = json['consentDate'];
    note = json['note'];
    isConsentTaken = json['isConsentTaken'];
    consentDocUrl = json['consentDocUrl'];
    consentDocVersion = json['consentDocVersion'];
    consentSignature = json['consentSignature'];
    consentNature = json['consentNature'];
    consentType = json['consentType'];
    consentNature1 = json['consentNature1'];
    isRevoked = json['isRevoked'];
    revokeDate = json['revokeDate'];
    revokedReason = json['revokedReason'];
    patientId = json['patientId'];
    patientName = json['patientName'];
    patientBillingProviderName = json['patientBillingProviderName'];
    createdUser = json['createdUser'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['consentDate'] = this.consentDate;
    data['note'] = this.note;
    data['isConsentTaken'] = this.isConsentTaken;
    data['consentDocUrl'] = this.consentDocUrl;
    data['consentDocVersion'] = this.consentDocVersion;
    data['consentSignature'] = this.consentSignature;
    data['consentNature'] = this.consentNature;
    data['consentType'] = this.consentType;
    data['consentNature1'] = this.consentNature1;
    data['isRevoked'] = this.isRevoked;
    data['revokeDate'] = this.revokeDate;
    data['revokedReason'] = this.revokedReason;
    data['patientId'] = this.patientId;
    data['patientName'] = this.patientName;
    data['patientBillingProviderName'] = this.patientBillingProviderName;
    data['createdUser'] = this.createdUser;
    data['createdBy'] = this.createdBy;
    return data;
  }
}