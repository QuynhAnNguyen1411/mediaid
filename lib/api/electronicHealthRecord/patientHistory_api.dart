import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mediaid/models/electronicHealthRecord/personalInformation/level.dart';

import '../../models/electronicHealthRecord/personalInformation/reasonSurgery.dart';
import '../../models/electronicHealthRecord/personalInformation/treatmentMethod.dart';

class PatientHistoryApi {
  // Phương pháp điều trị - Tiểu sử bệnh tật
  // Mức độ - Tiền sử bệnh tật, dị ứng và phẫu thuật
  // Lý do phẫu thuật - Tiền sử phẫu thuật
  static Future<Map<String, List<Object>>?> getStaticDataForPatientHistory() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/static/staticDataForTieuSuYTe'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);
        print(data);

        List<Level> mucDoList = [];
        if (data['mucDoDTO'] != null && data['mucDoDTO'] is List) {
          for (var e in (data['mucDoDTO'] as List)) {
            Level level = Level(levelID: e['id'], levelName: e['ten']);
            mucDoList.add(level);
          }
        }

        List<ReasonSurgery> lyDoPhauThuatList = [];
        if (data['lyDoPhauThuatDTO'] != null && data['lyDoPhauThuatDTO'] is List) {
          for (var e in (data['lyDoPhauThuatDTO'] as List)) {
            ReasonSurgery reasonSurgery = ReasonSurgery(reasonSurgeryID: e['id'], reasonSurgeryName: e['ten']);
            lyDoPhauThuatList.add(reasonSurgery);
          }
        }

        List<TreatmentMethod> phuongPhapDieuTriList = [];
        if (data['phuongPhapDieuTriDTO'] != null && data['phuongPhapDieuTriDTO'] is List) {
          for (var e in (data['phuongPhapDieuTriDTO'] as List)) {
            TreatmentMethod treatmentMethod = TreatmentMethod(treatmentMethodID: e['id'], treatmentMethodName: e['ten']);
            phuongPhapDieuTriList.add(treatmentMethod);
          }
        }

        print(mucDoList.length+lyDoPhauThuatList.length+phuongPhapDieuTriList.length);
        return {"mucDo": mucDoList, "lyDoPhauThuat": lyDoPhauThuatList, "phuongPhapDieuTri":phuongPhapDieuTriList};

      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
        return null;
      }
    } else {
      print('❌ API thất bại, mã lỗi: ${response.statusCode}');
    }
  }
}