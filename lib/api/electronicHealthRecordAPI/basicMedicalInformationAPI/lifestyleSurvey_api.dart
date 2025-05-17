import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mediaid/models/electronicHealthRecordModel/personalInformation/habitPatientModel.dart';
import 'package:mediaid/models/electronicHealthRecordModel/personalInformation/workingEnvironmentModel.dart';

import '../../../models/electronicHealthRecordModel/personalInformation/lifestyleSurveyForm.dart';

class LifestyleSurveyApi {
  // Môi trường làm việc - Khảo sát lối sống
  static Future<Map<String, List<Object>>?>
      getStaticDataForLifestyleSurvey() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8080/api/static/staticDataForTieuSuLoiSong'));
    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);
        print(data);

        List<HabitPatientModel> thoiQuenList = [];
        if (data['thoiQuenDTOS'] != null && data['thoiQuenDTOS'] is List) {
          for (var e in (data['thoiQuenDTOS'] as List)) {
            HabitPatientModel habitPatient = HabitPatientModel(
                habitPatientID: e['id'], habitPatientName: e['ten']);
            thoiQuenList.add(habitPatient);
          }
        }

        List<WorkingEnvironmentModel> moiTruongLamViecList = [];
        if (data['moiTruongDTOS'] != null && data['moiTruongDTOS'] is List) {
          for (var e in (data['moiTruongDTOS'] as List)) {
            WorkingEnvironmentModel workingEnvironment =
                WorkingEnvironmentModel(
                    workingEnvironmentID: e['id'],
                    workingEnvironmentName: e['ten']);
            moiTruongLamViecList.add(workingEnvironment);
          }
        }

        print(moiTruongLamViecList.length + thoiQuenList.length);
        return {
          "moiTruongLamViec": moiTruongLamViecList,
          "thoiQuen": thoiQuenList,
        };
      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
        return null;
      }
    } else {
      print('❌ API thất bại, mã lỗi: ${response.statusCode}');
    }
    return null;
  }

  static Future<void> submitFormLifestyleSurvey(
      LifestyleSurveyForm form) async {
    print("submitFormLifestyleSurvey");
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/capNhatTieuSuLoiSong'),
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

  static Future<LifestyleSurveyForm> getLifestyleSurveyData(String accountID) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/layTieuSuLoiSong?accountID=${accountID}'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        print(responseBody);
        Map<String, dynamic> dataList = jsonDecode(responseBody);

        LifestyleSurveyForm lifestyleSurveyForm = LifestyleSurveyForm(
          lifestyleSurveyID:
              dataList['loiSongNguoiBenhID'] ?? 'Không có thông tin',
          accountID: dataList['accountID'] ?? 'Không có thông tin',
          isCheckedList: (dataList['thoiQuenLoiSongs'] != null &&
                  dataList['thoiQuenLoiSongs'] is List)
              ? List<int>.from(dataList['thoiQuenLoiSongs']
                  .map((item) => int.tryParse(item.toString()) ?? 0))
              : List<int>.filled(6, 0),
          workingEnvironment:
              int.tryParse(dataList['moiTruongID']?.toString() ?? '0') ?? 0,
          noteLifestyleSurvey: dataList['ghiChu'] ?? '',
        );
        print("getLifestyleSurveyData");
        print(lifestyleSurveyForm.toJson());
        return lifestyleSurveyForm;
      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }
}
