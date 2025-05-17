import 'dart:convert';

class UsageStatusModel {
  final int usageStatusID;
  final String usageStatusName;

  UsageStatusModel({
    required this.usageStatusID,
    required this.usageStatusName,
  });

  // Convert JSON to Model
  factory UsageStatusModel.fromJson(Map<String, dynamic> json) {
    return UsageStatusModel(
      usageStatusID: json['usageStatusID'],
      usageStatusName: json['usageStatusName'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'usageStatusID': usageStatusID,
      'usageStatusName': usageStatusName,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<UsageStatusModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => UsageStatusModel.fromJson(json)).toList();
  }
}
