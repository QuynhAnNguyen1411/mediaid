
import 'package:mediaid/models/setExamNumberModel/symptomModel.dart';

import 'clinicModel.dart';

class BodyPart2Model {
  final String bodyPart2ID;
  final String bodyPart2Name;
  final List<SymptomModel>? symptomsList;

  BodyPart2Model({
    required this.bodyPart2ID,
    required this.bodyPart2Name,
    this.symptomsList,
  });


  // Convert JSON to Model using List
  factory BodyPart2Model.fromJson(Map<String, dynamic> json) {
    // Giải mã bodyPart2List thành List<BodyPart2Model>
    var symptomsListFromJson = json['danhSachTrieuChungs'] as List?;
    List<SymptomModel>? symptomsList = symptomsListFromJson?.map((item) => SymptomModel.fromJson(item)).toList();

    return BodyPart2Model(
      bodyPart2ID: json['boPhanID'] ?? '',
      bodyPart2Name: json['ten'] ?? '',
      symptomsList: symptomsList,
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'bodyPart2ID': bodyPart2ID,
      'bodyPart2Name': bodyPart2Name,
      'symptomsList': symptomsList?.map((item) => item.toJson()).toList(),
    };
  }
}
