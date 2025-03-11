import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/registration/registration.dart';

class RegistrationApi {
  // Dân tộc + Giới tính
  static Future<Map<String, List<String>>> getStaticData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/static/staticDataForRegistry'));

    if (response.statusCode == 200) {
      try {
        // Giải mã body với UTF-8
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);

        List<String> danTocList = [];
        if (data['nation'] != null && data['nation'] is List) {
          danTocList = (data['nation'] as List).map((e) => e['nationName'].toString()).toList();
        }

        List<String> gioiTinhList = [];
        if (data['gender'] != null && data['gender'] is List) {
          gioiTinhList = (data['gender'] as List).map((e) => e['genderName'].toString()).toList();
        }

        return {"danToc": danTocList, "gioiTinh": gioiTinhList};

      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
      }
    } else {
      throw Exception('❌ API thất bại, mã lỗi: ${response.statusCode}');
    }
  }

  // Gửi cả form đăng ký
  static Future<void> submitForm(RegistrationForm form) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/submitForm'), // Địa chỉ API của bạn
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
