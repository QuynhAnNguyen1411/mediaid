import 'dart:convert';

class Level {
  final int? levelID;
  final String levelName;

  Level({
    required this.levelID,
    required this.levelName,
  });

  // Convert JSON to Model
  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
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
  static List<Level> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Level.fromJson(json)).toList();
  }
}
