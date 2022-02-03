class Organization {
  int? id;
  String? name;
  String? contactEmail;
  String? contactNumber;
  String? website;
  String? dateAdded;

  Organization(
      {this.id,
        this.name,
        this.contactEmail,
        this.contactNumber,
        this.website,
        this.dateAdded});

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactEmail = json['contactEmail'];
    contactNumber = json['contactNumber'];
    website = json['website'];
    dateAdded = json['dateAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contactEmail'] = this.contactEmail;
    data['contactNumber'] = this.contactNumber;
    data['website'] = this.website;
    data['dateAdded'] = this.dateAdded;
    return data;
  }
}