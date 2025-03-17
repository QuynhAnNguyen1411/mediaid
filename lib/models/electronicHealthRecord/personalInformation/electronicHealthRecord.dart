class ElectronicHealthRecordForm {
  // Medical History
  String typeOfDisease;
  String yearOfDiagnosis;
  int medicalLevel;
  int treatmentMethod;
  String complications;
  String hospitalTreatment;
  String noteDisease;

  String geneticDisease;
  String relationshipFM;
  String yearOfDiseaseFM;
  int medicalLevelFM;
  String noteDiseaseFM;

  // Allergy History
  String allergicAgents;
  String allergySymptoms;
  int allergyLevel;
  String lastHappened;
  String noteAllergy;

  // Surgery History
  String nameSurgery;
  int reasonSurgery;
  int surgeryLevel;
  String timeSurgery;
  String surgicalHospital;
  String complicationSurgery;
  String noteSurgery;

  ElectronicHealthRecordForm({
    // Medical History
    required this.typeOfDisease,
    required this.yearOfDiagnosis,
    required this.medicalLevel,
    required this.treatmentMethod,
    required this.complications,
    required this.hospitalTreatment,
    required this.noteDisease,

    required this.geneticDisease,
    required this.relationshipFM,
    required this.yearOfDiseaseFM,
    required this.medicalLevelFM,
    required this.noteDiseaseFM,

    // Allergy History
    required this.allergicAgents,
    required this.allergySymptoms,
    required this.allergyLevel,
    required this.lastHappened,
    required this.noteAllergy,

    // Surgery History
    required this.nameSurgery,
    required this.reasonSurgery,
    required this.surgeryLevel,
    required this.timeSurgery,
    required this.surgicalHospital,
    required this.complicationSurgery,
    required this.noteSurgery,
  });

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'typeOfDisease': typeOfDisease,
      'yearOfDiagnosis': yearOfDiagnosis,
      'medicalLevel': medicalLevel,
      'treatmentMethod': treatmentMethod,
      'complications': complications,
      'hospitalTreatment': hospitalTreatment,
      'noteDisease': noteDisease,
      'geneticDisease': geneticDisease,
      'relationshipFM': relationshipFM,
      'yearOfDiseaseFM': yearOfDiseaseFM,
      'medicalLevelFM': medicalLevelFM,
      'noteDiseaseFM': noteDiseaseFM,
      'allergicAgents': allergicAgents,
      'allergySymptoms': allergySymptoms,
      'allergyLevel': allergyLevel,
      'lastHappened': lastHappened,
      'noteAllergy': noteAllergy,
      'nameSurgery': nameSurgery,
      'reasonSurgery': reasonSurgery,
      'surgeryLevel': surgeryLevel,
      'timeSurgery': timeSurgery,
      'surgicalHospital': surgicalHospital,
      'complicationSurgery': complicationSurgery,
      'noteSurgery': noteSurgery,
    };
  }
}