import 'dart:convert';

class NationModel {
  final int nationID;
  final String nationName;

  NationModel({
    required this.nationID,
    required this.nationName
  });

  // Convert JSON to Model
  factory NationModel.fromJson(Map<String, dynamic> json) {
    return NationModel(
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
  static List<NationModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => NationModel.fromJson(json)).toList();
  }
}


