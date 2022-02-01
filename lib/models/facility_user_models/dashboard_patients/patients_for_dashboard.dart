import 'package:twochealthcare/models/facility_user_models/dashboard_patients/paging_data.dart';
import 'package:twochealthcare/models/facility_user_models/dashboard_patients/patients_list.dart';

class PatientsForDashboard {
  PagingData? pagingData;
  List<PatientsList>? patientsList;

  PatientsForDashboard({this.pagingData, this.patientsList});

  PatientsForDashboard.fromJson(Map<String, dynamic> json) {
    pagingData = json['pagingData'] != null
        ? new PagingData.fromJson(json['pagingData'])
        : null;
    if (json['patientsList'] != null) {
      patientsList = <PatientsList>[];
      json['patientsList'].forEach((v) {
        patientsList!.add(new PatientsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagingData != null) {
      data['pagingData'] = this.pagingData!.toJson();
    }
    if (this.patientsList != null) {
      data['patientsList'] = this.patientsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}