

import 'package:mediaid/models/setExamNumberModel/symptomModel.dart';

class DiagnoseModel {
  final String accountID;
  final String? bodyPart1ID;
  final String? bodyPart2ID;
  final int medicalFacilityID;
  final List<String>? symptomList;

  DiagnoseModel({
    required this.accountID,
    this.bodyPart1ID,
    this.bodyPart2ID,
    required this.medicalFacilityID,
    this.symptomList,
  });

  // Convert JSON to Model using List
  factory DiagnoseModel.fromJson(Map<String, dynamic> json) {
    return DiagnoseModel(
      accountID: json['accountID'] ?? '',
      bodyPart1ID: json['bodyPart1ID'] ?? '',
      bodyPart2ID: json['bodyPart2ID'] ?? '',
      medicalFacilityID: json['medicalFacilityID'] ?? 0,
      symptomList: json['trieuChungList'] as List<String> ?? []
    );
  }

  set bodyPart1(String bodyPart1) {}

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'accountID': accountID,
      'bodyPart1ID': bodyPart1ID,
      'bodyPart2ID': bodyPart2ID,
      'medicalFacilityID': medicalFacilityID,
      'symptomList': symptomList,
    };
  }
}
