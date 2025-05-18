import 'dart:convert';

class MedicalFacilityModel {
  final int medicalFacilityID;
  final String medicalFacilityName;
  final String medicalFacilityAddress;

  MedicalFacilityModel({
    required this.medicalFacilityID,
    required this.medicalFacilityName,
    required this.medicalFacilityAddress,
  });

  // Convert JSON to Model
  factory MedicalFacilityModel.fromJson(Map<String, dynamic> json) {
    return MedicalFacilityModel(
      medicalFacilityID: json['CoSoID'],
      medicalFacilityName: json['ten'],
      medicalFacilityAddress: json['diaChi'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'CoSoID': medicalFacilityID,
      'ten': medicalFacilityName,
      'diaChi': medicalFacilityAddress,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<MedicalFacilityModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => MedicalFacilityModel.fromJson(json)).toList();
  }
}
