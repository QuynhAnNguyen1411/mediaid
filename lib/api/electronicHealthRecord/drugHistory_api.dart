// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:mediaid/models/electronicHealthRecord/personalInformation/allergyHistory.dart';
// import 'package:mediaid/models/electronicHealthRecord/personalInformation/geneticDiseaseHistory.dart';
// import 'package:mediaid/models/electronicHealthRecord/personalInformation/level.dart';
// import 'package:mediaid/models/electronicHealthRecord/personalInformation/medicalHistory.dart';
// import 'package:mediaid/models/electronicHealthRecord/personalInformation/surgeryHistory.dart';
//
// import '../../models/electronicHealthRecord/personalInformation/reasonSurgery.dart';
// import '../../models/electronicHealthRecord/personalInformation/treatmentMethod.dart';
// import '../../models/electronicHealthRecord/personalInformation/workingEnvironment.dart';
//
// class DrugHistoryApi {
//
//   static Future<Map<String, List<Object>>?> getStaticDataForDrugHistory() async {
//     final response = await http.get(
//         Uri.parse('http://10.0.2.2:8080/api/static/staticDataForTieuSuYTe'));
//
//     if (response.statusCode == 200) {
//       try {
//         String responseBody = utf8.decode(response.bodyBytes);
//         Map<String, dynamic> data = jsonDecode(responseBody);
//         print(data);
//
//         List<Level> tinhTrangSuDungList = [];
//         if (data['mucDoDTO'] != null && data['mucDoDTO'] is List) {
//           for (var e in (data['mucDoDTO'] as List)) {
//             Level level = Level(levelID: e['id'], levelName: e['ten']);
//             tinhTrangSuDungList.add(level);
//           }
//         }
//
//         List<ReasonSurgery> lyDoPhauThuatList = [];
//         if (data['lyDoPhauThuatDTO'] != null &&
//             data['lyDoPhauThuatDTO'] is List) {
//           for (var e in (data['lyDoPhauThuatDTO'] as List)) {
//             ReasonSurgery reasonSurgery = ReasonSurgery(
//                 reasonSurgeryID: e['id'], reasonSurgeryName: e['ten']);
//             lyDoPhauThuatList.add(reasonSurgery);
//           }
//         }
//
//         List<TreatmentMethod> phuongPhapDieuTriList = [];
//         if (data['phuongPhapDieuTriDTO'] != null &&
//             data['phuongPhapDieuTriDTO'] is List) {
//           for (var e in (data['phuongPhapDieuTriDTO'] as List)) {
//             TreatmentMethod treatmentMethod = TreatmentMethod(
//                 treatmentMethodID: e['id'], treatmentMethodName: e['ten']);
//             phuongPhapDieuTriList.add(treatmentMethod);
//           }
//         }
//
//         print(mucDoList.length +
//             lyDoPhauThuatList.length +
//             phuongPhapDieuTriList.length);
//         return {
//           "mucDo": mucDoList,
//           "lyDoPhauThuat": lyDoPhauThuatList,
//           "phuongPhapDieuTri": phuongPhapDieuTriList
//         };
//       } catch (e) {
//         throw Exception('❌ Lỗi xử lý JSON: $e');
//         return null;
//       }
//     } else {
//       print('❌ API thất bại, mã lỗi: ${response.statusCode}');
//     }
//     return null;
//   }
//
//   // Môi trường làm việc - Khảo sát lối sống
//   static Future<Map<String, List<Object>>?> getStaticDataForLifestyleSurvey() async {
//     final response = await http.get(
//         Uri.parse('http://10.0.2.2:8080/api/static/staticDataForTieuSuYTe'));
//     if (response.statusCode == 200) {
//       try {
//         String responseBody = utf8.decode(response.bodyBytes);
//         Map<String, dynamic> data = jsonDecode(responseBody);
//         print(data);
//
//         List<WorkingEnvironment> moiTruongLamViecList = [];
//         if (data['moiTruongLamViecDTO'] != null && data['moiTruongLamViecDTO'] is List) {
//           for (var e in (data['moiTruongLamViecDTO'] as List)) {
//             WorkingEnvironment workingEnvironment = WorkingEnvironment(workingEnvironmentID: e['id'], workingEnvironmentName: e['ten']);
//             moiTruongLamViecList.add(workingEnvironment);
//           }
//         }
//
//         print(moiTruongLamViecList.length);
//         return {"moiTruongLamViec": moiTruongLamViecList};
//       } catch (e) {
//         throw Exception('❌ Lỗi xử lý JSON: $e');
//         return null;
//       }
//     } else {
//       print('❌ API thất bại, mã lỗi: ${response.statusCode}');
//     }
//     return null;
//   }
//
//   // Gửi cả form Tiểu sử bệnh tật đang mắc phải
//   static Future<void> submitFormMedicalHistory(
//       MedicalHistoryForm form) async {
//     final response = await http.post(
//       Uri.parse('http://10.0.2.2:8080/capNhatTieuSuBenhTat'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(form.toJson()), // Chuyển model thành JSON
//     );
//
//     if (response.statusCode == 200) {
//       // Xử lý khi gửi thành công
//       print('Dữ liệu đã được gửi thành công!');
//     } else {
//       // Xử lý khi có lỗi
//       print('Gửi dữ liệu thất bại, mã lỗi: ${response.statusCode}');
//     }
//   }
//
//   // Gửi cả form Tiểu sử bệnh di truyền đang mắc phải
//   static Future<void> submitFormGeneticDiseaseHistory(
//       GeneticDiseaseHistoryForm form) async {
//     final response = await http.post(
//       Uri.parse('http://10.0.2.2:8080/capNhatTieuSuBenhTat'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(form.toJson()), // Chuyển model thành JSON
//     );
//
//     if (response.statusCode == 200) {
//       // Xử lý khi gửi thành công
//       print('Dữ liệu đã được gửi thành công!');
//     } else {
//       // Xử lý khi có lỗi
//       print('Gửi dữ liệu thất bại, mã lỗi: ${response.statusCode}');
//     }
//   }
//
//   // Gửi cả form Tiểu sử dị ứng
//   static Future<void> submitFormAllergyHistory(
//       AllergyHistoryForm form) async {
//     final response = await http.post(
//       Uri.parse('http://10.0.2.2:8080/capNhatTieuSuBenhTat'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(form.toJson()), // Chuyển model thành JSON
//     );
//
//     if (response.statusCode == 200) {
//       // Xử lý khi gửi thành công
//       print('Dữ liệu đã được gửi thành công!');
//     } else {
//       // Xử lý khi có lỗi
//       print('Gửi dữ liệu thất bại, mã lỗi: ${response.statusCode}');
//     }
//   }
//   // Gửi cả form Tiểu sử phẫu thuật
//   static Future<void> submitFormSurgeryHistory(
//       SurgeryHistoryForm form) async {
//     final response = await http.post(
//       Uri.parse('http://10.0.2.2:8080/capNhatTieuSuBenhTat'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(form.toJson()), // Chuyển model thành JSON
//     );
//
//     if (response.statusCode == 200) {
//       // Xử lý khi gửi thành công
//       print('Dữ liệu đã được gửi thành công!');
//     } else {
//       // Xử lý khi có lỗi
//       print('Gửi dữ liệu thất bại, mã lỗi: ${response.statusCode}');
//     }
//   }
// }
