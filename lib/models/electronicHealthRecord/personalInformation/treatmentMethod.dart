import 'dart:convert';

class TreatmentMethod {
  final int? treatmentMethodID;
  final String treatmentMethodName;

  TreatmentMethod({
    required this.treatmentMethodID,
    required this.treatmentMethodName,
  });

  // Convert JSON to Model
  factory TreatmentMethod.fromJson(Map<String, dynamic> json) {
    return TreatmentMethod(
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
  static List<TreatmentMethod> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => TreatmentMethod.fromJson(json)).toList();
  }
}
