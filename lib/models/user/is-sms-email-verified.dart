
class IsSmsEmailVerified {
  bool? verifiedEmail;
  bool? verifiedSMS;

  IsSmsEmailVerified({this.verifiedEmail, this.verifiedSMS});

  IsSmsEmailVerified.fromJson(Map<String, dynamic> json) {
    verifiedEmail = json['verifiedEmail'];
    verifiedSMS = json['verifiedSMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verifiedEmail'] = this.verifiedEmail;
    data['verifiedSMS'] = this.verifiedSMS;
    return data;
  }
}