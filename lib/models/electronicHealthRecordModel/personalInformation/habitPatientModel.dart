import 'dart:convert';

class HabitPatientModel {
  final int habitPatientID;
  final String habitPatientName;

  HabitPatientModel({
    required this.habitPatientID,
    required this.habitPatientName,
  });

  // Convert JSON to Model
  factory HabitPatientModel.fromJson(Map<String, dynamic> json) {
    return HabitPatientModel(
      habitPatientID: json['habitPatientID'],
      habitPatientName: json['habitPatientName'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'habitPatientID': habitPatientID,
      'habitPatientName': habitPatientName,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<HabitPatientModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => HabitPatientModel.fromJson(json)).toList();
  }
}
