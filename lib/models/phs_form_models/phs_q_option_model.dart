class PhsFormOptionRecords {
  int? id;
  bool? isSelected;
  String? text;
  int? weight;
  int? flag;
  int? sequenceNo;
  String? narration;
  bool? isAddressed;
  int? phsFormQuestionRecordId;

  PhsFormOptionRecords(
      {this.id,
      this.isSelected,
      this.text,
      this.weight,
      this.flag,
      this.sequenceNo,
      this.narration,
      this.isAddressed,
      this.phsFormQuestionRecordId});

  PhsFormOptionRecords.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSelected = json['isSelected'];
    text = json['text'];
    weight = json['weight'];
    flag = json['flag'];
    sequenceNo = json['sequenceNo'];
    narration = json['narration'];
    isAddressed = json['isAddressed'];
    phsFormQuestionRecordId = json['phsFormQuestionRecordId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isSelected'] = this.isSelected;
    data['text'] = this.text;
    data['weight'] = this.weight;
    data['flag'] = this.flag;
    data['sequenceNo'] = this.sequenceNo;
    data['narration'] = this.narration;
    data['isAddressed'] = this.isAddressed;
    data['phsFormQuestionRecordId'] = this.phsFormQuestionRecordId;
    return data;
  }
}