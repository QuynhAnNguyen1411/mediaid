import 'dart:convert';

class Gender {
  final int? genderID;
  final String genderName;

  Gender({
    required this.genderID,
    required this.genderName,
  });

  // Convert JSON to Model
  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      genderID: json['genderID'],
      genderName: json['genderName'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'genderID': genderID,
      'genderName': genderName,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<Gender> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Gender.fromJson(json)).toList();
  }
}
