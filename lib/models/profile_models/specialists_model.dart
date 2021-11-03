class Specialists {
  int? id;
  String? practiceId;
  String? firstName;
  String? lastName;
  String? middleName;
  String? phone;
  String? degree;
  String? specialty;
  String? prevAppointment;
  String? nextAppointment;
  int? patientId;

  Specialists(
      {this.id,
        this.practiceId,
        this.firstName,
        this.lastName,
        this.middleName,
        this.phone,
        this.degree,
        this.specialty,
        this.prevAppointment,
        this.nextAppointment,
        this.patientId});

  Specialists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    practiceId = json['practiceId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    phone = json['phone'];
    degree = json['degree'];
    specialty = json['specialty'];
    prevAppointment = json['prevAppointment'];
    nextAppointment = json['nextAppointment'];
    patientId = json['patientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['practiceId'] = this.practiceId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['phone'] = this.phone;
    data['degree'] = this.degree;
    data['specialty'] = this.specialty;
    data['prevAppointment'] = this.prevAppointment;
    data['nextAppointment'] = this.nextAppointment;
    data['patientId'] = this.patientId;
    return data;
  }
}