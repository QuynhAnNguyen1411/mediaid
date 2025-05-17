import 'package:uuid/uuid.dart';

class MedicalHistoryForm {
  String? medicalHistoryID;
  String accountID;
  String typeOfDisease;
  String yearOfDiagnosis;
  int medicalLevel;
  int treatmentMethod;
  String complications;
  String hospitalTreatment;
  String noteDisease;

  MedicalHistoryForm({
    this.medicalHistoryID,
    required this.accountID,
    required this.typeOfDisease,
    required this.yearOfDiagnosis,
    required this.medicalLevel,
    required this.treatmentMethod,
    required this.complications,
    required this.hospitalTreatment,
    required this.noteDisease,
  }) ;

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'medicalHistoryID': medicalHistoryID,
      'accountID': accountID,
      'typeOfDisease': typeOfDisease,
      'yearOfDiagnosis': yearOfDiagnosis,
      'medicalLevel': medicalLevel,
      'treatmentMethod': treatmentMethod,
      'complications': complications,
      'hospitalTreatment': hospitalTreatment,
      'noteDisease': noteDisease,
    };
  }

  // Phương thức chuyển JSON -> Object
  factory MedicalHistoryForm.fromJson(Map<String, dynamic> json) {
    return MedicalHistoryForm(
      medicalHistoryID: json['medicalHistoryID'],
      accountID: json['accountID'],
      typeOfDisease: json['typeOfDisease'],
      yearOfDiagnosis: json['yearOfDiagnosis'],
      medicalLevel: json['medicalLevel'],
      treatmentMethod: json['treatmentMethod'],
      complications: json['complications'],
      hospitalTreatment: json['hospitalTreatment'],
      noteDisease: json['noteDisease'],
    );
  }
}
