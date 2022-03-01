class FacilityModel {
  int? id;
  int? facilityType;
  String? facilityName;
  String? shortName;
  String? facilityDescription;
  String? zipCode;
  String? contactEmail;
  String? invoiceContactEmail;
  String? invoiceContactCCEmail;
  String? phoneNumber;
  String? faxNumber;
  String? website;
  String? address;
  String? city;
  String? stateName;
  int? emrId;
  double? monthlyCharge;
  int? organizationId;


  FacilityModel(
      {this.id,
        this.facilityType,
        this.facilityName,
        this.shortName,
        this.facilityDescription,
        this.zipCode,
        this.contactEmail,
        this.invoiceContactEmail,
        this.invoiceContactCCEmail,
        this.phoneNumber,
        this.faxNumber,
        this.website,
        this.address,
        this.city,
        this.stateName,
        this.emrId,
        this.monthlyCharge,
        this.organizationId});

  FacilityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityType = json['facilityType'];
    facilityName = json['facilityName'];
    shortName = json['shortName'];
    facilityDescription = json['facilityDescription'];
    zipCode = json['zipCode'];
    contactEmail = json['contactEmail'];
    invoiceContactEmail = json['invoiceContactEmail'];
    invoiceContactCCEmail = json['invoiceContactCCEmail'];
    phoneNumber = json['phoneNumber'];
    faxNumber = json['faxNumber'];
    website = json['website'];
    address = json['address'];
    city = json['city'];
    stateName = json['stateName'];
    emrId = json['emrId'];
    monthlyCharge = json['monthlyCharge'];
    organizationId = json['organizationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['facilityType'] = this.facilityType;
    data['facilityName'] = this.facilityName;
    data['shortName'] = this.shortName;
    data['facilityDescription'] = this.facilityDescription;
    data['zipCode'] = this.zipCode;
    data['contactEmail'] = this.contactEmail;
    data['invoiceContactEmail'] = this.invoiceContactEmail;
    data['invoiceContactCCEmail'] = this.invoiceContactCCEmail;
    data['phoneNumber'] = this.phoneNumber;
    data['faxNumber'] = this.faxNumber;
    data['website'] = this.website;
    data['address'] = this.address;
    data['city'] = this.city;
    data['stateName'] = this.stateName;
    data['emrId'] = this.emrId;
    data['monthlyCharge'] = this.monthlyCharge;
    data['organizationId'] = this.organizationId;
    return data;
  }
}