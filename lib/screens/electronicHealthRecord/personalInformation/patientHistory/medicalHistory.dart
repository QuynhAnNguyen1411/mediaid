import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/api/electronicHealthRecord/patientHistory_api.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/input_field/text_input.dart';
import 'package:mediaid/models/electronicHealthRecord/personalInformation/level.dart';
import 'package:mediaid/models/electronicHealthRecord/personalInformation/medicalHistory.dart';
import 'package:mediaid/models/electronicHealthRecord/personalInformation/treatmentMethod.dart';
import '../../../../design_system/button/button.dart';
import '../../../../design_system/color/primary_color.dart';
import '../../../../design_system/textstyle/textstyle.dart';
import '../../../../models/electronicHealthRecord/personalInformation/geneticDiseaseHistory.dart';

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MedicalHistoryState();
  }
}

class _MedicalHistoryState extends State<MedicalHistory> {
  bool isExpandedMedicalHistory = false;
  bool isExpandedFamilyHistory = false;

  bool isChecked = false;
  bool isDisabled = false;


  String _typeOfDisease = '';
  String _yearOfDiagnosis = '';
  String _treatmentMethod = '';

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

  // dropdown
  Future<void> _fetchDropdownDataMedicalHistory() async {
    try {
      Map<String, List<Object>>? response =
      await PatientHistoryApi.getStaticDataForPatientHistory();

      if (response != null) {
        print("a");
        setState(() {
          mucDoList = (response['mucDo'] as List<Level>).toList();
          phuongPhapDieuTriList =
              (response['phuongPhapDieuTri'] as List<TreatmentMethod>).toList();
        });

        print("✅ Đã cập nhật danh sách Mức độ: $mucDoList");
        print(
            "✅ Đã cập nhật danh sách Phương pháp điều trị: $phuongPhapDieuTriList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
  }

  // Hàm gửi dữ liệu form khi nhấn nút "Lưu thông tin" - Tiểu sử bệnh tật
  Future<void> _submitFormMedicalHistory() async {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');
    MedicalHistoryForm form = MedicalHistoryForm(
      accountID: accountID,
      typeOfDisease: typeOfDiseaseController.text,
      yearOfDiagnosis: yearOfDiagnosisController.text,
      medicalLevel: _selectedMucdoId ?? 1,
      treatmentMethod: _selectedPhuongphapdieutriId ?? 1,
      complications: complicationsController.text,
      hospitalTreatment: hospitalTreatmentController.text,
      noteDisease: noteDiseaseController.text,
    );

    // Gửi form đến API
    try {
      print(form.toJson());
      await PatientHistoryApi.submitFormMedicalHistory(form);
      print('Form đã được gửi thành công.');
    } catch (e) {
      print('Có lỗi xảy ra khi gửi form: $e');
    }
    Navigator.pop(context);
  }

  // Hàm gửi dữ liệu form khi nhấn nút "Lưu thông tin" - Tiểu sử bệnh di truyền
  Future<void> _submitFormGeneticDiseaseHistory() async {
    GeneticDiseaseHistoryForm form = GeneticDiseaseHistoryForm(
      geneticDisease: geneticDiseaseController.text,
      relationshipFM: relationshipFMController.text,
      yearOfDiseaseFM: yearOfDiseaseFMController.text,
      noteDiseaseFM: noteDiseaseFMController.text,
      medicalLevelFM: _selectedMucdoId ?? 1,
    );

    // Gửi form đến API
    try {
      print(form.toJson());
      await PatientHistoryApi.submitFormGeneticDiseaseHistory(form);
      print('Form đã được gửi thành công.');
    } catch (e) {
      print('Có lỗi xảy ra khi gửi form: $e');
    }
  }

  void _resetFormMedicalHistory() {
    typeOfDiseaseController.clear();
    yearOfDiagnosisController.clear();
    complicationsController.clear();
    hospitalTreatmentController.clear();
    noteDiseaseController.clear();
    setState(() {
      _selectedMucdoId = null;
      _selectedPhuongphapdieutriId = null;
    });
  }

  void _resetFormFamilyHistory() {
    geneticDiseaseController.clear();
    relationshipFMController.clear();
    yearOfDiseaseFMController.clear();
    noteDiseaseFMController.clear();
    setState(() {
      _selectedMucdoId = null;
    });
  }
  bool _isMedicalHistoryDataSent = false;
  MedicalHistoryForm? medicalHistoryData;
  void _loadMedicalHistoryData() async {
    print("avmef");
    try {
      var box = await Hive.openBox('loginBox');
      String accountID = await box.get('accountID');
      var medicalHistory = await PatientHistoryApi.getMedicalHistoryData(accountID);
      print(medicalHistory);
      if (medicalHistory == null) {
        setState(() {
          _isMedicalHistoryDataSent = false;
          medicalHistoryData = null;
        });
      } else {
        setState(() {
          _isMedicalHistoryDataSent = true;
          medicalHistoryData = medicalHistory;
        });
      }
      print("Is Medical History Data Sent: $_isMedicalHistoryDataSent");
    } catch (error) {
      print("Error loading medical history data: $error");
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchDropdownDataMedicalHistory();
    _loadMedicalHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Bệnh từng mắc phải hoặc đang chữa trị', style: TextStyleCustom.heading_3a),
            trailing: CustomButton(
              type: ButtonType.iconOnly,
              state: ButtonState.text,
              width: screenWidth * 0.1,
              height: screenHeight * 0.05,
              icon: Icons.add_circle_outline_rounded,
              onPressed: () => _showMedicalHistory(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.001),
            child: Text(
              'Ghi chú: Bỏ qua nếu không có',
              style: TextStyleCustom.caption,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          _isMedicalHistoryDataSent ? Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.02
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(medicalHistoryData!.typeOfDisease),
                        SizedBox(width: screenWidth * 0.02),
                        Text('-'),
                        SizedBox(width: screenWidth * 0.02),
                        Text(medicalHistoryData!.yearOfDiagnosis),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(medicalHistoryData!.treatmentMethod as String),
                  ],
                ),
                SvgPicture.asset(
                  "assets/icons/electronicHealthRecord/dots.svg",
                  width: screenWidth * 0.06,
                  height: screenHeight * 0.02,
                ),
              ],
            ),
          ) : Text (" "),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Bệnh di truyền', style: TextStyleCustom.heading_3a),
            trailing: CustomButton(
              type: ButtonType.iconOnly,
              state: ButtonState.text,
              width: screenWidth * 0.1,
              height: screenHeight * 0.05,
              icon: Icons.add_circle_outline_rounded,
              onPressed: () => _showFamilyHistory(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.001),
            child: Text('Ghi chú: Bỏ qua nếu không có', style: TextStyleCustom.caption),
          ),
        ],
      ),
    );
  }


  void _showMedicalHistory(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: PrimaryColor.primary_00,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var screenWidth = MediaQuery
              .of(context)
              .size
              .width;
          var screenHeight = MediaQuery
              .of(context)
              .size
              .height;
          return Scaffold(
            backgroundColor: PrimaryColor.primary_00,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.04, screenHeight * 0.08,
                      screenWidth * 0.04, screenHeight * 0.02),
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      'Mức độ',
                                      style: TextStyleCustom.heading_3b
                                          .copyWith(
                                          color: PrimaryColor.primary_10),
                                    ),
                                    GestureDetector(
                                      // Thêm GestureDetector để xử lý sự kiện onTap
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  "Mức độ tình trạng bệnh",
                                                  style:
                                                  TextStyleCustom.heading_3c),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    // Nhẹ
                                                    Text(
                                                      "• Nhẹ:",
                                                      style: TextStyleCustom
                                                          .bodyLarge
                                                          .copyWith(
                                                          color: PrimaryColor
                                                              .primary_10),
                                                    ),
                                                    Text(
                                                      "Bệnh không ảnh hưởng nhiều đến cuộc sống, không cần điều trị đặc biệt.",
                                                      style: TextStyleCustom
                                                          .bodySmall
                                                          .copyWith(
                                                          color: NeutralColor
                                                              .neutral_06),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                        screenHeight * 0.015),
                                                    // Vừa
                                                    Text(
                                                      "• Vừa:",
                                                      style: TextStyleCustom
                                                          .bodyLarge
                                                          .copyWith(
                                                          color: PrimaryColor
                                                              .primary_10),
                                                    ),
                                                    Text(
                                                      "Bệnh có thay đổi nhưng vẫn kiểm soát được, cần điều trị theo dõi.",
                                                      style: TextStyleCustom
                                                          .bodySmall
                                                          .copyWith(
                                                          color: NeutralColor
                                                              .neutral_06),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                        screenHeight * 0.015),
                                                    // Nặng
                                                    Text(
                                                      "• Nặng:",
                                                      style: TextStyleCustom
                                                          .bodyLarge
                                                          .copyWith(
                                                          color: PrimaryColor
                                                              .primary_10),
                                                    ),
                                                    Text(
                                                      "Bệnh tiến triển nghiêm trọng, cần điều trị chuyên sâu và theo dõi thường xuyên.",
                                                      style: TextStyleCustom
                                                          .bodySmall
                                                          .copyWith(
                                                          color: NeutralColor
                                                              .neutral_06),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Đóng dialog
                                                  },
                                                  child: Text("Đóng",
                                                      style: TextStyleCustom
                                                          .bodyLarge
                                                          .copyWith(
                                                          color: PrimaryColor
                                                              .primary_05)),
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
                                SizedBox(height: screenHeight * 0.01),
                                DropdownButtonFormField<int>(
                                  value: _selectedMucdoId,
                                  hint: Text(
                                    'Chọn mức độ',
                                    style: TextStyleCustom.bodySmall
                                        .copyWith(
                                        color: NeutralColor.neutral_06),
                                  ),
                                  isExpanded: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.03,
                                        vertical: screenHeight * 0.018),
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
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                            color: PrimaryColor.primary_10),
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.02,
                            bottom: screenHeight * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Phương pháp điều trị',
                                  style: TextStyleCustom.heading_3b
                                      .copyWith(color: PrimaryColor.primary_10),
                                ),
                                GestureDetector(
                                  // Thêm GestureDetector để xử lý sự kiện onTap
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Phương pháp điều trị chính",
                                              style: TextStyleCustom
                                                  .heading_3c),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "• Điều trị nội khoa (dùng thuốc):",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Thuốc giảm đau, Thuốc kháng sinh, Thuốc chống viêm, Thuốc hạ huyết áp, "
                                                      "Thuốc điều trị tiểu đường, Thuốc điều trị bệnh lý tim mạch, Thuốc kháng histamine, "
                                                      "Thuốc chống lo âu hoặc trầm cảm...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị phẫu thuật
                                                Text(
                                                  "• Điều trị phẫu thuật:",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Phẫu thuật cấp cứu, Phẫu thuật chỉnh hình, Phẫu thuật tim mạch, Phẫu thuật thần kinh, "
                                                      "Phẫu thuật nội soi...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị bằng liệu pháp vật lý
                                                Text(
                                                  "• Điều trị bằng liệu pháp vật lý:",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Vật lý trị liệu, Massage trị liệu, Xung điện trị liệu, Điều trị bằng nhiệt hoặc lạnh, "
                                                      "Châm cứu...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị tâm lý
                                                Text(
                                                  "• Điều trị tâm lý:",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Tâm lý trị liệu, Liệu pháp nhóm, Liệu pháp thư giãn, Điều trị bằng thuốc an thần hoặc chống trầm cảm...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị bằng dinh dưỡng
                                                Text(
                                                  "• Điều trị bằng dinh dưỡng:",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Chế độ ăn đặc biệt, Bổ sung vitamin và khoáng chất, Điều trị bằng chế độ ăn giảm muối hoặc giảm đường, "
                                                      "Dinh dưỡng qua ống thông...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị bằng vật lý và các phương pháp thay thế
                                                Text(
                                                  "• Điều trị bằng vật lý và các phương pháp thay thế:",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Điều trị bằng phương pháp thay thế, Điều trị bằng thảo dược, Điều trị bằng phương pháp nắn chỉnh...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị bằng liệu pháp hormon
                                                Text(
                                                  "• Điều trị bằng liệu pháp hormon:",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Thay thế hormon, Liệu pháp hormon tăng trưởng...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị bằng phóng xạ
                                                Text(
                                                  "• Điều trị bằng phóng xạ (xạ trị):",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Xạ trị, Điều trị bằng isotopes phóng xạ...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị bằng truyền máu
                                                Text(
                                                  "• Điều trị bằng truyền máu:",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Truyền máu, Truyền huyết thanh...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị bằng các phương pháp chăm sóc đặc biệt
                                                Text(
                                                  "• Điều trị bằng các phương pháp chăm sóc đặc biệt:",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Hồi sức cấp cứu, Chăm sóc giảm nhẹ, Chăm sóc tại nhà...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị bằng liệu pháp miễn dịch
                                                Text(
                                                  "• Điều trị bằng liệu pháp miễn dịch:",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Điều trị miễn dịch, Vaccine...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                                SizedBox(
                                                    height: screenHeight *
                                                        0.02),
                                                // Khoảng cách giữa các phần

                                                // Điều trị thay thế cơ quan
                                                Text(
                                                  "• Điều trị thay thế cơ quan:",
                                                  style: TextStyleCustom
                                                      .bodyLarge
                                                      .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10),
                                                ),
                                                Text(
                                                  "Ví dụ: Lọc thận (Dialysis), Ghép tạng...",
                                                  style: TextStyleCustom
                                                      .bodySmall
                                                      .copyWith(
                                                      color: NeutralColor
                                                          .neutral_06),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Đóng dialog
                                              },
                                              child: Text("Đóng",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue)),
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
                            SizedBox(height: screenHeight * 0.01),
                            DropdownButtonFormField<int>(
                              value: _selectedPhuongphapdieutriId,
                              hint: Text(
                                'Chọn phương pháp điều trị',
                                style: TextStyleCustom.bodySmall
                                    .copyWith(color: NeutralColor.neutral_06),
                              ),
                              isExpanded: true,
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.018),
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
                              items: phuongPhapDieuTriList.map((
                                  phuongPhapDieuTri) {
                                return DropdownMenuItem<int>(
                                  value: phuongPhapDieuTri.treatmentMethodID,
                                  child: Text(
                                    phuongPhapDieuTri.treatmentMethodName,
                                    style: TextStyleCustom.bodySmall
                                        .copyWith(
                                        color: PrimaryColor.primary_10),
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
                                _resetFormMedicalHistory();
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
                                _submitFormMedicalHistory();
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                )
            ),
          );
        });
  }

  void _showFamilyHistory(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: PrimaryColor.primary_00,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          var screenWidth = MediaQuery
              .of(context)
              .size
              .width;
          var screenHeight = MediaQuery
              .of(context)
              .size
              .height;
          return Scaffold(
            backgroundColor: PrimaryColor.primary_00,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.04, screenHeight * 0.08, screenWidth * 0.04,
                    screenHeight * 0.02),
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
                      label: 'Thành viên gia đình mắc bệnh',
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Mức độ',
                                    style: TextStyleCustom.heading_3b.copyWith(
                                        color: PrimaryColor.primary_10),
                                  ),
                                  GestureDetector(
                                    // Thêm GestureDetector để xử lý sự kiện onTap
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                "Mức độ tình trạng bệnh",
                                                style:
                                                TextStyleCustom.heading_3c),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  // Nhẹ
                                                  Text(
                                                    "• Nhẹ:",
                                                    style: TextStyleCustom
                                                        .bodyLarge
                                                        .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                                  ),
                                                  Text(
                                                    "Bệnh không ảnh hưởng nhiều đến cuộc sống, không cần điều trị đặc biệt.",
                                                    style: TextStyleCustom
                                                        .bodySmall
                                                        .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                      screenHeight * 0.015),
                                                  // Vừa
                                                  Text(
                                                    "• Vừa:",
                                                    style: TextStyleCustom
                                                        .bodyLarge
                                                        .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                                  ),
                                                  Text(
                                                    "Bệnh có thay đổi nhưng vẫn kiểm soát được, cần điều trị theo dõi.",
                                                    style: TextStyleCustom
                                                        .bodySmall
                                                        .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                      screenHeight * 0.015),
                                                  // Nặng
                                                  Text(
                                                    "• Nặng:",
                                                    style: TextStyleCustom
                                                        .bodyLarge
                                                        .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                                  ),
                                                  Text(
                                                    "Bệnh tiến triển nghiêm trọng, cần điều trị chuyên sâu và theo dõi thường xuyên.",
                                                    style: TextStyleCustom
                                                        .bodySmall
                                                        .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Đóng dialog
                                                },
                                                child: Text("Đóng",
                                                    style: TextStyleCustom
                                                        .bodyLarge
                                                        .copyWith(
                                                        color: PrimaryColor
                                                            .primary_05)),
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
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(color: NeutralColor.neutral_06),
                                ),
                                isExpanded: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.03,
                                      vertical: screenHeight * 0.018),
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
                                      style: TextStyleCustom.bodySmall.copyWith(
                                          color: PrimaryColor.primary_10),
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
                    CustomTextInput(
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      label: 'Ghi chú',
                      hintText: 'Điền ghi chú',
                      controller: noteDiseaseFMController,
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
                              _resetFormFamilyHistory();
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
                              _submitFormGeneticDiseaseHistory();
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
