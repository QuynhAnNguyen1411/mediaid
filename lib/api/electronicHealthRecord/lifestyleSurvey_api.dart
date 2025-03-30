import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/electronicHealthRecord/personalInformation/workingEnvironment.dart';

class LifestyleSurveyApi {
  // Môi trường làm việc - Khảo sát lối sống
  static Future<Map<String, List<Object>>?> getStaticDataForLifestyleSurvey() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/static/staticDataForTieuSuYTe'));
    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);
        print(data);

        List<WorkingEnvironment> moiTruongLamViecList = [];
        if (data['moiTruongLamViecDTO'] != null && data['moiTruongLamViecDTO'] is List) {
          for (var e in (data['moiTruongLamViecDTO'] as List)) {
            WorkingEnvironment workingEnvironment = WorkingEnvironment(workingEnvironmentID: e['id'], workingEnvironmentName: e['ten']);
            moiTruongLamViecList.add(workingEnvironment);
          }
        }

        print(moiTruongLamViecList.length);
        return {"moiTruongLamViec": moiTruongLamViecList};
      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
        return null;
      }
    } else {
      print('❌ API thất bại, mã lỗi: ${response.statusCode}');
    }
    return null;
  }

}
