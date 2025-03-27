class AllergyHistoryForm{
  String allergicAgents;
  String allergySymptoms;
  int allergyLevel;
  String lastHappened;
  String noteAllergy;


  AllergyHistoryForm({
    required this.allergicAgents,
    required this.allergySymptoms,
    required this.allergyLevel,
    required this.lastHappened,
    required this.noteAllergy,

  });

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'allergicAgents': allergicAgents,
      'allergySymptoms': allergySymptoms,
      'allergyLevel': allergyLevel,
      'lastHappened': lastHappened,
      'noteAllergy': noteAllergy,
    };
  }
}
