import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mediaid/models/registration/gender.dart';

import '../../config.dart';
import '../../models/registration/nation.dart';
import 'package:http/http.dart' as http;

Future getNation() async {
  final response = await http.get(Uri.parse('${AppConfig.baseUrl}/getNation'));

  if (response.statusCode == 200) {
    final utf8DecodedBody = utf8.decode(response.bodyBytes);
    return Nation.fromJsonList(utf8DecodedBody);
    // return jsonDecode(response.body); // Converts JSON to List
  } else {
    throw Exception('Failed to load nations');
  }

  // return [
  //   Nation(id: '1', name: 'Kinh'),
  //   Nation(id: '2', name: 'Tày'),
  //   Nation(id: '3', name: 'Thái'),
  //   Nation(id: '4', name: 'Mường'),
  //   Nation(id: '5', name: 'H Mông'),
  //   Nation(id: '6', name: 'Nùng'),
  //   Nation(id: '7', name: 'Khmer'),
  //   Nation(id: '8', name: 'Hoa'),
  //   Nation(id: '9', name: 'Chăm'),
  //   Nation(id: '10', name: 'Ê đê'),
  //   Nation(id: '11', name: 'Bà Na'),
  //   Nation(id: '12', name: 'Dân tộc Xơ Đăng'),
  //   Nation(id: '13', name: 'Ra Glai'),
  //   Nation(id: '14', name: 'Cơ Ho'),
  //   Nation(id: '15', name: 'Tà Ôi'),
  //   Nation(id: '16', name: 'Giẻ Triêng'),
  //   Nation(id: '17', name: 'Cơ Tu'),
  //   Nation(id: '18', name: 'Bahnar'),
  //   Nation(id: '19', name: 'Tay'),
  //   Nation(id: '20', name: 'Sán Dìu'),
  //   Nation(id: '21', name: 'Thổ'),
  //   Nation(id: '22', name: 'Giáy'),
  //   Nation(id: '23', name: 'Mông'),
  //   Nation(id: '24', name: 'Sán Chay'),
  //   Nation(id: '25', name: 'Dân tộc Mường'),
  //   Nation(id: '26', name: 'Sáy'),
  //   Nation(id: '27', name: 'Khơ Mú'),
  //   Nation(id: '28', name: 'Lào'),
  //   Nation(id: '29', name: 'Ngái'),
  //   Nation(id: '30', name: 'Cơ Tu'),
  //   Nation(id: '31', name: 'Xinh Mun'),
  //   Nation(id: '32', name: 'Tày'),
  //   Nation(id: '33', name: 'Chứt'),
  //   Nation(id: '34', name: 'Cơ Ho'),
  //   Nation(id: '35', name: 'Lô Lô'),
  //   Nation(id: '36', name: 'Người Thái'),
  //   Nation(id: '37', name: 'Dân tộc Tày'),
  //   Nation(id: '38', name: 'Dân tộc Dẻ Triêng'),
  //   Nation(id: '39', name: 'Tà Ôi'),
  //   Nation(id: '40', name: 'Giẻ Triêng'),
  //   Nation(id: '41', name: 'Cơ Tu'),
  //   Nation(id: '42', name: 'Gia Lai'),
  //   Nation(id: '43', name: 'Sán Chay'),
  //   Nation(id: '44', name: 'Xo Dang'),
  //   Nation(id: '45', name: 'Raglai'),
  //   Nation(id: '46', name: 'Mống'),
  //   Nation(id: '47', name: 'Thái'),
  //   Nation(id: '48', name: 'Mường'),
  //   Nation(id: '49', name: 'Người Mường'),
  //   Nation(id: '50', name: 'Khmer'),
  //   Nation(id: '51', name: 'Kinh'),
  //   Nation(id: '52', name: 'Hmong'),
  //   Nation(id: '53', name: 'Nùng'),
  //   Nation(id: '54', name: 'Hòa')
  // ];
}

Future<List<Gender>> getGender() async {
  final response = await http.get(Uri.parse('${AppConfig.baseUrl}/getGender'));

  if (response.statusCode == 200) {
    final utf8DecodedBody = utf8.decode(response.bodyBytes);
    if (kDebugMode) {
      print(utf8DecodedBody);
    }
    return Gender.fromJsonList(utf8DecodedBody);
    // return jsonDecode(response.body); // Converts JSON to List
  } else {
    throw Exception('Failed to load nations');
  }
  // Giả lập lấy dữ liệu từ API
  await Future.delayed(Duration(seconds: 2)); // Giả lập thời gian tải dữ liệu
  return [
    Gender(genderID: 1, genderName: ''),
    Gender(genderID: 2, genderName: ''),
    Gender(genderID: 3, genderName: ''),
  ];
}

