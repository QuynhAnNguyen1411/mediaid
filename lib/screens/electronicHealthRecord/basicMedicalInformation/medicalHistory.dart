import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/input_field/text_input.dart';
import '../../../design_system/button/button.dart';
import '../../../design_system/color/primary_color.dart';
import '../../../design_system/textstyle/textstyle.dart';

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
  final TextEditingController currentMedicalConditionController =
      TextEditingController();
  final TextEditingController treatmentController = TextEditingController();
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
  final TextEditingController currentMedicalConditionFMController =
      TextEditingController();
  final TextEditingController noteDiseaseFMController = TextEditingController();


  // Danh sách chứa các form nhập liệu
  List<Widget> medicalHistoryForms = [];
  List<Widget> familyHistoryForms = [];

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

  @override
  Widget build(BuildContext context) {
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
              width: 48,
              height: 48,
              icon: Icons.add_circle_outline_rounded,
              onPressed: _toggleMedicalHistory,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              'Ghi chú: Bỏ qua nếu không có',
              style: TextStyleCustom.caption,
            ),
          ),
          const SizedBox(height: 20),
          Visibility(
            visible:  medicalHistoryForms.isNotEmpty,
            child: Scrollbar(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: PrimaryColor.primary_10, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: medicalHistoryForms.map((form) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Stack(
                          children: [
                            form,
                            Positioned(
                              top: 12,
                              right: 8,
                              child: IconButton(
                                icon: Icon(Icons.close, color: StatusColor.errorFull),
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
              width: 48,
              height: 48,
              icon: Icons.add_circle_outline_rounded,
              onPressed: _toggleFamilyHistory,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5), // Căn lề ngang với nội dung
            child: Text(
              'Ghi chú: Bỏ qua nếu không có',
              style: TextStyleCustom.caption,
            ),
          ),
          const SizedBox(height: 20),
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
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: familyHistoryForms.map((form) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Stack(
                          children: [
                            form,
                            Positioned(
                              top: 12,
                              right: 8,
                              child: IconButton(
                                icon: Icon(Icons.close, color: StatusColor.errorFull),  // Nút xóa
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
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: PrimaryColor.primary_10, width: 0.5),
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
          const SizedBox(height: 16),
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
              const SizedBox(width: 20),
              Expanded(
                  child: CustomTextInput(
                label: 'Tình trạng hiện tại',
                type: TextFieldType.textIconRight,
                state: TextFieldState.defaultState,
                hintText: 'Chọn tình trạng',
                controller: currentMedicalConditionController,
                icon: Icons.arrow_drop_down_sharp,
              )),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextInput(
            label: 'Phương pháp điều trị',
            type: TextFieldType.textIconRight,
            state: TextFieldState.defaultState,
            hintText: 'Chọn phương pháp điều trị chính',
            controller: treatmentController,
            icon: Icons.arrow_drop_down_sharp,
          ),
          const SizedBox(height: 16),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Biến chứng',
            hintText: 'Điền các loại biến chứng gặp phải',
            controller: complicationsController,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 16),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Bệnh viện điều trị',
            hintText: 'Điền tên bệnh viện điều trị',
            controller: hospitalTreatmentController,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 16),
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
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: PrimaryColor.primary_10, width: 0.5),
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
            const SizedBox(height: 16),
            CustomTextInput(
              label: 'Thành viên trong gia đình mắc bệnh',
              type: TextFieldType.text,
              state: TextFieldState.defaultState,
              hintText: 'Điền mối quan hệ',
              controller: relationshipFMController,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextInput(
                    label: 'Năm phát hiện - Thành viên gia đình',
                    type: TextFieldType.text,
                    state: TextFieldState.defaultState,
                    hintText: 'Điền năm',
                    controller: yearOfDiseaseFMController,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomTextInput(
                    label: 'Tình trạng hiện tại - Thành viên gia đình',
                    type: TextFieldType.textIconRight,
                    state: TextFieldState.defaultState,
                    hintText: 'Chọn tình trạng hiện tại',
                    controller: currentMedicalConditionFMController,
                    icon: Icons.arrow_drop_down_sharp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
