
class IsSmsEmailVerified {
  bool? verifiedEmail;
  bool? verifiedSMS;
  String? email;
  String? phoneNumber;

  IsSmsEmailVerified(
      {this.verifiedEmail, this.verifiedSMS, this.email, this.phoneNumber});

  IsSmsEmailVerified.fromJson(Map<String, dynamic> json) {
    verifiedEmail = json['verifiedEmail'];
    verifiedSMS = json['verifiedSMS'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verifiedEmail'] = this.verifiedEmail;
    data['verifiedSMS'] = this.verifiedSMS;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}