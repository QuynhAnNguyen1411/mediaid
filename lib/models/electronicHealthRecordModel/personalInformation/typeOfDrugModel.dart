import 'dart:convert';

class TypeOfDrugModel {
  final int typeOfDrugID;
  final String typeOfDrugName;

  TypeOfDrugModel({
    required this.typeOfDrugID,
    required this.typeOfDrugName,
  });

  // Convert JSON to Model
  factory TypeOfDrugModel.fromJson(Map<String, dynamic> json) {
    return TypeOfDrugModel(
      typeOfDrugID: json['typeOfDrugID'],
      typeOfDrugName: json['typeOfDrugName'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'typeOfDrugID': typeOfDrugID,
      'typeOfDrugName': typeOfDrugName,
    };
  }

  // Parse a list of JSON into a List of Nation objects
  static List<TypeOfDrugModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => TypeOfDrugModel.fromJson(json)).toList();
  }
}
