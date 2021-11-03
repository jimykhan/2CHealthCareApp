class CareProviders {
  int? careProviderId;
  String? fullName;
  String? nameAbbreviation;

  CareProviders({this.careProviderId, this.fullName, this.nameAbbreviation});

  CareProviders.fromJson(Map<String, dynamic> json) {
    careProviderId = json['careProviderId'];
    fullName = json['fullName'];
    nameAbbreviation = json['nameAbbreviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['careProviderId'] = this.careProviderId;
    data['fullName'] = this.fullName;
    data['nameAbbreviation'] = this.nameAbbreviation;
    return data;
  }
}