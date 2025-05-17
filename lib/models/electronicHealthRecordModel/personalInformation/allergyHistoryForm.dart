class AllergyHistoryForm{
  String? allergyHistoryID;
  String accountID;
  String allergicAgents;
  String allergySymptoms;
  int allergyLevel;
  String lastHappened;
  String noteAllergy;


  AllergyHistoryForm({
    this.allergyHistoryID,
    required this.accountID,
    required this.allergicAgents,
    required this.allergySymptoms,
    required this.allergyLevel,
    required this.lastHappened,
    required this.noteAllergy,

  });

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'allergyHistoryID': allergyHistoryID,
      'accountID': accountID,
      'allergicAgents': allergicAgents,
      'allergySymptoms': allergySymptoms,
      'allergyLevel': allergyLevel,
      'lastHappened': lastHappened,
      'noteAllergy': noteAllergy,
    };
  }

  // Phương thức chuyển JSON -> Object
  factory AllergyHistoryForm.fromJson(Map<String, dynamic> json) {
    return AllergyHistoryForm(
      allergyHistoryID: json['allergyHistoryID'],
      accountID: json['accountID'],
      allergicAgents: json['allergicAgents'],
      allergySymptoms: json['allergySymptoms'],
      allergyLevel: json['allergyLevel'],
      lastHappened: json['lastHappened'],
      noteAllergy: json['noteAllergy'],
    );
  }
}
