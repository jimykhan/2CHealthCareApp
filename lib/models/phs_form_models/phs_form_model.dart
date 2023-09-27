import 'package:twochealthcare/models/phs_form_models/phs_question_model.dart';

class PhsFormModel {
  int? id;
  String? title;
  int? score;
  String? submittedDate;
  int? status;
  int? phsFormId;
  String? phsForm;
  int? patientId;
  String? patient;
  List<PhsFormQuestionRecords>? phsFormQuestionRecords;

  PhsFormModel(
      {this.id,
      this.title,
      this.score,
      this.submittedDate,
      this.status,
      this.phsFormId,
      this.phsForm,
      this.patientId,
      this.patient,
      this.phsFormQuestionRecords});

  PhsFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    score = json['score'];
    submittedDate = json['submittedDate'];
    status = json['status'];
    phsFormId = json['phsFormId'];
    phsForm = json['phsForm'];
    patientId = json['patientId'];
    patient = json['patient'];
    if (json['phsFormQuestionRecords'] != null) {
      phsFormQuestionRecords = <PhsFormQuestionRecords>[];
      json['phsFormQuestionRecords'].forEach((v) {
        phsFormQuestionRecords!.add(new PhsFormQuestionRecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['score'] = this.score;
    data['submittedDate'] = this.submittedDate;
    data['status'] = this.status;
    data['phsFormId'] = this.phsFormId;
    data['phsForm'] = this.phsForm;
    data['patientId'] = this.patientId;
    data['patient'] = this.patient;
    if (this.phsFormQuestionRecords != null) {
      data['phsFormQuestionRecords'] =
          this.phsFormQuestionRecords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


