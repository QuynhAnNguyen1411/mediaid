import 'dart:convert';

class UsageStatus {
  final int? usageStatusID;
  final String usageStatusName;

  UsageStatus({
    required this.usageStatusID,
    required this.usageStatusName,
  });

  // Convert JSON to Model
  factory UsageStatus.fromJson(Map<String, dynamic> json) {
    return UsageStatus(
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
  static List<UsageStatus> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => UsageStatus.fromJson(json)).toList();
  }
}
