
import 'package:mediaid/models/setExamNumberModel/bodyPart_2Model.dart';

class BodyPart1Model {
  final String bodyPart1ID;
  final String bodyPart1Name;
  final List<BodyPart2Model>? bodyPart2List;

  BodyPart1Model({
    required this.bodyPart1ID,
    required this.bodyPart1Name,
    this.bodyPart2List,
  });

  // Convert JSON to Model using List
  factory BodyPart1Model.fromJson(Map<String, dynamic> json) {
    // Giải mã bodyPart2List thành List<BodyPart2Model>
    var bodyPart2ListFromJson = json['danhSachBoPhanList'] as List?;
    List<BodyPart2Model>? bodyPart2List = bodyPart2ListFromJson?.map((item) => BodyPart2Model.fromJson(item)).toList();

    return BodyPart1Model(
      bodyPart1ID: json['phanVungID'] ?? '',
      bodyPart1Name: json['ten'] ?? '',
      bodyPart2List: bodyPart2List,
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'bodyPart1ID': bodyPart1ID,
      'bodyPart1Name': bodyPart1Name,
      'bodyPart2List': bodyPart2List?.map((item) => item.toJson()).toList(),
    };
  }
}
