import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mediaid/models/electronicHealthRecord/personalInformation/personalInformation.dart';

class PersonalInformationApi {
  // Lấy thông tin bệnh nhân theo ID
  static Future<PersonalInformationModel?> getPatientData(String id) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/layThongTinSoKham?accountID=$id'));
    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);
        print(data);

        PersonalInformationModel personalInformation = PersonalInformationModel(
            examinationBookID:data['soKhamID'],
            patientName:data['accountName'],
            personalIdentifier:data['cmndCmt'],
            healthInsurance:data['bhyt'],
            phoneNumber:data['sdt']);
        return personalInformation;
      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
      }
    } else {
      print('❌ API thất bại, mã lỗi: ${response.statusCode}');
      return null;
    }
  }
  // // Cập nhật thông tin bệnh nhân
  // static Future<Map<String, dynamic>> updatePatientData(String id, Map<String, dynamic> patientData) async {
  //   final response = await http.put(
  //     Uri.parse(''),
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode(patientData),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body); // Trả về dữ liệu đã cập nhật
  //   } else {
  //     throw Exception('Failed to update patient data');
  //   }
  // }

}
