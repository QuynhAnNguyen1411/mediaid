

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DetailedRecordForm {
  String detailedRecordID;
  String examinationType;
  String examinationName;
  DateTime examinationTime;
  String clinicNumber;
  String examinationLocation;
  String examinationNote;
  String testPhoto;
  double value;


  DetailedRecordForm({
    required this.detailedRecordID,
    required this.examinationType,
    required this.examinationName,
    required this.examinationTime,
    required this.clinicNumber,
    required this.examinationLocation,
    required this.examinationNote,
    required this.testPhoto,
    required this.value,
  }) ;

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'detailedRecordID': detailedRecordID,
      'examinationType': examinationType,
      'examinationName': examinationName,
      'examinationTime': examinationTime,
      'clinicNumber': clinicNumber,
      'examinationLocation': examinationLocation,
      'examinationNote': examinationNote,
      'testPhoto': testPhoto,
      'value': value,
    };
  }

  // Phương thức chuyển JSON -> Object
  factory DetailedRecordForm.fromJson(Map<String, dynamic> json) {
    return DetailedRecordForm(
      detailedRecordID: json['detailedRecordID'],
      examinationType: json['examinationType'],
      examinationName: json['examinationName'],
      examinationTime: json['examinationTime'],
      clinicNumber: json['clinicNumber'],
      examinationLocation: json['examinationLocation'],
      examinationNote: json['examinationNote'],
      testPhoto: json['testPhoto'],
      value: json['value'] is double
          ? json['value']
          : double.tryParse(json['value'].toString()) ?? 0.0,
    );
  }
}
