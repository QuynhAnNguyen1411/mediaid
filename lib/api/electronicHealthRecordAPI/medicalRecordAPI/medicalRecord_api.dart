import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mediaid/models/electronicHealthRecordModel/medicalRecordModel/detailedMedicationForm.dart';

import '../../../models/electronicHealthRecordModel/medicalRecordModel/detailedRecordForm.dart';
import '../../../models/electronicHealthRecordModel/medicalRecordModel/generalRecordForm.dart';
import '../../../util/commonUtil.dart';

class MedicalRecordApi {
  static Future<List<GeneralRecordForm>> getGeneralExaminationHistoryData(String examinationBookID) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8080/layDanhSachLichSuKham?soKhamID=$examinationBookID'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        List<dynamic> dataList = jsonDecode(responseBody);
        // print(dataList);
        print("aaaa");

        // Create a list of GeneralRecordCardForm containing a single item
        List<GeneralRecordForm> generalRecordCards = [];
        for (var e in dataList){
          GeneralRecordForm generalRecordForm = GeneralRecordForm(
            examHistoryID: e['lich_su_khamid'] ?? 'Không có thông tin',
            diseaseConclusion: e['ket_luan'] ?? 'Không có thông tin',
            conclusionTime: CommonUtil.stringToDateTime(e['ngay_kham']) ?? DateTime.now(),
            medicalFacility: e['coSo'] ?? '',
            doctorName: e['tenBacSi'] ?? '',
            statusLabel: e['trang_thai'] ?? '',
            detailedRecordList: [],
            detailedMedicationList: [],
          );
          generalRecordCards.add(generalRecordForm);
        }

        print(generalRecordCards);
        return generalRecordCards; // Return a list
      } catch (e) {
        throw Exception('❌ Lỗi xử lý getGeneralExaminationHistoryData JSON: $e');
      }
    } else {
      print('❌ getGeneralExaminationHistoryData API thất bại, mã lỗi: ${response.statusCode}');
      return []; // Return an empty list in case of an error
    }
  }

  static Future<GeneralRecordForm?> getDetailedExaminationHistoryData(String detailedRecordID) async {
    print(detailedRecordID);
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/layLichSuKham?lichSuKhamID=$detailedRecordID'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);
        print('Message: ');
        print(data);

        // Convert JSON to GeneralRecordForm object
        GeneralRecordForm generalRecordForm = GeneralRecordForm(
          examHistoryID: data['lich_su_khamid'] ?? 'Không có thông tin',
          diseaseConclusion: data['ket_luan'] ?? 'Không có thông tin',
          conclusionTime: CommonUtil.stringToDateTime(data['ngay_kham']) ?? DateTime.now(),
          medicalFacility: data['coSo'] ?? '',
          doctorName: data['tenBacSi'] ?? '',
          statusLabel: data['trang_thai'] ?? '',
          detailedRecordList: [],
          detailedMedicationList: []);

        List<DetailedRecordForm> detailedRecordList = [];
        for (var e in data['lichSuKhamChiTietDTOS']){
          DetailedRecordForm detailedRecordForm = DetailedRecordForm(
            detailedRecordID: e['lich_su_kham_chi_tietid'] ?? 'Không có thông tin',
            examinationType: e['loai_dich_vu'] ?? 'Không có thông tin',
            examinationName: e['ten_loai'] ?? 'Không có thông tin',
            examinationTime: CommonUtil.stringToDateTime(e['ngay_kham']) ?? DateTime.now(),
            clinicNumber: e['ma_phong_kham'] ?? '',
            examinationLocation: e['ten_co_so_kham'] ?? '',
            examinationNote: e['ghi_chu'] ?? '',
            testPhoto: e['anh_ket_qua'] ?? '',
            value: CommonUtil.convertStringToDouble(e['gia']) ?? 0.0,
          );
          detailedRecordList.add(detailedRecordForm);
        }
        generalRecordForm.detailedRecordList = detailedRecordList;

        List<DetailedMedicationForm> detailedMedicationList = [];
        for (var e in data['lichSuSuDungThuocDTOList']){
          DetailedMedicationForm detailedMedicationForm = DetailedMedicationForm(
            examHistoryID: e['lich_su_su_dung_thuocid'] ?? 'Không có thông tin',
            detailedMedicationID: e['lich_su_khamid'] ?? 'Không có thông tin',
            medicineName: e['ten_thuoc'] ?? 'Không có thông tin',
            instructions: e['huong_dan_su_dung'] ?? '',
            dosage: CommonUtil.convertStringToDouble(e['lieu_luong']) ?? 0.0,
            unit: e['don_vi'] ?? '',
          );
          detailedMedicationList.add(detailedMedicationForm);
        }
        generalRecordForm.detailedMedicationList = detailedMedicationList;
        print('A');
        print(generalRecordForm);
        return(generalRecordForm);
      } catch (e) {
        throw Exception('❌ Lỗi xử lý getGeneralExaminationHistoryData JSON: $e');
      }
    } else {
      print('❌ getDetailedExaminationHistoryData API thất bại, mã lỗi: ${response.statusCode}');
      return null;
    }
  }

  static Future<DetailedRecordForm?> getDetailedExaminationResultsData(String detailedRecordID) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8080/layLichSuKhamChiTiet?lichSuKhamChiTietID=$detailedRecordID'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);
        print(data);


        DetailedRecordForm detailedRecordForm = DetailedRecordForm(
          detailedRecordID: data['lich_su_kham_chi_tietid'] ?? 'Không có thông tin',
          examinationType: data['loai_dich_vu'] ?? 'Không có thông tin',
          examinationName: data['ten_loai'] ?? 'Không có thông tin',
          examinationTime: CommonUtil.stringToDateTime(data['ngay_kham']) ?? DateTime.now(),
          clinicNumber: data['ma_phong_kham'] ?? '',
          examinationLocation: data['ten_co_so_kham'] ?? '',
          examinationNote: data['ghi_chu'] ?? '',
          testPhoto: data['anh_ket_qua'] ?? '',
          value: CommonUtil.convertStringToDouble(data['gia']) ?? 0.0,
        );

        print(detailedRecordForm);
        return detailedRecordForm; // Return a list
      } catch (e) {
        throw Exception('❌ Lỗi xử lý getDetailedExaminationResultsData JSON: $e');
      }
    } else {
      print('❌ getDetailedExaminationResultsData API thất bại, mã lỗi: ${response.statusCode}');
      return null; // Return an empty list in case of an error
    }
  }
}
