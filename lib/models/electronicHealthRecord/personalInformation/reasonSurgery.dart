import 'dart:convert';

class ReasonSurgery {
  final int? reasonSurgeryID;
  final String reasonSurgeryName;

  ReasonSurgery({
    required this.reasonSurgeryID,
    required this.reasonSurgeryName,
  });

  // Convert JSON to Model
  factory ReasonSurgery.fromJson(Map<String, dynamic> json) {
    return ReasonSurgery(
      reasonSurgeryID: json['reasonSurgeryID'],
      reasonSurgeryName: json['reasonSurgeryName'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'reasonSurgeryID': reasonSurgeryID,
      'reasonSurgeryName': reasonSurgeryName,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<ReasonSurgery> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => ReasonSurgery.fromJson(json)).toList();
  }
}
