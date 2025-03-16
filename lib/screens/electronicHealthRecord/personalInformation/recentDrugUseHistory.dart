import 'package:flutter/material.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientHistory/patientHistory_Common.dart';

import '../../../design_system/button/button.dart';
import '../../../design_system/color/primary_color.dart';
import '../../../design_system/color/status_color.dart';
import '../../../design_system/input_field/text_input.dart';
import '../../../design_system/textstyle/textstyle.dart';

class DrugHistory extends StatefulWidget {
  const DrugHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DrugHistoryState();
  }
}

class _DrugHistoryState extends State<DrugHistory> {
  bool isExpandedPrescriptionDrugs = false;
  bool isExpandedNonPrescriptionDrugs = false;

  bool isChecked = false;
  bool isDisabled = false;

  // Controller Thuốc kê đơn
  final TextEditingController namePDController = TextEditingController();
  final TextEditingController usageStatusPDController = TextEditingController();
  final TextEditingController startPDController = TextEditingController();
  final TextEditingController endPDController = TextEditingController();
  final TextEditingController notePDController = TextEditingController();

  // Controller Thuốc không kê đơn / Thực phẩm chức năng
  final TextEditingController typeNPDController = TextEditingController();
  final TextEditingController nameNPDController = TextEditingController();
  final TextEditingController usageStatusNPDController =
      TextEditingController();
  final TextEditingController startNPDController = TextEditingController();
  final TextEditingController endNPDController = TextEditingController();
  final TextEditingController noteNPDController = TextEditingController();

  // Danh sách chứa các form nhập liệu
  List<Widget> prescriptionDrugsForms = [];
  List<Widget> nonPrescriptionDrugsForms = [];

  // Hàm thêm form mới vào danh sách
  void _togglePrescriptionDrugsHistory() {
    setState(() {
      prescriptionDrugsForms.add(buildPrescriptionDrugsForm());
    });
  }

  // Hàm thêm form mới vào danh sách "Bệnh di truyền"
  void _toggleNonprescriptionDrugsHistory() {
    setState(() {
      nonPrescriptionDrugsForms.add(buildNonprescriptionDrugsForm());
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo Hospital K
                  Image.asset(
                    'assets/logo/national_cancer_hospital_logo.jpg',
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.2,
                  ),

                  // Button display language
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.005),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFCCDEE7),
                          Color(0xFFCCDEE7),
                          Color(0xFF015C89),
                        ],
                        stops: [0.0, 0.12, 0.88],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // VN flag
                        Image.asset(
                          'assets/images/registration/vietnam_flag.jpg',
                          width: screenWidth * 0.08,
                          height: screenHeight * 0.04,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        // Text Vietnam
                        Text(
                          'Vietnam',
                          style: TextStyleCustom.heading_3b
                              .copyWith(color: PrimaryColor.primary_00),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            // Text: Đăng ký hồ sơ điện tử
            Text(
              'Đăng ký hồ sơ điện tử',
              style: TextStyleCustom.heading_2a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            SizedBox(height: screenHeight * 0.015),
            // Text: Thông tin bệnh nhân
            Text(
              'Lịch sử sử dụng thuốc gần đây',
              style: TextStyleCustom.heading_3a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            SizedBox(height: screenHeight * 0.02),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Thuốc kê đơn', style: TextStyleCustom.heading_3a),
              trailing: CustomButton(
                type: ButtonType.iconOnly,
                state: ButtonState.text,
                width: screenWidth * 0.1,
                height: screenHeight * 0.05,
                icon: Icons.add_circle_outline_rounded,
                onPressed: _togglePrescriptionDrugsHistory,
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
              visible: prescriptionDrugsForms.isNotEmpty,
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
                      children: prescriptionDrugsForms.map((form) {
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
                                      prescriptionDrugsForms.remove(form);
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
              title: Text('Thuốc không kê đơn / Thực phẩm chức năng',
                  style: TextStyleCustom.heading_3a),
              trailing: CustomButton(
                type: ButtonType.iconOnly,
                state: ButtonState.text,
                width: screenWidth * 0.1,
                height: screenHeight * 0.05,
                icon: Icons.add_circle_outline_rounded,
                onPressed: _toggleNonprescriptionDrugsHistory,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.001),
              // Căn lề ngang với nội dung
              child: Text(
                'Ghi chú: Bỏ qua nếu không có',
                style: TextStyleCustom.caption,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Visibility(
              visible: nonPrescriptionDrugsForms.isNotEmpty,
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
                      children: nonPrescriptionDrugsForms.map((form) {
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
                                      nonPrescriptionDrugsForms.remove(form);
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
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomButton(
                    type: ButtonType.standard,
                    state: ButtonState.fill2,
                    text: 'Quay lại',
                    width: double.infinity,
                    height: screenHeight * 0.06,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientHistory()),
                      );
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: CustomButton(
                    type: ButtonType.standard,
                    state: ButtonState.fill1,
                    text: 'Tiếp tục',
                    width: double.infinity,
                    height: screenHeight * 0.06,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DrugHistory()),
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

  Widget buildPrescriptionDrugsForm() {
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
            label: 'Tên loại thuốc',
            hintText: 'Điền tên loại thuốc',
            controller: namePDController,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextInput(
            label: 'Tình trạng sử dụng',
            type: TextFieldType.textIconRight,
            state: TextFieldState.defaultState,
            hintText: 'Tình trạng sử dụng hiện tại',
            controller: usageStatusPDController,
            iconTextInput: Icons.arrow_drop_down_sharp,
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            children: [
              Expanded(
                  child: CustomTextInput(
                label: 'Bắt đầu',
                type: TextFieldType.text,
                state: TextFieldState.defaultState,
                hintText: 'Chọn thời gian',
                controller: startPDController,
                keyboardType: TextInputType.multiline,
              )),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                  child: CustomTextInput(
                label: 'Kết thúc',
                type: TextFieldType.textIconRight,
                state: TextFieldState.defaultState,
                hintText: 'Chọn thời gian',
                controller: endPDController,
                iconTextInput: Icons.arrow_drop_down_sharp,
              )),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Ghi chú',
            hintText: 'Điền ghi chú',
            controller: notePDController,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }

  Widget buildNonprescriptionDrugsForm() {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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
            label: 'Loại sử dụng',
            type: TextFieldType.textIconRight,
            state: TextFieldState.defaultState,
            hintText: 'Chọn loại sử dụng',
            controller: typeNPDController,
            iconTextInput: Icons.arrow_drop_down_sharp,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Tên loại thuốc / thực phẩm chức năng',
            hintText: 'Điền tên loại thuốc / thực phẩm chức năng',
            controller: nameNPDController,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextInput(
            label: 'Tình trạng sử dụng',
            type: TextFieldType.textIconRight,
            state: TextFieldState.defaultState,
            hintText: 'Tình trạng sử dụng hiện tại',
            controller: usageStatusNPDController,
            iconTextInput: Icons.arrow_drop_down_sharp,
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            children: [
              Expanded(
                  child: CustomTextInput(
                label: 'Bắt đầu',
                type: TextFieldType.text,
                state: TextFieldState.defaultState,
                hintText: 'Chọn thời gian',
                controller: startNPDController,
                keyboardType: TextInputType.multiline,
              )),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                  child: CustomTextInput(
                label: 'Kết thúc',
                type: TextFieldType.textIconRight,
                state: TextFieldState.defaultState,
                hintText: 'Chọn thời gian',
                controller: endNPDController,
                iconTextInput: Icons.arrow_drop_down_sharp,
              )),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Ghi chú',
            hintText: 'Điền ghi chú',
            controller: noteNPDController,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}
