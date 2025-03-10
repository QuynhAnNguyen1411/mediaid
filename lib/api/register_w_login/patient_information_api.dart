// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../config.dart';
// import '../../models/registration/patient_information.dart';
// import 'patient_information_api.dart';
// class PatientInformationApi {
//   // Phương thức để lấy thông tin bệnh nhân
//   Future<PatientInformation?> fetchPatientInfo(String personalIdentifier) async {
//     final response = await http.get(Uri.parse('${AppConfig.baseUrl}/$personalIdentifier'));
//
//     if (response.statusCode == 200) {
//       // Nếu thành công, trả về dữ liệu dưới dạng model PatientInformation
//       return PatientInformation.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load patient info');
//     }
//   }
//
//   // Phương thức để cập nhật thông tin bệnh nhân
//   Future<PatientInformation?> updatePatientInfo(String personalIdentifier, PatientInformation patient) async {
//     final response = await http.put(
//       Uri.parse('${AppConfig.baseUrl}/$personalIdentifier'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(patient.toJson()),
//     );
//
//     if (response.statusCode == 200) {
//       // Nếu cập nhật thành công, trả về thông tin bệnh nhân đã cập nhật
//       return PatientInformation.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to update patient info');
//     }
//   }
// }
//
