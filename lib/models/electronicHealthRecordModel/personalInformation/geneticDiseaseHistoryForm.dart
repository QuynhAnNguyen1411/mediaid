class GeneticDiseaseHistoryForm{
  String? geneticDiseaseHistoryID;
  String accountID;
  String geneticDisease;
  String relationshipFM;
  String yearOfDiseaseFM;
  int medicalLevelFM;
  String noteDiseaseFM;

  GeneticDiseaseHistoryForm({
    this.geneticDiseaseHistoryID,
    required this.accountID,
    required this.geneticDisease,
    required this.relationshipFM,
    required this.yearOfDiseaseFM,
    required this.medicalLevelFM,
    required this.noteDiseaseFM,
  });

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'geneticDiseaseHistoryID': geneticDiseaseHistoryID,
      'accountID': accountID,
      'geneticDisease': geneticDisease,
      'relationshipFM': relationshipFM,
      'yearOfDiseaseFM': yearOfDiseaseFM,
      'medicalLevelFM': medicalLevelFM,
      'noteDiseaseFM': noteDiseaseFM,
    };
  }
  // Phương thức chuyển JSON -> Object
  factory GeneticDiseaseHistoryForm.fromJson(Map<String, dynamic> json) {
    return GeneticDiseaseHistoryForm(
      geneticDiseaseHistoryID: json['geneticDiseaseHistoryID'],
      accountID: json['accountID'],
      geneticDisease: json['geneticDisease'],
      relationshipFM: json['relationshipFM'],
      yearOfDiseaseFM: json['yearOfDiseaseFM'],
      medicalLevelFM: json['medicalLevelFM'],
      noteDiseaseFM: json['noteDiseaseFM'],
    );
  }
}
