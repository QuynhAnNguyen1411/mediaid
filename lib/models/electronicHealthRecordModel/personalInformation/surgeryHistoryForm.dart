class SurgeryHistoryForm{
  String? surgeryHistoryID;
  String accountID;
  String nameSurgery;
  int reasonSurgery;
  int surgeryLevel;
  String timeSurgery;
  String surgicalHospital;
  String complicationSurgery;
  String noteSurgery;


  SurgeryHistoryForm({
    this.surgeryHistoryID,
    required this.accountID,
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
      'surgeryHistoryID': surgeryHistoryID,
      'accountID': accountID,
      'nameSurgery': nameSurgery,
      'reasonSurgery': reasonSurgery,
      'surgeryLevel': surgeryLevel,
      'timeSurgery': timeSurgery,
      'surgicalHospital': surgicalHospital,
      'complicationSurgery': complicationSurgery,
      'noteSurgery': noteSurgery,
    };
  }

  // Phương thức chuyển JSON -> Object
  factory SurgeryHistoryForm.fromJson(Map<String, dynamic> json) {
    return SurgeryHistoryForm(
      surgeryHistoryID: json['surgeryHistoryID'],
      accountID: json['accountID'],
      nameSurgery: json['nameSurgery'],
      reasonSurgery: json['reasonSurgery'],
      surgeryLevel: json['surgeryLevel'],
      timeSurgery: json['timeSurgery'],
      surgicalHospital: json['surgicalHospital'],
      complicationSurgery: json['complicationSurgery'],
      noteSurgery: json['noteSurgery'],
    );
  }
}
