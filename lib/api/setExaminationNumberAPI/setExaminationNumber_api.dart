import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mediaid/models/setExamNumberModel/bodyPart_1Model.dart';
import 'package:mediaid/models/setExamNumberModel/bodyPart_2Model.dart';
import 'package:mediaid/models/setExamNumberModel/symptomModel.dart';

import '../../models/setExamNumberModel/diagnoseModel.dart';

class SetExamNumberApi {
  Future<List<BodyPart1Model>> fetchBodyParts(String accountID) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8080/layDanhSachBoPhanVaTrieuChung?accountID=${accountID}'));
    try {
      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        print('Response Body: $responseBody');
        List<dynamic> data = json.decode(responseBody);
        // Chuyển đổi thành danh sách các BodyPart1Model
        List<BodyPart1Model> bodyParts = [];
        data.forEach((value) {
          var bodyPart = BodyPart1Model.fromJson(value);
          bodyParts.add(bodyPart);
        });
        return bodyParts;
      } else {
        throw Exception('fetchBodyParts Failed to load body parts');
      }
    } catch (e) {
      throw Exception(' fetchBodyParts Error fetching data: $e');
    }
  }

  Future<List<BodyPart2Model>?> findBodyPart2Models(String bodyPart1ID, List<BodyPart1Model>? bodyPart) async {
    try {
      if (bodyPart == null) {
        return null;
      }
      BodyPart1Model bodyPart1 = bodyPart
          .firstWhere((e) => e.bodyPart1ID == bodyPart1ID);

      List<BodyPart2Model>? bodyPart2s = bodyPart1.bodyPart2List;
      if (bodyPart2s == null) {
        return null;
      }
      return bodyPart2s;
    } catch (e) {
      throw Exception('findBodyPart2Models Error fetching data: $e');
    }
  }

  Future<List<SymptomModel>?> findSymptomModels(String bodyPart2ID, List<BodyPart2Model>? bodyPart2Models) async {
    try {
      if (bodyPart2Models == null) {
        return null;
      }
      BodyPart2Model result = bodyPart2Models
          .firstWhere((e) => e.bodyPart2ID == bodyPart2ID);

      List<SymptomModel>? symptomModel = result.symptomsList;
      if (symptomModel == null) {
        return null;
      }
      return symptomModel;
    } catch (e) {
      throw Exception('findBodyPart2Models Error fetching data: $e');
    }
  }

  Future<String?> submitInputForChanDoan(DiagnoseModel diagnoseModel) async {
    Map<String, dynamic> toJson() => {
      'accountID': diagnoseModel.accountID,
      'medicalFacilityID': diagnoseModel.medicalFacilityID,
      'bodyPart1ID': diagnoseModel.bodyPart1ID,
      'bodyPart2ID': diagnoseModel.bodyPart2ID,
      'symptomList': diagnoseModel.symptomList,  // New key
    };
    print ("accountID: "+diagnoseModel.accountID);
    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/LaySo'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(toJson())
    );
    String responseBody = utf8.decode(response.bodyBytes);
    print('Response Body: $responseBody');
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(responseBody);
        print (responseBody);
        if(data["lichSuKhamID"] != null){
          return data["lichSuKhamID"];
        }
        if(data["message"] != null){
          print(data["message"]);
        }
        return null;
      } else {
        throw Exception('fetchBodyParts Failed to load body parts');
      }
    } catch (e) {
      throw Exception(' fetchBodyParts Error fetching data: $e');
    }
  }
}
