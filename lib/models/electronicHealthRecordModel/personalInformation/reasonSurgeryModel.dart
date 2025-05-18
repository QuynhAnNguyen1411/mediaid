import 'dart:convert';

class ReasonSurgeryModel {
  final int? reasonSurgeryID;
  final String reasonSurgeryName;

  ReasonSurgeryModel({
    required this.reasonSurgeryID,
    required this.reasonSurgeryName,
  });

  // Convert JSON to Model
  factory ReasonSurgeryModel.fromJson(Map<String, dynamic> json) {
    return ReasonSurgeryModel(
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
  static List<ReasonSurgeryModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => ReasonSurgeryModel.fromJson(json)).toList();
  }
}
