import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mediaid/models/electronicHealthRecordModel/personalInformation/reasonSurgeryModel.dart';

import '../../../models/electronicHealthRecordModel/personalInformation/allergyHistoryForm.dart';
import '../../../models/electronicHealthRecordModel/personalInformation/geneticDiseaseHistoryForm.dart';
import '../../../models/electronicHealthRecordModel/personalInformation/levelModel.dart';
import '../../../models/electronicHealthRecordModel/personalInformation/medicalHistoryForm.dart';
import '../../../models/electronicHealthRecordModel/personalInformation/surgeryHistoryForm.dart';
import '../../../models/electronicHealthRecordModel/personalInformation/treatmentMethodModel.dart';




class PatientHistoryApi {
  // Phương pháp điều trị - Tiểu sử bệnh tật
  // Mức độ - Tiền sử bệnh tật, dị ứng và phẫu thuật
  // Lý do phẫu thuật - Tiền sử phẫu thuật
  static Future<Map<String, List<Object>>?> getStaticDataForPatientHistory() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/static/staticDataForTieuSuYTe'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);
        // print(data);

        List<LevelModel> mucDoList = [];
        if (data['mucDoDTO'] != null && data['mucDoDTO'] is List) {
          for (var e in (data['mucDoDTO'] as List)) {
            LevelModel level = LevelModel(levelID: e['id'], levelName: e['ten']);
            mucDoList.add(level);
          }
        }

        List<ReasonSurgeryModel> lyDoPhauThuatList = [];
        if (data['lyDoPhauThuatDTO'] != null &&
            data['lyDoPhauThuatDTO'] is List) {
          for (var e in (data['lyDoPhauThuatDTO'] as List)) {
            ReasonSurgeryModel reasonSurgery = ReasonSurgeryModel(
                reasonSurgeryID: e['id'], reasonSurgeryName: e['ten']);
            lyDoPhauThuatList.add(reasonSurgery);
          }
        }

        List<TreatmentMethodModel> phuongPhapDieuTriList = [];
        if (data['phuongPhapDieuTriDTO'] != null &&
            data['phuongPhapDieuTriDTO'] is List) {
          for (var e in (data['phuongPhapDieuTriDTO'] as List)) {
            TreatmentMethodModel treatmentMethod = TreatmentMethodModel(
                treatmentMethodID: e['id'], treatmentMethodName: e['ten']);
            phuongPhapDieuTriList.add(treatmentMethod);
          }
        }

