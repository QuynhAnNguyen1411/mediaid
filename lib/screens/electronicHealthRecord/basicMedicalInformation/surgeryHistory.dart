import 'package:flutter/material.dart';

import '../../../design_system/button/button.dart';
import '../../../design_system/color/primary_color.dart';
import '../../../design_system/color/status_color.dart';
import '../../../design_system/input_field/text_input.dart';
import '../../../design_system/textstyle/textstyle.dart';

class SurgeryHistory extends StatefulWidget {
  const SurgeryHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SurgeryHistoryState();
  }
}

class _SurgeryHistoryState extends State<SurgeryHistory> with SingleTickerProviderStateMixin{
  bool isExpandedSurgeryHistory = false;

  // Controller Tiểu sử phẫu thuật
  final TextEditingController nameSurgeryController = TextEditingController();
  final TextEditingController reasonSurgeryController =TextEditingController();
  final TextEditingController surgeryLevelController = TextEditingController();
  final TextEditingController timeSurgeryController = TextEditingController();
  final TextEditingController surgicalHospitalController = TextEditingController();
  final TextEditingController complicationSurgeryController = TextEditingController();
  final TextEditingController noteSurgeryController = TextEditingController();

  // Danh sách chứa các form nhập liệu
  List<Widget> surgeryHistoryForms = [];

  // Hàm thêm form mới vào danh sách
  void _toggleSurgeryHistory() {
    setState(() {
      surgeryHistoryForms.add((buildSurgeryHistoryForm()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Tiểu sử phẫu thuật', style: TextStyleCustom.heading_3a),
              trailing: CustomButton(
                type: ButtonType.iconOnly,
                state: ButtonState.text,
                width: 48,
                height: 48,
                icon: Icons.add_circle_outline_rounded,
                onPressed: _toggleSurgeryHistory,
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
              visible: surgeryHistoryForms.isNotEmpty,
              child: Scrollbar(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: PrimaryColor.primary_10, width: 1),
                    // Đường viền của container
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 500,
                  // Giới hạn chiều cao của container
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: surgeryHistoryForms.map((form) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Stack(
                            children: [
                              form,
                              Positioned(
                                top: 12,
                                right: 8,
                                child: IconButton(
                                  icon: Icon(
                                      Icons.close, color: StatusColor.errorFull),
                                  onPressed: () {
                                    setState(() {
                                      // Xóa form khỏi danh sách
                                      surgeryHistoryForms.remove(form);
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
      ),
    );
  }
  Widget buildSurgeryHistoryForm() {
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
            label: 'Tên loại phẫu thuật',
            hintText: 'Điền loại phẫu thuật',
            controller: nameSurgeryController,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 16),
          CustomTextInput(
            label: 'Lý do phẫu thuật',
            type: TextFieldType.textIconRight,
            state: TextFieldState.defaultState,
            hintText: 'Chọn lý do phẫu thuật',
            controller: reasonSurgeryController,
            icon: Icons.arrow_drop_down_sharp,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: CustomTextInput(
                    label: 'Mức độ',
                    type: TextFieldType.textIconRight,
                    state: TextFieldState.defaultState,
                    hintText: 'Chọn mức độ',
                    controller: surgeryLevelController,
                    icon: Icons.arrow_drop_down_sharp,
                  ),
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: CustomTextInput(
                    label: 'Thời gian thực hiện',
                    type: TextFieldType.text,
                    state: TextFieldState.defaultState,
                    hintText: 'Điền thời gian',
                    controller: timeSurgeryController,
                    keyboardType: TextInputType.multiline,
                  )),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Bệnh viện phẫu thuật',
            hintText: 'Điền bệnh viện thực hiện phẫu thuật',
            controller: surgicalHospitalController,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 16),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Biến chứng',
            hintText: 'Điền biến chứng sau phẫu thuật (nếu có)',
            controller: complicationSurgeryController,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 16),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Ghi chú',
            hintText: 'Điền ghi chú',
            controller: noteSurgeryController,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}