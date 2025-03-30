import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/models/electronicHealthRecord/personalInformation/allergyHistory.dart';

import '../../../../api/electronicHealthRecord/patientHistory_api.dart';
import '../../../../design_system/button/button.dart';
import '../../../../design_system/color/neutral_color.dart';
import '../../../../design_system/color/status_color.dart';
import '../../../../design_system/input_field/text_input.dart';
import '../../../../design_system/textstyle/textstyle.dart';
import '../../../../models/electronicHealthRecord/personalInformation/level.dart';

class AllergyHistory extends StatefulWidget {
  const AllergyHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AllergyHistoryState();
  }
}

class _AllergyHistoryState extends State<AllergyHistory>
    with SingleTickerProviderStateMixin {
  bool isExpandedAllergyHistory = false;

  // Controller Tiểu sử dị ứng
  final TextEditingController allergicAgentsController =
      TextEditingController();
  final TextEditingController allergySymptomsController =
      TextEditingController();
  final TextEditingController allergyLevelController = TextEditingController();
  final TextEditingController lastHappenedController = TextEditingController();
  final TextEditingController noteAllergyController = TextEditingController();

  // Danh sách chứa các form nhập liệu
  List<Widget> allergyHistoryForms = [];

  //Dropdown
  late List<Level> mucDoList = [];
  int? _selectedMucdoId;


  Future<void> _fetchDropdownDataAllergyHistory() async {
    try {
      Map<String, List<Object>>? response =
      await PatientHistoryApi.getStaticDataForPatientHistory();

      if (response != null) {
        print("a");
        setState(() {
          mucDoList = (response['mucDo'] as List<Level>).toList();
        });

        print("✅ Đã cập nhật danh sách Mức độ: $mucDoList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
  }

  // Hàm gửi dữ liệu form khi nhấn nút "Lưu thông tin" - Tiểu sử dị ứng
  Future<void> _submitFormAllergyHistory() async {
    AllergyHistoryForm form = AllergyHistoryForm(
      allergicAgents: allergicAgentsController.text,
      allergySymptoms: allergySymptomsController.text,
      allergyLevel: _selectedMucdoId ?? 1,
      lastHappened: lastHappenedController.text,
      noteAllergy: noteAllergyController.text
    );

    // Gửi form đến API
    try {
      print(form.toJson());
      await PatientHistoryApi.submitFormAllergyHistory(form);
      print('Form đã được gửi thành công.');
    } catch (e) {
      print('Có lỗi xảy ra khi gửi form: $e');
    }
  }

  void _resetFormAllergyHistory() {
    allergicAgentsController.clear();
    allergySymptomsController.clear();
    lastHappenedController.clear();
    noteAllergyController.clear();
    setState(() {
      _selectedMucdoId = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDropdownDataAllergyHistory();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Tiểu sử dị ứng', style: TextStyleCustom.heading_3a),
              trailing: CustomButton(
                type: ButtonType.iconOnly,
                state: ButtonState.text,
                width: screenWidth * 0.1,
                height: screenHeight * 0.05,
                icon: Icons.add_circle_outline_rounded,
                onPressed: () => _showAllergyHistory(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.001),
              child: Text(
                'Ghi chú: Bỏ qua nếu không có',
                style: TextStyleCustom.caption,
              ),
            ),

          ],
        ),
      ),
    );
  }


  void _showAllergyHistory(BuildContext context){
    showModalBottomSheet(
        backgroundColor: PrimaryColor.primary_00,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          return Scaffold(
            backgroundColor: PrimaryColor.primary_00,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenHeight * 0.08, screenWidth * 0.04, screenHeight * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextInput(
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      label: 'Tác nhân dị ứng',
                      hintText: 'Điền tác nhân dị ứng',
                      controller: allergicAgentsController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextInput(
                      label: 'Triệu chứng',
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      hintText: 'Điền chi tiết các triệu chứng gặp phải',
                      controller: allergySymptomsController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
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
                                            title: Text("Mức độ tình trạng dị ứng", style: TextStyleCustom.heading_3c),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  // Nhẹ
                                                  Text(
                                                    "• Dị ứng nhẹ:",
                                                    style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10),
                                                  ),
                                                  Text(
                                                    "Ngứa, phát ban, chảy nước mũi, hắt hơi, ngứa mắt.",
                                                    style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                                  ),
                                                  SizedBox(height: screenHeight * 0.015),
                                                  // Vừa
                                                  Text(
                                                    "• Dị ứng vừa:",
                                                    style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10),
                                                  ),
                                                  Text(
                                                    "Phát ban sưng tấy, khó thở nhẹ, chóng mặt, nôn mửa hoặc tiêu chảy.",
                                                    style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                                  ),
                                                  SizedBox(height: screenHeight * 0.015),
                                                  // Nặng
                                                  Text(
                                                    "• Dị ứng nặng:",
                                                    style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10),
                                                  ),
                                                  Text(
                                                    "Khó thở nghiêm trọng, sưng môi, mắt, mặt, lưỡi, sốc phản vệ, tụt huyết áp, mất ý thức.",
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
                                                child: Text("Đóng", style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_05)),
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
                        SizedBox(width: screenWidth * 0.04),
                        Expanded(
                            child: CustomTextInput(
                              label: 'Lần gần nhất',
                              type: TextFieldType.text,
                              state: TextFieldState.defaultState,
                              hintText: 'Điền thời gian',
                              controller: lastHappenedController,
                              keyboardType: TextInputType.multiline,
                            )),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextInput(
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      label: 'Ghi chú',
                      hintText: 'Điền ghi chú',
                      controller: noteAllergyController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomButton(
                            type: ButtonType.standard,
                            state: ButtonState.fill2,
                            text: 'Xóa thông tin',
                            width: double.infinity,
                            height: screenHeight * 0.06,
                            onPressed: () {
                              _resetFormAllergyHistory();
                            },
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: CustomButton(
                            type: ButtonType.standard,
                            state: ButtonState.fill1,
                            text: 'Lưu thông tin',
                            width: double.infinity,
                            height: screenHeight * 0.06,
                            onPressed: () {
                              _submitFormAllergyHistory();
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            )
          );
        }
    );
  }
}
