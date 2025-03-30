import 'dart:convert';

class WorkingEnvironment {
  final int? workingEnvironmentID;
  final String workingEnvironmentName;

  WorkingEnvironment({
    required this.workingEnvironmentID,
    required this.workingEnvironmentName,
  });

  // Convert JSON to Model
  factory WorkingEnvironment.fromJson(Map<String, dynamic> json) {
    return WorkingEnvironment(
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
  static List<WorkingEnvironment> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => WorkingEnvironment.fromJson(json)).toList();
  }
}
