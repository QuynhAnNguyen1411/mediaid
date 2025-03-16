import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/primary_color.dart';

import '../../../../design_system/button/button.dart';
import '../../../../design_system/color/status_color.dart';
import '../../../../design_system/input_field/text_input.dart';
import '../../../../design_system/textstyle/textstyle.dart';

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

  // Hàm thêm form mới vào danh sách
  void _toggleAllergyHistory() {
    setState(() {
      allergyHistoryForms.add(buildAllergyHistoryForm());
    });
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
                onPressed: _toggleAllergyHistory,
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
              visible: allergyHistoryForms.isNotEmpty,
              child: Scrollbar(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: PrimaryColor.primary_10, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: screenHeight * 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: allergyHistoryForms.map((form) {
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
                                      allergyHistoryForms.remove(form);
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

  Widget buildAllergyHistoryForm() {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
      decoration: BoxDecoration(
          border: Border.all(color: PrimaryColor.primary_10, width: 1.2),
          borderRadius: BorderRadius.circular(12)),
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
                  child: CustomTextInput(
                label: 'Mức độ',
                type: TextFieldType.textIconRight,
                state: TextFieldState.defaultState,
                hintText: 'Chọn mức độ',
                controller: allergyLevelController,
                iconTextInput: Icons.arrow_drop_down_sharp,
              )),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                  child: CustomTextInput(
                label: 'Lần cuối xảy ra',
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
        ],
      ),
    );
  }
}
