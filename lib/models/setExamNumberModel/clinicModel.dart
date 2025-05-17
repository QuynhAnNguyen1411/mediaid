
import 'dart:convert';

import 'bodyPart_2Model.dart';

class ClinicModel {
  final String clinicID;
  final String clinicName;

  ClinicModel({
    required this.clinicID,
    required this.clinicName,
  });

  // Convert JSON to Model
  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      clinicID: json['clinicID'],
      clinicName: json['clinicName'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'clinicID': clinicID,
      'clinicName': clinicName,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<ClinicModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => ClinicModel.fromJson(json)).toList();
  }
}
