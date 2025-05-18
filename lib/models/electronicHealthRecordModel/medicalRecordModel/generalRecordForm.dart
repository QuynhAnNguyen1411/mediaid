import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'detailedMedicationForm.dart';
import 'detailedRecordForm.dart';


class GeneralRecordForm {
  String examHistoryID;
  String diseaseConclusion;
  DateTime conclusionTime;
  String medicalFacility;
  String doctorName;
  String statusLabel;
  List<DetailedRecordForm>? detailedRecordList;
  List<DetailedMedicationForm>? detailedMedicationList;

  GeneralRecordForm({
    required this.examHistoryID,
    required this.diseaseConclusion,
    required this.conclusionTime,
    required this.medicalFacility,
    required this.doctorName,
    required this.statusLabel,
    required this.detailedRecordList,
    required this.detailedMedicationList,
  }) ;

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'examHistoryID': examHistoryID,
      'diseaseConclusion': diseaseConclusion,
      'conclusionTime': conclusionTime.toIso8601String(),
      'medicalFacility': medicalFacility,
      'doctorName': doctorName,
      'statusLabel': statusLabel,
      'detailedRecordList': detailedRecordList?.map((item) => item.toJson()).toList(),
      'detailedMedicationList': detailedMedicationList?.map((item) => item.toJson()).toList(),
    };
  }

  // Phương thức chuyển JSON -> Object
  factory GeneralRecordForm.fromJson(Map<String, dynamic> json) {
    var detailedRecordListFromJson = json['lichSuKhamChiTietList'] as List?;
    List<DetailedRecordForm>? detailedRecordList = detailedRecordListFromJson?.map((item) => DetailedRecordForm.fromJson(item)).toList();

    var detailedMedicationListFromJson = json['lichSuThuocChiTietList'] as List?;
    List<DetailedMedicationForm>? detailedMedicationList = detailedMedicationListFromJson?.map((item) => DetailedMedicationForm.fromJson(item)).toList();
    return GeneralRecordForm(
      examHistoryID: json['examHistoryID'],
      diseaseConclusion: json['diseaseConclusion'],
      conclusionTime: DateTime.parse(json['conclusionTime']),
      medicalFacility: json['medicalFacility'],
      doctorName: json['doctorName'],
      statusLabel: json['statusLabel'],
      detailedRecordList: detailedRecordList,
      detailedMedicationList: detailedMedicationList,
    );
  }
}
