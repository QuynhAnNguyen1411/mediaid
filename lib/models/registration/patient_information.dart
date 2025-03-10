// class PatientInformation {
//   String personalIdentifier;
//   String healthInsurance;
//   String patientName;
//   String addressPatient;
//   String phoneNumber;
//   String emailPatient;
//   String dob;
//   String sexPatient;
//   String patientFamilyName;
//   String patientRelationship;
//   String patientFamilyIdentifier;
//   String patientFamilyPhoneNumber;
//
//   PatientInformation({
//     required this.personalIdentifier,
//     required this.healthInsurance,
//     required this.patientName,
//     required this.addressPatient,
//     required this.phoneNumber,
//     required this.emailPatient,
//     required this.dob,
//     required this.sexPatient,
//     required this.patientFamilyName,
//     required this.patientRelationship,
//     required this.patientFamilyIdentifier,
//     required this.patientFamilyPhoneNumber,
//   });
//
//   // Phương thức từ JSON -> Object
//   factory PatientInformation.fromJson(Map<String, dynamic> json) {
//     return PatientInformation(
//       personalIdentifier: json['personalIdentifier'],
//       healthInsurance: json['healthInsurance'],
//       patientName: json['patientName'],
//       addressPatient: json['addressPatient'],
//       phoneNumber: json['phoneNumber'],
//       emailPatient: json['emailPatient'],
//       dob: json['dob'],
//       sexPatient: json['sexPatient'],
//       patientFamilyName: json['patientFamilyName'],
//       patientRelationship: json['patientRelationship'],
//       patientFamilyIdentifier: json['patientFamilyIdentifier'],
//       patientFamilyPhoneNumber: json['patientFamilyPhoneNumber'],
//     );
//   }
//
//   // Phương thức chuyển Object -> JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'personalIdentifier': personalIdentifier,
//       'healthInsurance': healthInsurance,
//       'patientName': patientName,
//       'addressPatient': addressPatient,
//       'phoneNumber': phoneNumber,
//       'emailPatient': emailPatient,
//       'dob': dob,
//       'sexPatient': sexPatient,
//       'patientFamilyName': patientFamilyName,
//       'patientRelationship': patientRelationship,
//       'patientFamilyIdentifier': patientFamilyIdentifier,
//       'patientFamilyPhoneNumber': patientFamilyPhoneNumber,
//     };
//   }
// }
