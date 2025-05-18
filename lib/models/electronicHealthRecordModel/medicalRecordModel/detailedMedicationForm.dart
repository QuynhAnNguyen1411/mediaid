
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DetailedMedicationForm {
  String examHistoryID;
  String detailedMedicationID;
  String medicineName;
  String instructions;
  double dosage;
  String unit;

  DetailedMedicationForm({
    required this.examHistoryID,
    required this.detailedMedicationID,
    required this.medicineName,
    required this.instructions,
    required this.dosage,
    required this.unit,
  }) ;

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'examHistoryID': examHistoryID,
      'detailedMedicationID': detailedMedicationID,
      'medicineName': medicineName,
      'instructions': instructions,
      'dosage': dosage,
      'unit': unit,
    };
  }

  // Phương thức chuyển JSON -> Object
  factory DetailedMedicationForm.fromJson(Map<String, dynamic> json) {
    return DetailedMedicationForm(
      examHistoryID: json['examHistoryID'],
      detailedMedicationID: json['detailedMedicationID'],
      medicineName: json['medicineName'],
      instructions: json['instructions'],
      dosage: json['dosage'] is double ? json['dosage'] : double.tryParse(json['dosage'].toString()) ?? 0.0,
      unit: json['unit'],
    );
  }
}
