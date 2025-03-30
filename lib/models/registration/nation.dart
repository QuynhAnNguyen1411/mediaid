import 'dart:convert';

class Nation {
  final int nationID;
  final String nationName;

  Nation({
    required this.nationID,
    required this.nationName
  });

  // Convert JSON to Model
  factory Nation.fromJson(Map<String, dynamic> json) {
    return Nation(
      nationID: json['nationID'],
      nationName: json['nationName'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'nationID': nationID,
      'nationName': nationName,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<Nation> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Nation.fromJson(json)).toList();
  }
}


