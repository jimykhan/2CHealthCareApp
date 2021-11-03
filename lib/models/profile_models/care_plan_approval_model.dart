class CarePlanApproval {
  int? id;
  String? status;
  String? approvedDate;
  String? comments;
  String? billingAppUserId;

  CarePlanApproval(
      {this.id,
        this.status,
        this.approvedDate,
        this.comments,
        this.billingAppUserId});

  CarePlanApproval.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    approvedDate = json['approvedDate'];
    comments = json['comments'];
    billingAppUserId = json['billingAppUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['approvedDate'] = this.approvedDate;
    data['comments'] = this.comments;
    data['billingAppUserId'] = this.billingAppUserId;
    return data;
  }
}