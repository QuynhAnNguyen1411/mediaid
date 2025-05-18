import 'package:mediaid/models/setExamNumberModel/bodyPart_2Model.dart';

class SymptomModel {
  final String symptomID;
  final String symptomName;

  SymptomModel({
    required this.symptomID,
    required this.symptomName,
  });

  // Convert JSON to Model
  factory SymptomModel.fromJson(Map<String, dynamic> json) {

    return SymptomModel(
      symptomID: json['trieuChungID'] ?? '',
      symptomName: json['trieuChung'] ?? '',
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'boPhanID': symptomID,
      'ten': symptomName,
    };
  }
}
