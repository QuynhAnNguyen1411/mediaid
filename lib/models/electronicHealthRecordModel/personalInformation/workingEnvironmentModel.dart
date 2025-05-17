import 'dart:convert';

class WorkingEnvironmentModel {
  final int? workingEnvironmentID;
  final String workingEnvironmentName;

  WorkingEnvironmentModel({
    required this.workingEnvironmentID,
    required this.workingEnvironmentName,
  });

  // Convert JSON to Model
  factory WorkingEnvironmentModel.fromJson(Map<String, dynamic> json) {
    return WorkingEnvironmentModel(
      workingEnvironmentID: json['workingEnvironmentID'],
      workingEnvironmentName: json['workingEnvironmentName'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'workingEnvironmentID': workingEnvironmentID,
      'workingEnvironmentName': workingEnvironmentName,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<WorkingEnvironmentModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => WorkingEnvironmentModel.fromJson(json)).toList();
  }
}
