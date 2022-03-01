class DashboardPatientSummary {
  int? ccmActivePatientsCount;
  int? ccmTimeCompletedPatientsCount;
  int? rpmActivePatientsCount;
  int? rpmTimeCompletedPatientsCount;
  int? rpmTransmissionCompletedPatientsCount;

  DashboardPatientSummary(
      {this.ccmActivePatientsCount,
        this.ccmTimeCompletedPatientsCount,
        this.rpmActivePatientsCount,
        this.rpmTimeCompletedPatientsCount,
        this.rpmTransmissionCompletedPatientsCount});

  DashboardPatientSummary.fromJson(Map<String, dynamic> json) {
    ccmActivePatientsCount = json['ccmActivePatientsCount'];
    ccmTimeCompletedPatientsCount = json['ccmTimeCompletedPatientsCount'];
    rpmActivePatientsCount = json['rpmActivePatientsCount'];
    rpmTimeCompletedPatientsCount = json['rpmTimeCompletedPatientsCount'];
    rpmTransmissionCompletedPatientsCount =
    json['rpmTransmissionCompletedPatientsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ccmActivePatientsCount'] = this.ccmActivePatientsCount;
    data['ccmTimeCompletedPatientsCount'] = this.ccmTimeCompletedPatientsCount;
    data['rpmActivePatientsCount'] = this.rpmActivePatientsCount;
    data['rpmTimeCompletedPatientsCount'] = this.rpmTimeCompletedPatientsCount;
    data['rpmTransmissionCompletedPatientsCount'] =
        this.rpmTransmissionCompletedPatientsCount;
    return data;
  }
}