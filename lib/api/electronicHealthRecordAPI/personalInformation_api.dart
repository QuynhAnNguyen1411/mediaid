import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mediaid/models/electronicHealthRecordModel/personalInformation/personalInformationForm.dart';

class PersonalInformationApi {
  // Get thông tin bệnh nhân theo ID
  static Future<PersonalInformationForm?> getPatientData(String id) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8080/layThongTinSoKham?accountID=$id'));
    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);
        print(data);
        PersonalInformationForm personalInformation = PersonalInformationForm(
            examinationBookID: data['examinationBookID'],
            patientName: data['patientName'],
            personalIdentifier: data['personalIdentifier'],
            healthInsurance: data['healthInsurance'],
            addressPatient: data['addressPatient'],
            phoneNumber: data['phoneNumber'],
            emailPatient: data['emailPatient'],
            dob: data['dob'],
            sexPatient: data['sexPatient'],
            nationPatient: data['nationPatient'],
            patientFamilyName: data['patientFamilyName'],
            patientFamilyIdentifier: data['patientFamilyIdentifier'],
            patientRelationship: data['patientRelationship'],
            patientFamilyPhoneNumber: data['patientFamilyPhoneNumber']);
        print("getPatientData load data" );
        return personalInformation;
      } catch (e) {
        throw Exception('❌ getPatientData Lỗi xử lý JSON: $e');
      }
    } else {
      print('❌ getPatientData API thất bại, mã lỗi: ${response.statusCode}');
      return null;
    }
  }

  static Future<void> submitUpdateForm(PersonalInformationForm form) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/capNhatThongTinCaNhan'), // Địa chỉ API của bạn
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(form.toJson()), // Chuyển model thành JSON
    );

    if (response.statusCode == 200) {
      // Xử lý khi gửi thành công
      print('Dữ liệu đã được gửi thành công!');
    } else {
      // Xử lý khi có lỗi
      print('Gửi dữ liệu thất bại, mã lỗi: ${response.statusCode}');
    }
  }

}
