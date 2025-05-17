import 'dart:convert';

class LevelModel {
  final int? levelID;
  final String levelName;

  LevelModel({
    required this.levelID,
    required this.levelName,
  });

  // Convert JSON to Model
  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      levelID: json['levelID'],
      levelName: json['levelName'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'levelID': levelID,
      'levelName': levelName,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<LevelModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => LevelModel.fromJson(json)).toList();
  }
}
