import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mediaid/models/electronicHealthRecordModel/personalInformation/typeOfDrugModel.dart';
import 'package:mediaid/models/electronicHealthRecordModel/personalInformation/usageStatusModel.dart';

import '../../../models/electronicHealthRecordModel/personalInformation/drugsHistoryForm.dart';



class DrugHistoryApi {
  // Tình trạng sử dụng - Tiền sử sử dụng thuốc
  static Future<Map<String, List<Object>>?> getStaticDataForDrugHistory() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/static/staticDataForTieuSuThuoc'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);
        // print(data);

        List<UsageStatusModel> tinhTrangSuDungList = [];
        if (data['tinhTrangSuDungDTOS'] != null && data['tinhTrangSuDungDTOS'] is List) {
          for (var e in (data['tinhTrangSuDungDTOS'] as List)) {
            UsageStatusModel usageStatus = UsageStatusModel(usageStatusID: e['id'], usageStatusName: e['ten']);
            tinhTrangSuDungList.add(usageStatus);
          }
        }

        List<TypeOfDrugModel> loaiSanPhamList = [];
        if (data['loaiSanPhamDTOS'] != null && data['loaiSanPhamDTOS'] is List) {
          for (var e in (data['loaiSanPhamDTOS'] as List)) {
            TypeOfDrugModel typeOfDrug = TypeOfDrugModel(typeOfDrugID: e['id'], typeOfDrugName: e['ten']);
            loaiSanPhamList.add(typeOfDrug);
          }
        }

        print(tinhTrangSuDungList.length + loaiSanPhamList.length);
        return {
          "tinhTrangSuDung": tinhTrangSuDungList,
          "loaiSanPham": loaiSanPhamList,
        };
      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
      }
    } else {
      print('❌ API thất bại, mã lỗi: ${response.statusCode}');
    }
    return null;
  }


  static Future<void> submitFormDrugsHistory(DrugsHistoryForm form) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/capNhatTieuSuThuoc'),
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

  static Future<List<DrugsHistoryForm>> getDrugsHistoryData(String accountID, String type) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/layDanhSachTieuSuPreview?accountID=${accountID}&type=${type}'));

    if (response.statusCode == 200) {
      try {
        String responseBody = utf8.decode(response.bodyBytes);
        print(responseBody);
        List<dynamic> dataList = jsonDecode(responseBody);

        List<DrugsHistoryForm> drugsHistoryList = [];
        for (var e in dataList) {
          DrugsHistoryForm drugsHistoryForm = DrugsHistoryForm(
            drugsID: e['drugsID'] ?? 'Không có thông tin',
            accountID: e['accountID'] ?? 'Không có thông tin',
            drugsType: int.tryParse(e['usageStatusPD']?.toString() ?? '1') ?? 1,
            drugsName: e['drugsName'] ?? 'Không có thông tin',
            usageStatusDrugs: int.tryParse(e['usageStatusPD']?.toString() ?? '1') ?? 1,
            startDrugs: e['startDrugs'],
            endDrugs: e['endDrugs'],
            noteDrugs: e['noteDrugs'] ?? '',
          );
          drugsHistoryList.add(drugsHistoryForm);
        }

        print(drugsHistoryList.length);
        return drugsHistoryList;
      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
      }
    } else {
      throw Exception('Failed to load users');
    }
  }
  static Future<void> deleteDrugsHistoryForm(String tieuSuThuocID, String type) async {
    final response = await http.delete(Uri.parse('http://10.0.2.2:8080/xoaTieuSuYTe?tieuSuYTeID=${tieuSuThuocID}&type=${type}'));

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
