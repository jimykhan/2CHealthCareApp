class PatientCareProvider {
  int? id;
  String? name;
  String? email;
  String? contactNo;
  String? countryCallingCode;
  String? phoneNoWithCountryCallingCode;

  PatientCareProvider({this.id, this.name, this.email, this.contactNo,this.countryCallingCode,this.phoneNoWithCountryCallingCode});

  PatientCareProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contactNo'];
    countryCallingCode = json['countryCallingCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contactNo'] = this.contactNo;
    data['countryCallingCode'] = this.countryCallingCode;
    return data;
  }
}