class MedicalHistoryForm{
  String typeOfDisease;
  String yearOfDiagnosis;
  int medicalLevel;
  int treatmentMethod;
  String complications;
  String hospitalTreatment;
  String noteDisease;

  MedicalHistoryForm({
    required this.typeOfDisease,
    required this.yearOfDiagnosis,
    required this.medicalLevel,
    required this.treatmentMethod,
    required this.complications,
    required this.hospitalTreatment,
    required this.noteDisease,

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

    };
  }
}
