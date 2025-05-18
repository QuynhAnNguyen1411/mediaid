import 'dart:convert';

class GenderModel {
  final int? genderID;
  final String genderName;

  GenderModel({
    required this.genderID,
    required this.genderName,
  });

  // Convert JSON to Model
  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return GenderModel(
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
  static List<GenderModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => GenderModel.fromJson(json)).toList();
  }
}
