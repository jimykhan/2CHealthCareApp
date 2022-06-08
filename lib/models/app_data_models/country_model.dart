class CountryModel {
  int? id;
  String? name;
  String? code2;
  String? code3;
  String? currency;
  String? callingCode;
  String? capital;
  String? region;
  String? subregion;

  CountryModel(
      {this.id,
        this.name,
        this.code2,
        this.code3,
        this.currency,
        this.callingCode,
        this.capital,
        this.region,
        this.subregion});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code2 = json['code2'];
    code3 = json['code3'];
    currency = json['currency'];
    callingCode = json['callingCode'];
    capital = json['capital'];
    region = json['region'];
    subregion = json['subregion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code2'] = this.code2;
    data['code3'] = this.code3;
    data['currency'] = this.currency;
    data['callingCode'] = this.callingCode;
    data['capital'] = this.capital;
    data['region'] = this.region;
    data['subregion'] = this.subregion;
    return data;
  }
}