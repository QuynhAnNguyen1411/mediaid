import 'dart:convert';

class TypeOfDrug {
  final int? typeOfDrugID;
  final String typeOfDrugName;

  TypeOfDrug({
    required this.typeOfDrugID,
    required this.typeOfDrugName,
  });

  // Convert JSON to Model
  factory TypeOfDrug.fromJson(Map<String, dynamic> json) {
    return TypeOfDrug(
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
  static List<TypeOfDrug> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => TypeOfDrug.fromJson(json)).toList();
  }
}
