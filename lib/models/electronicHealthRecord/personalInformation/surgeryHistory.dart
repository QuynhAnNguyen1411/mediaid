class SurgeryHistoryForm{
  String nameSurgery;
  int reasonSurgery;
  int surgeryLevel;
  String timeSurgery;
  String surgicalHospital;
  String complicationSurgery;
  String noteSurgery;


  SurgeryHistoryForm({
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
