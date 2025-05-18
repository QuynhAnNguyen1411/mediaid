import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../models/registrationModel/genderModel.dart';
import '../../models/registrationModel/nationModel.dart';
import '../../models/registrationModel/registrationForm.dart';

class RegistrationApi {
  // Dân tộc + Giới tính
  static Future<Map<String, List<Object>>?> getStaticDataForRegistration() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/static/staticDataForRegistry'));

    if (response.statusCode == 200) {
      try {
        // Giải mã body với UTF-8
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> data = jsonDecode(responseBody);
        // print(data);

        List<NationModel> danTocList = [];
        if (data['nation'] != null && data['nation'] is List) {
          for (var e in (data['nation'] as List)) {
            NationModel nation = NationModel(nationID: e['nationID'], nationName: e['nationName']);
            danTocList.add(nation);
          }
        }

        List<GenderModel> gioiTinhList = [];
        if (data['gender'] != null && data['gender'] is List) {
          for (var e in (data['gender'] as List)) {
            GenderModel gender = GenderModel(genderID: e['genderID'], genderName: e['genderName']);
            gioiTinhList.add(gender);
          }
        }
        print(gioiTinhList.length+danTocList.length);
        return {"danToc": danTocList, "gioiTinh": gioiTinhList};

      } catch (e) {
        throw Exception('❌ Lỗi xử lý JSON: $e');
        return null;
      }
    } else {
      print('❌ API thất bại, mã lỗi: ${response.statusCode}');
    }
    return null;
  }

  // Gửi cả form đăng ký
  static Future<void> submitForm(RegistrationForm form) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/authentication/registry'), // Địa chỉ API của bạn
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

  // Lưu token vào Hive sau khi đăng nhập thành công
  Future<void> login(String personalIdentifierLogIn, String patientPasswordLogIn) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/authentication/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'personalIdentifier': personalIdentifierLogIn, 'password': patientPasswordLogIn}),
    );

    if (response.statusCode == 200) {
      // Backend trả về token (ví dụ: JWT)
      final data = json.decode(response.body);
      String token = data['token'];

      // Lưu token vào Hive
      var box = await Hive.openBox('loginBox');
      await box.put('auth_token', token);
    } else {
      // Xử lý lỗi nếu đăng nhập không thành công
      print('Login failed');
    }
  }

  // // Lấy token từ Hive và sử dụng trong các yêu cầu tiếp theo
  // Future<void> getProfile() async {
  //   var box = await Hive.openBox('loginBox');
  //   String? token = box.get('auth_token');
  //
  //   if (token != null) {
  //     final response = await http.get(
  //       Uri.parse('http://10.0.2.2:8080/api/authentication/login'),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Xử lý dữ liệu người dùng
  //       print('Profile: ${response.body}');
  //     } else {
  //       // Xử lý lỗi nếu yêu cầu thất bại
  //       print('Failed to fetch profile');
  //     }
  //   } else {
  //     print('No token found, please login first');
  //   }
  // }
  //
  // // Lấy giới tính đã đăng ký để hiển thị body + Data hiển thị chỉnh sửa
  // static Future<RegistrationForm?> getRegistrationData(String id) async {
  //   final response = await http.get(Uri.parse('http://10.0.2.2:8080/'));
  //
  //   if (response.statusCode == 200) {
  //     try {
  //       String responseBody = utf8.decode(response.bodyBytes);
  //       Map<String, dynamic> data = jsonDecode(responseBody);
  //       print(data);
  //
  //       // Cập nhật các khóa phù hợp với dữ liệu bạn muốn truy xuất từ response
  //       RegistrationForm registrationForm = RegistrationForm(
  //           personalIdentifier: data['accountID'],
  //           healthInsurance: data['accountID'],
  //           patientName: data['accountID'],
  //           addressPatient: data['accountID'],
  //           phoneNumber: data['accountID'],
  //           emailPatient: data['accountID'],
  //           dob: data['accountID'],
  //           sexPatient: data['accountID'],
  //           nationPatient: data['accountID'],
  //           patientPassword: data['accountID'],
  //           patientFamilyName: data['accountID'],
  //           patientRelationship: data['accountID'],
  //           patientFamilyIdentifier: data['accountID'],
  //           patientFamilyPhoneNumber: data['accountID'],
  //       );
  //
  //       return registrationForm;
  //     } catch (e) {
  //       throw Exception('❌ Lỗi xử lý JSON: $e');
  //     }
  //   } else {
  //     print('❌ API thất bại, mã lỗi: ${response.statusCode}');
  //     return null; // Nếu API không thành công, trả về null
  //   }
  // }

}
