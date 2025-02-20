import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/input_field/text_input.dart';
import '../../../components/registerElectronicRecords/tabItem_MedicalInformation.dart';
import '../../../design_system/color/primary_color.dart';
import '../../../design_system/selection/check_box.dart';
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
  int selectedIndex = 0;
  late TabController _tabController;

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
  final TextEditingController geneticDiseaseController = TextEditingController();
  final TextEditingController relationshipFMController = TextEditingController();
  final TextEditingController yearOfDiseaseFMController = TextEditingController();
  final TextEditingController currentMedicalConditionDiseaseFMController = TextEditingController();
  final TextEditingController noteDiseaseFMController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this); // Đặt số lượng tab ở đây
  }

  @override
  void dispose() {
    _tabController.dispose(); // Giải phóng bộ nhớ khi không sử dụng
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _toggleMedicalHistory() {
    setState(() {
      isExpandedMedicalHistory = !isExpandedMedicalHistory;
      print("isExpandedMedicalHistory: $isExpandedMedicalHistory");

    });
  }

  void _toggleFamilyHistory() {
    setState(() {
      isExpandedFamilyHistory = !isExpandedFamilyHistory;
      print("isExpandedFamilyHistory: $isExpandedFamilyHistory");

    });
  }

  // Hàm để thay đổi trạng thái của checkbox khi nhấn vào
  void handleCheckboxChanged(bool newValue) {
    setState(() {
      isChecked = newValue;
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đăng ký hồ sơ điện tử',
                  style: TextStyleCustom.heading_2a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                const SizedBox(height: 16),
                Text(
                  'Thông tin y tế cơ bản',
                  style: TextStyleCustom.heading_3a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    TabItem(
                      title: "Tiền sử\nbệnh tật",
                      state: selectedIndex == 0
                          ? TabState.selectedState
                          : TabState.defaultState,
                      onTap: () => _onTabSelected(0),
                    ),
                    const Spacer(),
                    TabItem(
                      title: "Tiền sử\ndị ứng",
                      state: selectedIndex == 1
                          ? TabState.selectedState
                          : TabState.defaultState,
                      onTap: () => _onTabSelected(1),
                    ),
                    const Spacer(),
                    TabItem(
                      title: "Tiền sử\nphẫu thuật",
                      state: selectedIndex == 2
                          ? TabState.selectedState
                          : TabState.defaultState,
                      onTap: () => _onTabSelected(2),
                    ),
                  ],
                ),
                // Nội dung tab
                SizedBox(
                  height: MediaQuery.of(context).size.height, // Cố định chiều cao cho TabBarView
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildMedicalHistoryTab(), // Tiền sử bệnh tật
                      Center(child: Text("Chưa có dữ liệu Tiền sử dị ứng")),
                      Center(child: Text("Chưa có dữ liệu Tiền sử phẫu thuật")),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMedicalHistoryTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Bệnh từng mắc phải hoặc đang chữa trị', style: TextStyleCustom.heading_3a),
          trailing: IconButton(
            icon: Icon(isExpandedMedicalHistory
                ? Icons.remove_circle_outline
                : Icons.add_circle_outline),
            onPressed: _toggleMedicalHistory,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5), // Căn lề ngang với nội dung
          child: Text(
            'Ghi chú: Bỏ qua nếu không có',
            style: TextStyleCustom.caption,
          ),
        ),
        if (isExpandedMedicalHistory) buildMedicalHistoryForm(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Bệnh di truyền', style: TextStyleCustom.heading_3a),
          trailing: IconButton(
            icon: Icon(isExpandedFamilyHistory
                ? Icons.remove_circle_outline
                : Icons.add_circle_outline),
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
        if (isExpandedFamilyHistory) buildFamilyHistoryForm(),
      ],
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
          const SizedBox(height: 12),
          CustomCheckbox(
            label: 'Yếu tố di truyền',
            isChecked: isChecked,
            isDisabled: isDisabled,
            onChanged: handleCheckboxChanged,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: CustomTextInput(
                label: 'Năm phát hiện',
                type: TextFieldType.textIconRight,
                state: TextFieldState.defaultState,
                hintText: 'Chọn năm',
                controller: yearOfDiagnosisController,
                icon: Icons.arrow_drop_down_sharp,
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
          type: TextFieldType.textIconRight,
          state: TextFieldState.defaultState,
          hintText: 'Chọn mối quan hệ',
          controller: relationshipFMController,
          icon: Icons.arrow_drop_down_sharp,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: CustomTextInput(
                  label: 'Năm phát hiện - Thành viên gia đình',
                  type: TextFieldType.textIconRight,
                  state: TextFieldState.defaultState,
                  hintText: 'Chọn năm phát hiện',
                  controller: yearOfDiseaseFMController,
                  icon: Icons.arrow_drop_down_sharp,
                )),
            const SizedBox(width: 20),
            Expanded(
                child: CustomTextInput(
                  label: 'Tình trạng hiện tại - Thành viên gia đình',
                  type: TextFieldType.textIconRight,
                  state: TextFieldState.defaultState,
                  hintText: 'Chọn tình trạng hiện tại',
                  controller: currentMedicalConditionDiseaseFMController,
                  icon: Icons.arrow_drop_down_sharp,
                )),
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
      ],
    ),
    );
  }
}
