import 'package:flutter/material.dart';
import 'package:mediaid/screens/electronicHealthRecord/basicMedicalInformation/medicalInformation.dart';

import '../../design_system/button/button.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/color/status_color.dart';
import '../../design_system/input_field/text_input.dart';
import '../../design_system/textstyle/textstyle.dart';

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
    return Scaffold(
        backgroundColor: PrimaryColor.primary_00,
        body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          height: 65,
                          width: 85,
                        ),

                        // Button display language
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
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
                                width: 32,
                                height: 32,
                              ),
                              const SizedBox(width: 12),
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
                  const SizedBox(height: 30),
                  // Text: Đăng ký hồ sơ điện tử
                  Text(
                    'Đăng ký hồ sơ điện tử',
                    style: TextStyleCustom.heading_2a
                        .copyWith(color: PrimaryColor.primary_10),
                  ),
                  const SizedBox(height: 16),
                  // Text: Thông tin bệnh nhân
                  Text(
                    'Lịch sử sử dụng thuốc gần đây',
                    style: TextStyleCustom.heading_3a
                        .copyWith(color: PrimaryColor.primary_10),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title:
                        Text('Thuốc kê đơn', style: TextStyleCustom.heading_3a),
                    trailing: CustomButton(
                      type: ButtonType.iconOnly,
                      state: ButtonState.text,
                      width: 48,
                      height: 48,
                      icon: Icons.add_circle_outline_rounded,
                      onPressed: _togglePrescriptionDrugsHistory,
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
                    visible: prescriptionDrugsForms.isNotEmpty,
                    child: Scrollbar(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: PrimaryColor.primary_10, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 450,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: prescriptionDrugsForms.map((form) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Stack(
                                  children: [
                                    form,
                                    Positioned(
                                      top: 12,
                                      right: 8,
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
                      width: 48,
                      height: 48,
                      icon: Icons.add_circle_outline_rounded,
                      onPressed: _toggleNonprescriptionDrugsHistory,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    // Căn lề ngang với nội dung
                    child: Text(
                      'Ghi chú: Bỏ qua nếu không có',
                      style: TextStyleCustom.caption,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: nonPrescriptionDrugsForms.isNotEmpty,
                    child: Scrollbar(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: PrimaryColor.primary_10, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 450,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: nonPrescriptionDrugsForms.map((form) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Stack(
                                  children: [
                                    form,
                                    Positioned(
                                      top: 12,
                                      right: 8,
                                      child: IconButton(
                                        icon: Icon(Icons.close,
                                            color: StatusColor.errorFull),
                                        // Nút xóa
                                        onPressed: () {
                                          setState(() {
                                            // Xóa form khỏi danh sách
                                            nonPrescriptionDrugsForms
                                                .remove(form);
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
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          type: ButtonType.standard,
                          state: ButtonState.fill2,
                          text: 'Quay lại',
                          width: double.infinity,
                          height: 50,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MedicalInformation()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          type: ButtonType.standard,
                          state: ButtonState.fill1,
                          text: 'Tiếp tục',
                          width: double.infinity,
                          height: 50,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DrugHistory()),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
        );
  }

  Widget buildPrescriptionDrugsForm() {
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
            label: 'Tên loại thuốc',
            hintText: 'Điền tên loại thuốc',
            controller: namePDController,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 16),
          CustomTextInput(
            label: 'Tình trạng sử dụng',
            type: TextFieldType.textIconRight,
            state: TextFieldState.defaultState,
            hintText: 'Tình trạng sử dụng hiện tại',
            controller: usageStatusPDController,
            icon: Icons.arrow_drop_down_sharp,
          ),
          const SizedBox(height: 16),
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
              const SizedBox(width: 20),
              Expanded(
                  child: CustomTextInput(
                label: 'Kết thúc',
                type: TextFieldType.textIconRight,
                state: TextFieldState.defaultState,
                hintText: 'Chọn thời gian',
                controller: endPDController,
                icon: Icons.arrow_drop_down_sharp,
              )),
            ],
          ),
          const SizedBox(height: 16),
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
            label: 'Loại sử dụng',
            type: TextFieldType.textIconRight,
            state: TextFieldState.defaultState,
            hintText: 'Chọn loại sử dụng',
            controller: typeNPDController,
            icon: Icons.arrow_drop_down_sharp,
          ),
          const SizedBox(height: 16),
          CustomTextInput(
            type: TextFieldType.text,
            state: TextFieldState.defaultState,
            label: 'Tên loại thuốc / thực phẩm chức năng',
            hintText: 'Điền tên loại thuốc / thực phẩm chức năng',
            controller: nameNPDController,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 16),
          CustomTextInput(
            label: 'Tình trạng sử dụng',
            type: TextFieldType.textIconRight,
            state: TextFieldState.defaultState,
            hintText: 'Tình trạng sử dụng hiện tại',
            controller: usageStatusNPDController,
            icon: Icons.arrow_drop_down_sharp,
          ),
          const SizedBox(height: 16),
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
              const SizedBox(width: 20),
              Expanded(
                  child: CustomTextInput(
                label: 'Kết thúc',
                type: TextFieldType.textIconRight,
                state: TextFieldState.defaultState,
                hintText: 'Chọn thời gian',
                controller: endNPDController,
                icon: Icons.arrow_drop_down_sharp,
              )),
            ],
          ),
          const SizedBox(height: 16),
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