        print(mucDoList.length +
            lyDoPhauThuatList.length +
            phuongPhapDieuTriList.length);
        return {
          "mucDo": mucDoList,
          "lyDoPhauThuat": lyDoPhauThuatList,
          "phuongPhapDieuTri": phuongPhapDieuTriList
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

  // 1. Tiền sử bệnh tật
  // Gửi cả form Tiền sử bệnh tật đang mắc phải
  static Future<void> submitFormMedicalHistory(MedicalHistoryForm form) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/capNhatTieuSuBenhTat'),
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
  // Get Tiền sử bệnh tật from db
  static Future<List<MedicalHistoryForm>> getMedicalHistoryData(String accountID, String type) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/layDanhSachTieuSuPreview?accountID=${accountID}&type=${type}'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        print(responseBody);
        List<dynamic> dataList = jsonDecode(responseBody);

        List<MedicalHistoryForm> medicalHistoryList = [];
        for (var e in dataList) {
          MedicalHistoryForm medicalHistoryForm = MedicalHistoryForm(
            medicalHistoryID: e['medicalHistoryID'] ?? 'Không có thông tin',
            accountID: e['accountID'] ?? 'Không có thông tin',
            typeOfDisease: e['typeOfDisease'] ?? 'Không có thông tin',
            yearOfDiagnosis: e['yearOfDiagnosis'] ?? 'Không có thông tin',
            medicalLevel: int.tryParse(e['medicalLevel']?.toString() ?? '0') ?? 0,
            treatmentMethod: int.tryParse(e['treatmentMethod']?.toString() ?? '0') ?? 0,
            complications: e['complications'] ?? '',
            hospitalTreatment: e['hospitalTreatment'] ?? '',
            noteDisease: e['noteDisease'] ?? '',
          );
          medicalHistoryList.add(medicalHistoryForm);
        }

        print(medicalHistoryList.length);
        return medicalHistoryList;
      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }
  // Xóa form modal sheet Bệnh từng mắc phải hoặc đang điều trị
  static Future<void> deleteMedicalHistoryForm(String tieuSuYTeID, String type) async {
    final response = await http.delete(Uri.parse('http://10.0.2.2:8080/xoaTieuSuYTe?tieuSuYTeID=${tieuSuYTeID}&type=${type}'));

    try {
      if (response.statusCode == 200) {
        print("Xóa thành công!");
      } else {
        print("Lỗi khi xóa: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    }
    return null;
  }

  // 2. Tiền sử bệnh di truyền
  // Gửi cả form Tiền sử bệnh di truyền đang mắc phải
  static Future<void> submitFormGeneticDiseaseHistory(GeneticDiseaseHistoryForm form) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/capNhatTieuSuBenhDiTruyen'),
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
  // Get Tiền sử bệnh di truyền from db
  static Future<List<GeneticDiseaseHistoryForm>> getGeneticDiseaseHistoryData(String accountID, String type) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/layDanhSachTieuSuPreview?accountID=${accountID}&type=${type}'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        print(responseBody);
        List<dynamic> dataList = jsonDecode(responseBody);

        List<GeneticDiseaseHistoryForm> geneticDiseaseHistoryList = [];
        for (var e in dataList) {
          GeneticDiseaseHistoryForm geneticDiseaseHistoryForm = GeneticDiseaseHistoryForm(
            geneticDiseaseHistoryID: e['geneticDiseaseHistoryID'] ?? 'Không có thông tin',
            accountID: e['accountID'] ?? 'Không có thông tin',
            geneticDisease: e['geneticDisease'] ?? 'Không có thông tin',
            relationshipFM: e['relationshipFM'] ?? 'Không có thông tin',
            medicalLevelFM: int.tryParse(e['medicalLevelFM']?.toString() ?? '0') ?? 0,
            yearOfDiseaseFM: e['yearOfDiseaseFM'] ?? '',
            noteDiseaseFM: e['noteDiseaseFM'] ?? '',
          );
          geneticDiseaseHistoryList.add(geneticDiseaseHistoryForm);
        }

        print(geneticDiseaseHistoryList.length);
        return geneticDiseaseHistoryList;
      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }
  // Xóa form modal sheet Bệnh di truyền
  static Future<void> deleteGeneticDiseaseHistoryForm(String tieuSuYTeID, String type) async {
    final response = await http.delete(Uri.parse('http://10.0.2.2:8080/xoaTieuSuYTe?tieuSuYTeID=${tieuSuYTeID}&type=${type}'));

    try {
      if (response.statusCode == 200) {
        print("Xóa thành công!");
      } else {
        print("Lỗi khi xóa: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    }
    return null;
  }

  // 3. Tiền sử dị ứng
  // Gửi cả form Tiền sử dị ứng
  static Future<void> submitFormAllergyHistory(AllergyHistoryForm form) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/capNhatTieuSuDiUng'),
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
  // Get Tiền sử dị ứng from db
  static Future<List<AllergyHistoryForm>> getAllergyHistoryData(String accountID, String type) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/layDanhSachTieuSuPreview?accountID=${accountID}&type=${type}'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        print(responseBody);
        List<dynamic> dataList = jsonDecode(responseBody);

        List<AllergyHistoryForm> allergyHistoryList = [];
        for (var e in dataList) {
          AllergyHistoryForm allergyHistoryForm = AllergyHistoryForm(
            allergyHistoryID: e['allergyHistoryID'] ?? 'Không có thông tin',
            accountID: e['accountID'] ?? 'Không có thông tin',
            allergicAgents: e['allergicAgents'] ?? 'Không có thông tin',
            allergySymptoms: e['allergySymptoms'] ?? 'Không có thông tin',
            allergyLevel: int.tryParse(e['allergyLevel']?.toString() ?? '0') ?? 0,
            lastHappened: e['lastHappened'] ?? '',
            noteAllergy: e['noteAllergy'] ?? '',
          );
          allergyHistoryList.add(allergyHistoryForm);
        }

        print(allergyHistoryList.length);
        return allergyHistoryList;
      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }
  // Xóa form modal sheet dị ứng
  static Future<void> deleteAllergyHistoryForm(String tieuSuYTeID, String type) async {
    final response = await http.delete(Uri.parse('http://10.0.2.2:8080/xoaTieuSuYTe?tieuSuYTeID=${tieuSuYTeID}&type=${type}'));

    try {
      if (response.statusCode == 200) {
        print("Xóa thành công!");
      } else {
        print("Lỗi khi xóa: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    }
    return null;
  }

  // 4. Tiền sử phẫu thuật
  // Gửi cả form Tiền sử phẫu thuật
  static Future<void> submitFormSurgeryHistory(SurgeryHistoryForm form) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/capNhatTieuSuPhauThuat'),
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
  // Get Tiền sử phẫu thuật from db
  static Future<List<SurgeryHistoryForm>> getSurgeryHistoryData(String accountID, String type) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/layDanhSachTieuSuPreview?accountID=${accountID}&type=${type}'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        print(responseBody);
        List<dynamic> dataList = jsonDecode(responseBody);

        List<SurgeryHistoryForm> surgeryHistoryList = [];
        for (var e in dataList) {
          SurgeryHistoryForm surgeryHistoryForm = SurgeryHistoryForm(
            surgeryHistoryID: e['surgeryHistoryID'] ?? 'Không có thông tin',
            accountID: e['accountID'] ?? 'Không có thông tin',
            nameSurgery: e['nameSurgery'] ?? 'Không có thông tin',
            reasonSurgery: e['reasonSurgery'] ?? 'Không có thông tin',
            surgeryLevel: int.tryParse(e['allergyLevel']?.toString() ?? '0') ?? 0,
            timeSurgery: e['timeSurgery'] ?? '',
            surgicalHospital: e['surgicalHospital'] ?? '',
            complicationSurgery: e['complicationSurgery'] ?? '',
            noteSurgery: e['noteSurgery'] ?? '',
          );
          surgeryHistoryList.add(surgeryHistoryForm);
        }

        print(surgeryHistoryList.length);
        return surgeryHistoryList;
      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }
  // Xóa form modal sheet phẫu thuật
  static Future<void> deleteSurgeryHistoryForm(String tieuSuYTeID, String type) async {
    final response = await http.delete(Uri.parse('http://10.0.2.2:8080/xoaTieuSuYTe?tieuSuYTeID=${tieuSuYTeID}&type=${type}'));

    try {
      if (response.statusCode == 200) {
        print("Xóa thành công!");
      } else {
        print("Lỗi khi xóa: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
    }
    return null;
  }


}
