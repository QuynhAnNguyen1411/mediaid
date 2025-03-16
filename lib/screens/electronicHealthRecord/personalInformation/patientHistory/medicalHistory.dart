import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaid/api/electronicHealthRecord/patientHistory_api.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/input_field/text_input.dart';
import 'package:mediaid/models/electronicHealthRecord/personalInformation/level.dart';
import 'package:mediaid/models/electronicHealthRecord/personalInformation/treatmentMethod.dart';
import '../../../../design_system/button/button.dart';
import '../../../../design_system/color/primary_color.dart';
import '../../../../design_system/textstyle/textstyle.dart';

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MedicalHistoryState();
  }
}

class _MedicalHistoryState extends State<MedicalHistory>
    with SingleTickerProviderStateMixin {
  bool isExpandedMedicalHistory = false;
  bool isExpandedFamilyHistory = false;

  bool isChecked = false;
  bool isDisabled = false;

  // Controller Bệnh từng mắc hoặc đang điều trị
  final TextEditingController typeOfDiseaseController = TextEditingController();
  final TextEditingController yearOfDiagnosisController =
  TextEditingController();
  final TextEditingController medicalLevelController = TextEditingController();
  final TextEditingController treatmentMethodController =
  TextEditingController();
  final TextEditingController complicationsController = TextEditingController();
  final TextEditingController hospitalTreatmentController =
  TextEditingController();
  final TextEditingController noteDiseaseController = TextEditingController();

  // Controller Bệnh di truyền - FM: Family Member
  final TextEditingController geneticDiseaseController =
  TextEditingController();
  final TextEditingController relationshipFMController =
  TextEditingController();
  final TextEditingController yearOfDiseaseFMController =
  TextEditingController();
  final TextEditingController medicalLevelFMController =
  TextEditingController();
  final TextEditingController noteDiseaseFMController = TextEditingController();

  // Danh sách chứa các form nhập liệu
  List<Widget> medicalHistoryForms = [];
  List<Widget> familyHistoryForms = [];

  //Dropdown
  late List<Level> mucDoList = [];
  late List<TreatmentMethod> phuongPhapDieuTriList = [];

  int? _selectedMucdoId;
  int? _selectedPhuongphapdieutriId;

  // Hàm thêm form mới vào danh sách
  void _toggleMedicalHistory() {
    setState(() {
      medicalHistoryForms.add(buildMedicalHistoryForm());
    });
  }

  // Hàm thêm form mới vào danh sách "Bệnh di truyền"
  void _toggleFamilyHistory() {
    setState(() {
      familyHistoryForms.add(buildFamilyHistoryForm());
    });
  }

  Future<void> _fetchDropdownDataMedicalHistory() async {
    try {
      Map<String, List<Object>>? response =
      await PatientHistoryApi.getStaticDataForPatientHistory();

      if (response != null) {
        print("a");
        setState(() {
          mucDoList = (response['mucDo'] as List<Level>).toList();
          phuongPhapDieuTriList = (response['phuongPhapDieuTri'] as List<TreatmentMethod>).toList();
        });

        print("✅ Đã cập nhật danh sách Mức độ: $mucDoList");
        print("✅ Đã cập nhật danh sách Phương pháp điều trị: $phuongPhapDieuTriList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDropdownDataMedicalHistory();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Bệnh từng mắc phải hoặc đang chữa trị',
                style: TextStyleCustom.heading_3a),
            trailing: CustomButton(
              type: ButtonType.iconOnly,
              state: ButtonState.text,
              width: screenWidth * 0.1,
              height: screenHeight * 0.05,
              icon: Icons.add_circle_outline_rounded,
              onPressed: _toggleMedicalHistory,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.001),
            child: Text(
              'Ghi chú: Bỏ qua nếu không có',
              style: TextStyleCustom.caption,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Visibility(
            visible: medicalHistoryForms.isNotEmpty,
            child: Scrollbar(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: PrimaryColor.primary_10, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                height: screenHeight * 0.6,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: medicalHistoryForms.map((form) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: Stack(
                          children: [
                            form,
                            Positioned(
                              top: screenHeight * 0.015,
                              right: screenWidth * 0.02,
                              child: IconButton(
                                icon: Icon(Icons.close,
                                    color: StatusColor.errorFull),
                                onPressed: () {
                                  setState(() {
                                    // Xóa form khỏi danh sách
                                    medicalHistoryForms.remove(form);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Bệnh di truyền', style: TextStyleCustom.heading_3a),
            trailing: CustomButton(
              type: ButtonType.iconOnly,
              state: ButtonState.text,
              width: screenWidth * 0.1,
              height: screenHeight * 0.05,
              icon: Icons.add_circle_outline_rounded,
              onPressed: _toggleFamilyHistory,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.001),
            child: Text(
              'Ghi chú: Bỏ qua nếu không có',
              style: TextStyleCustom.caption,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Visibility(
            visible: familyHistoryForms.isNotEmpty,
            child: Scrollbar(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: PrimaryColor.primary_10, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                height: screenHeight * 0.6,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: familyHistoryForms.map((form) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: Stack(
                          children: [
                            form,
                            Positioned(
                              top: screenHeight * 0.015,
                              right: screenWidth * 0.02,
                              child: IconButton(
                                icon: Icon(Icons.close,
                                    color: StatusColor.errorFull),
                                // Nút xóa
                                onPressed: () {
                                  setState(() {
                                    // Xóa form khỏi danh sách
                                    familyHistoryForms.remove(form);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMedicalHistoryForm() {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.015),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: PrimaryColor.primary_10, width: 1.2),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Loại bệnh',
            hintText: 'Điền loại bệnh mắc phải',
            controller: typeOfDiseaseController,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            children: [
              Expanded(
                  child: CustomTextInput(
                    label: 'Năm phát hiện',
                    type: TextFieldType.text,
                    state: TextFieldState.defaultState,
                    hintText: 'Điền năm',
                    controller: yearOfDiagnosisController,
                    keyboardType: TextInputType.multiline,
                  )),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mức độ',
                          style: TextStyleCustom.heading_3b.copyWith(color: PrimaryColor.primary_10),
                        ),
                        GestureDetector( // Thêm GestureDetector để xử lý sự kiện onTap
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Mức độ tình trạng bệnh", style: TextStyleCustom.heading_3c),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Nhẹ
                                        Text(
                                          "• Nhẹ:",
                                          style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10),
                                        ),
                                        Text(
                                          "Bệnh không ảnh hưởng nhiều đến cuộc sống, không cần điều trị đặc biệt.",
                                          style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                        ),
                                        SizedBox(height: screenHeight * 0.015),
                                        // Vừa
                                        Text(
                                          "• Vừa:",
                                          style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10),
                                        ),
                                        Text(
                                          "Bệnh có thay đổi nhưng vẫn kiểm soát được, cần điều trị theo dõi.",
                                          style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                        ),
                                        SizedBox(height: screenHeight * 0.015),
                                        // Nặng
                                        Text(
                                          "• Nặng:",
                                          style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10),
                                        ),
                                        Text(
                                          "Bệnh tiến triển nghiêm trọng, cần điều trị chuyên sâu và theo dõi thường xuyên.",
                                          style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Đóng dialog
                                      },
                                      child: Text("Đóng", style: TextStyle(fontSize: 16, color: Colors.blue)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/icons/electronicHealthRecord/info.svg",
                            color: StatusColor.errorLighter,
                            width: screenWidth * 0.06,
                            height: screenHeight * 0.03,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    DropdownButtonFormField<int>(
                      value: _selectedMucdoId,
                      hint: Text(
                        'Chọn mức độ',
                        style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                      ),
                      isExpanded: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03, vertical: screenHeight * 0.018),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: NeutralColor.neutral_04,
                            width: screenWidth * 0.004,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: NeutralColor.neutral_04,
                            width: screenWidth * 0.004,
                          ),
                        ),
                      ),
                      dropdownColor: PrimaryColor.primary_00,
                      items: mucDoList.map((mucDo) {
                        return DropdownMenuItem<int>(
                          value: mucDo.levelID,
                          child: Text(
                            mucDo.levelName,
                            style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMucdoId = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02, bottom: screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phương pháp điều trị',
                      style: TextStyleCustom.heading_3b.copyWith(color: PrimaryColor.primary_10),
                    ),
                    GestureDetector( // Thêm GestureDetector để xử lý sự kiện onTap
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Phương pháp điều trị chính", style: TextStyleCustom.heading_3c),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "• Điều trị nội khoa (dùng thuốc):",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Thuốc giảm đau, Thuốc kháng sinh, Thuốc chống viêm, Thuốc hạ huyết áp, "
                                          "Thuốc điều trị tiểu đường, Thuốc điều trị bệnh lý tim mạch, Thuốc kháng histamine, "
                                          "Thuốc chống lo âu hoặc trầm cảm...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị phẫu thuật
                                    Text(
                                      "• Điều trị phẫu thuật:",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Phẫu thuật cấp cứu, Phẫu thuật chỉnh hình, Phẫu thuật tim mạch, Phẫu thuật thần kinh, "
                                          "Phẫu thuật nội soi...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị bằng liệu pháp vật lý
                                    Text(
                                      "• Điều trị bằng liệu pháp vật lý:",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Vật lý trị liệu, Massage trị liệu, Xung điện trị liệu, Điều trị bằng nhiệt hoặc lạnh, "
                                          "Châm cứu...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị tâm lý
                                    Text(
                                      "• Điều trị tâm lý:",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Tâm lý trị liệu, Liệu pháp nhóm, Liệu pháp thư giãn, Điều trị bằng thuốc an thần hoặc chống trầm cảm...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị bằng dinh dưỡng
                                    Text(
                                      "• Điều trị bằng dinh dưỡng:",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Chế độ ăn đặc biệt, Bổ sung vitamin và khoáng chất, Điều trị bằng chế độ ăn giảm muối hoặc giảm đường, "
                                          "Dinh dưỡng qua ống thông...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị bằng vật lý và các phương pháp thay thế
                                    Text(
                                      "• Điều trị bằng vật lý và các phương pháp thay thế:",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Điều trị bằng phương pháp thay thế, Điều trị bằng thảo dược, Điều trị bằng phương pháp nắn chỉnh...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị bằng liệu pháp hormon
                                    Text(
                                      "• Điều trị bằng liệu pháp hormon:",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Thay thế hormon, Liệu pháp hormon tăng trưởng...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị bằng phóng xạ
                                    Text(
                                      "• Điều trị bằng phóng xạ (xạ trị):",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Xạ trị, Điều trị bằng isotopes phóng xạ...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị bằng truyền máu
                                    Text(
                                      "• Điều trị bằng truyền máu:",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Truyền máu, Truyền huyết thanh...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị bằng các phương pháp chăm sóc đặc biệt
                                    Text(
                                      "• Điều trị bằng các phương pháp chăm sóc đặc biệt:",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Hồi sức cấp cứu, Chăm sóc giảm nhẹ, Chăm sóc tại nhà...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị bằng liệu pháp miễn dịch
                                    Text(
                                      "• Điều trị bằng liệu pháp miễn dịch:",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Điều trị miễn dịch, Vaccine...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    // Khoảng cách giữa các phần

                                    // Điều trị thay thế cơ quan
                                    Text(
                                      "• Điều trị thay thế cơ quan:",
                                      style: TextStyleCustom.bodyLarge
                                          .copyWith(color: PrimaryColor.primary_10),
                                    ),
                                    Text(
                                      "Ví dụ: Lọc thận (Dialysis), Ghép tạng...",
                                      style: TextStyleCustom.bodySmall
                                          .copyWith(color: NeutralColor.neutral_06),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Đóng dialog
                                  },
                                  child: Text("Đóng", style: TextStyle(fontSize: 16, color: Colors.blue)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/icons/electronicHealthRecord/info.svg",
                        color: StatusColor.errorLighter,
                        width: screenWidth * 0.06,
                        height: screenHeight * 0.03,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.005),
                DropdownButtonFormField<int>(
                  value: _selectedPhuongphapdieutriId,
                  hint: Text(
                    'Chọn phương pháp điều trị',
                    style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                  ),
                  isExpanded: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03, vertical: screenHeight * 0.018),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: NeutralColor.neutral_04,
                        width: screenWidth * 0.004,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: NeutralColor.neutral_04,
                        width: screenWidth * 0.004,
                      ),
                    ),
                  ),
                  dropdownColor: PrimaryColor.primary_00,
                  items: phuongPhapDieuTriList.map((phuongPhapDieuTri) {
                    return DropdownMenuItem<int>(
                      value: phuongPhapDieuTri.treatmentMethodID,
                      child: Text(
                        phuongPhapDieuTri.treatmentMethodName,
                        style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPhuongphapdieutriId = value;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Biến chứng',
            hintText: 'Điền các loại biến chứng gặp phải',
            controller: complicationsController,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Bệnh viện điều trị',
            hintText: 'Điền tên bệnh viện điều trị',
            controller: hospitalTreatmentController,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Ghi chú',
            hintText: 'Điền ghi chú',
            controller: noteDiseaseController,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }

  Widget buildFamilyHistoryForm() {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: PrimaryColor.primary_10, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Loại bệnh',
            hintText: 'Điền loại bệnh mắc phải',
            controller: geneticDiseaseController,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextInput(
            label: 'Thành viên trong gia đình mắc bệnh',
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            hintText: 'Điền mối quan hệ',
            controller: relationshipFMController,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            children: [
              Expanded(
                child: CustomTextInput(
                  label: 'Năm phát hiện',
                  type: TextFieldType.text,
                  state: TextFieldState.defaultState,
                  hintText: 'Điền năm',
                  controller: yearOfDiseaseFMController,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: CustomTextInput(
                  label: 'Mức độ',
                  iconLabel: SvgPicture.asset(
                    "assets/icons/electronicHealthRecord/info.svg",
                    color: StatusColor.errorLighter,
                  ),
                  onTapIconLabel: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Mức độ tình trạng bệnh",
                                style: TextStyleCustom.heading_3c),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Nhẹ
                                  Text(
                                    "• Nhẹ:",
                                    style: TextStyleCustom.bodyLarge.copyWith(
                                        color: PrimaryColor.primary_10),
                                  ),
                                  Text(
                                    "Bệnh không ảnh hưởng nhiều đến cuộc sống, không cần điều trị đặc biệt.",
                                    style: TextStyleCustom.bodySmall.copyWith(
                                        color: NeutralColor.neutral_06),
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  // Vừa
                                  Text(
                                    "• Vừa:",
                                    style: TextStyleCustom.bodyLarge.copyWith(
                                        color: PrimaryColor.primary_10),
                                  ),
                                  Text(
                                    "Bệnh có thay đổi nhưng vẫn kiểm soát được, cần điều trị theo dõi.",
                                    style: TextStyleCustom.bodySmall.copyWith(
                                        color: NeutralColor.neutral_06),
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  // Nặng
                                  Text(
                                    "• Nặng:",
                                    style: TextStyleCustom.bodyLarge.copyWith(
                                        color: PrimaryColor.primary_10),
                                  ),
                                  Text(
                                    "Bệnh tiến triển nghiêm trọng, cần điều trị chuyên sâu và theo dõi thường xuyên.",
                                    style: TextStyleCustom.bodySmall.copyWith(
                                        color: NeutralColor.neutral_06),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Đóng dialog
                                },
                                child: Text("Đóng",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.blue)),
                              ),
                            ],
                          );
                        });
                  },
                  type: TextFieldType.textIconRight,
                  state: TextFieldState.defaultState,
                  hintText: 'Chọn mức độ',
                  controller: medicalLevelFMController,
                  iconTextInput: Icons.arrow_drop_down_sharp,
                ),
              )
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Ghi chú',
            hintText: 'Điền ghi chú',
            controller: noteDiseaseFMController,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}
