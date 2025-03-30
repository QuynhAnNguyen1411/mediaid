import 'dart:convert';

class PersonalInformationModel{
  final String examinationBookID;
  final String patientName;
  final String personalIdentifier;
  final String healthInsurance;
  final String phoneNumber;

  PersonalInformationModel({
    required this.examinationBookID,
    required this.patientName,
    required this.personalIdentifier,
    required this.healthInsurance,
    required this.phoneNumber,
  });

  // Convert JSON to Model
  factory PersonalInformationModel.fromJson(Map<String, dynamic> json) {
    return PersonalInformationModel(
      examinationBookID: json['examinationBookID'],
      patientName: json['patientName'],
      personalIdentifier: json['personalIdentifier'],
      healthInsurance: json['healthInsurance'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'examinationBookID': examinationBookID,
      'patientName': patientName,
      'personalIdentifier': personalIdentifier,
      'healthInsurance': healthInsurance,
      'phoneNumber': phoneNumber,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<PersonalInformationModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => PersonalInformationModel.fromJson(json)).toList();
  }
}
