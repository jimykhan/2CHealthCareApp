import 'package:twochealthcare/models/phs_form_models/phs_q_option_model.dart';

enum PhsQuestionType { yesNo, linearScale, singleSelect, multiSelect }

class PhsFormQuestionRecords {
  int? id;
  String? description;
  String? toolTip;
  bool? isMandatory;
  int? questionType;
  PhsQuestionType? phsquestionType;
  int? sequenceNo;
  int? phsFormRecordId;
  List<PhsFormOptionRecords>? phsFormOptionRecords;

  PhsFormQuestionRecords(
      {this.id,
      this.description,
      this.toolTip,
      this.isMandatory,
      this.questionType,
      this.sequenceNo,
      this.phsFormRecordId,
      this.phsFormOptionRecords});

  PhsFormQuestionRecords.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    toolTip = json['toolTip'];
    isMandatory = json['isMandatory'];
    questionType = json['questionType'];
    sequenceNo = json['sequenceNo'];
    phsFormRecordId = json['phsFormRecordId'];
    phsquestionType = PhsQuestionType.values[json['questionType']??0];
    if (json['phsFormOptionRecords'] != null) {
      phsFormOptionRecords = <PhsFormOptionRecords>[];
      json['phsFormOptionRecords'].forEach((v) {
        phsFormOptionRecords!.add(new PhsFormOptionRecords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['toolTip'] = this.toolTip;
    data['isMandatory'] = this.isMandatory;
    data['questionType'] = this.questionType;
    data['sequenceNo'] = this.sequenceNo;
    data['phsFormRecordId'] = this.phsFormRecordId;
    if (this.phsFormOptionRecords != null) {
      data['phsFormOptionRecords'] =
          this.phsFormOptionRecords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
