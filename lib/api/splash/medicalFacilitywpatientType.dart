import 'dart:convert';
import 'package:http/http.dart' as http;


Future<List<dynamic>> fetchMedicalFacility() async {
  // Giả sử đây là API bạn gọi để lấy dữ liệu (ví dụ: GET request)
  final response = await http.get(Uri.parse('https://api.example.com/medicalFacilities'));

  if (response.statusCode == 200) {
    // Chuyển dữ liệu trả về từ JSON thành danh sách các cơ sở
    List<dynamic> data = jsonDecode(response.body);
    return data;  // Trả về danh sách dynamic
  } else {
    throw Exception('Không thể tải dữ liệu');
  }
}

