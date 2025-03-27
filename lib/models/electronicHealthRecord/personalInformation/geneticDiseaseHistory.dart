class GeneticDiseaseHistoryForm{
  String geneticDisease;
  String relationshipFM;
  String yearOfDiseaseFM;
  int medicalLevelFM;
  String noteDiseaseFM;

  GeneticDiseaseHistoryForm({
    required this.geneticDisease,
    required this.relationshipFM,
    required this.yearOfDiseaseFM,
    required this.medicalLevelFM,
    required this.noteDiseaseFM,
  });

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'geneticDisease': geneticDisease,
      'relationshipFM': relationshipFM,
      'yearOfDiseaseFM': yearOfDiseaseFM,
      'medicalLevelFM': medicalLevelFM,
      'noteDiseaseFM': noteDiseaseFM,
    };
  }
}
