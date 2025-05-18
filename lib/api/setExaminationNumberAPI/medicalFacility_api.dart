import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mediaid/models/setExamNumberModel/medicalFacilityModel.dart';

class MedicalFacilityApi {
  static Future<List<MedicalFacilityModel>> getStaticDataForMedicalFacility() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/layCoSoKhamBenh'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        List<dynamic> dataList = jsonDecode(responseBody);
        print(dataList);

        return dataList.map((json) => MedicalFacilityModel(
            medicalFacilityID: json['coSoID'],
            medicalFacilityName: json['ten'],
            medicalFacilityAddress: json['diaChi'],
        )).toList();

      } catch (e) {
        throw Exception('❌ getStaticDataForMedicalFacility Lỗi xử lý JSON: $e');
      }
    } else {
      throw ('❌ getStaticDataForMedicalFacility API thất bại, mã lỗi: ${response.statusCode}');
    }
  }


  // static Future<void> submitModelMedicalFacility(int selectedMedicalFacilityID) async {
  //   final response = await http.post(
  //     Uri.parse('http://10.0.2.2:8080/capNhatTieuSuBenhTat'),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: json.encode({'selectedMedicalFacilityID': selectedMedicalFacilityID}),
  //   );
  //   if (response.statusCode == 200) {
  //     // Xử lý khi gửi thành công
  //     print('Dữ liệu đã được gửi thành công!');
  //   } else {
  //     // Xử lý khi có lỗi
  //     print('Gửi dữ liệu thất bại, mã lỗi: ${response.statusCode}');
  //   }
  // }
}
