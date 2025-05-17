import 'dart:convert';

class TreatmentMethodModel {
  final int? treatmentMethodID;
  final String treatmentMethodName;

  TreatmentMethodModel({
    required this.treatmentMethodID,
    required this.treatmentMethodName,
  });

  // Convert JSON to Model
  factory TreatmentMethodModel.fromJson(Map<String, dynamic> json) {
    return TreatmentMethodModel(
      treatmentMethodID: json['treatmentMethodID'],
      treatmentMethodName: json['treatmentMethodName'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'treatmentMethodID': treatmentMethodID,
      'treatmentMethodName': treatmentMethodName,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<TreatmentMethodModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => TreatmentMethodModel.fromJson(json)).toList();
  }
}
