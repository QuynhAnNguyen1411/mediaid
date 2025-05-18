import 'dart:convert';

class PersonalInformationForm{
  String examinationBookID;
  String patientName;
  String personalIdentifier;
  String healthInsurance;
  String addressPatient;
  String phoneNumber;
  String? emailPatient;
  String dob;
  int sexPatient;
  int nationPatient;

  String patientFamilyName;
  String patientFamilyIdentifier;
  String patientRelationship;
  String patientFamilyPhoneNumber;

  PersonalInformationForm({
    required this.examinationBookID,
    required this.patientName,
    required this.personalIdentifier,
    required this.healthInsurance,
    required this.addressPatient,
    required this.phoneNumber,
    this.emailPatient,
    required this.dob,
    required this.sexPatient,
    required this.nationPatient,
    required this.patientFamilyName,
    required this.patientFamilyIdentifier,
    required this.patientRelationship,
    required this.patientFamilyPhoneNumber,
  });

  // Convert JSON to Model
  factory PersonalInformationForm.fromJson(Map<String, dynamic> json) {
    return PersonalInformationForm(
      examinationBookID: json['examinationBookID'],
      patientName: json['patientName'],
      personalIdentifier: json['personalIdentifier'],
      healthInsurance: json['healthInsurance'],
      addressPatient: json['addressPatient'],
      phoneNumber: json['phoneNumber'],
      emailPatient: json['emailPatient'],
      dob: json['dob'],
      sexPatient: json['sexPatient'],
      nationPatient: json['nationPatient'],
      patientFamilyName: json['patientFamilyName'],
      patientFamilyIdentifier: json['patientFamilyIdentifier'],
      patientRelationship: json['patientRelationship'],
      patientFamilyPhoneNumber: json['patientFamilyPhoneNumber'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'examinationBookID': examinationBookID,
      'patientName': patientName,
      'personalIdentifier': personalIdentifier,
      'healthInsurance': healthInsurance,
      'addressPatient': addressPatient,
      'phoneNumber': phoneNumber,
      'emailPatient': emailPatient,
      'dob': dob,
      'sexPatient': sexPatient,
      'nationPatient': nationPatient,
      'patientFamilyName': patientFamilyName,
      'patientFamilyIdentifier': patientFamilyIdentifier,
      'patientRelationship': patientRelationship,
      'patientFamilyPhoneNumber': patientFamilyPhoneNumber,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<PersonalInformationForm> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => PersonalInformationForm.fromJson(json)).toList();
  }
}
