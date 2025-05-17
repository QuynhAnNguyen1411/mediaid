import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/input_field/text_input.dart';
import '../../../../../api/electronicHealthRecordAPI/basicMedicalInformationAPI/patientHistory_api.dart';
import '../../../../../design_system/button/button.dart';
import '../../../../../design_system/color/primary_color.dart';
import '../../../../../design_system/textstyle/textstyle.dart';
import '../../../../../models/electronicHealthRecordModel/personalInformation/levelModel.dart';
import '../../../../../models/electronicHealthRecordModel/personalInformation/medicalHistoryForm.dart';
import '../../../../../models/electronicHealthRecordModel/personalInformation/treatmentMethodModel.dart';
import '../../../../../util/spacingStandards.dart';

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MedicalHistoryState();
  }
}

class _MedicalHistoryState extends State<MedicalHistory> {
  bool isMedicalHistoryValid = false;

  // Controller Bệnh từng mắc hoặc đang điều trị
  final TextEditingController medicalHistoryIDController =
      TextEditingController();
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

  // Danh sách chứa các form nhập liệu
  List<Widget> medicalHistoryForms = [];

  //Dropdown
  late List<LevelModel> levelList = [];
  late List<TreatmentMethodModel> treatmentMethodList = [];

  int? _selectedLevelID;
  int? _selectedTreatmentMethodID;

  void _validateForm() {
    setState(() {
      isMedicalHistoryValid = typeOfDiseaseController.text.isNotEmpty &&
          yearOfDiagnosisController.text.isNotEmpty;
    });
  }

  // dropdown
  Future<void> _fetchDropdownDataMedicalHistory() async {
    try {
      Map<String, List<Object>>? response =
          await PatientHistoryApi.getStaticDataForPatientHistory();

      if (response != null) {
        setState(() {
          levelList = (response['mucDo'] as List<LevelModel>).toList();
          treatmentMethodList =
              (response['phuongPhapDieuTri'] as List<TreatmentMethodModel>)
                  .toList();
        });

        print("✅ Đã cập nhật danh sách Mức độ: $levelList");
        print(
            "✅ Đã cập nhật danh sách Phương pháp điều trị: $treatmentMethodList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
  }

  // Hàm gửi dữ liệu form khi nhấn nút "Lưu thông tin" - Tiểu sử bệnh tật
  Future<void> _submitFormMedicalHistory() async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');
    MedicalHistoryForm form = MedicalHistoryForm(
      medicalHistoryID: medicalHistoryIDController.text,
      accountID: accountID,
      typeOfDisease: typeOfDiseaseController.text,
      yearOfDiagnosis: yearOfDiagnosisController.text,
      medicalLevel: _selectedLevelID ?? 1,
      treatmentMethod: _selectedTreatmentMethodID ?? 1,
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

  void _resetFormMedicalHistory() {
    typeOfDiseaseController.clear();
    yearOfDiagnosisController.clear();
    complicationsController.clear();
    hospitalTreatmentController.clear();
    noteDiseaseController.clear();
    setState(() {
      _selectedLevelID = null;
      _selectedTreatmentMethodID = null;
    });
  }

  List<MedicalHistoryForm> medicalHistoryList = [];

  late Future<List<MedicalHistoryForm>> medicalHistoryListRender;

  // Load data form tóm tắt - Tiểu sử bệnh tật
  Future<List<MedicalHistoryForm>> _loadMedicalHistoryData() async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');
    List<MedicalHistoryForm> medicalHistory =
        await PatientHistoryApi.getMedicalHistoryData(
            accountID, 'TieuSuBenhTat');
    setState(() {
      medicalHistoryList = medicalHistory;
    });
    return medicalHistory;
  }

  // Xóa form Tiểu sử bệnh tật
  Future<void> _deleteMedicalHistoryForm(
      String? tieuSuYTeID, String type) async {
    if (tieuSuYTeID == null) {
      return;
    }
    // Gọi API để xóa mục theo ID
    await PatientHistoryApi.deleteMedicalHistoryForm(tieuSuYTeID, type);

    // Gọi lại hàm tải lại danh sách
    _loadMedicalHistoryData();
  }

  @override
  void initState() {
    super.initState();
    typeOfDiseaseController.addListener(_validateForm);
    yearOfDiagnosisController.addListener(_validateForm);
    _fetchDropdownDataMedicalHistory();
    medicalHistoryListRender = _loadMedicalHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final iconSize = IconSizeUtil();
    String option1 = 'Chỉnh sửa';
    String option2 = 'Xóa';
    return Scaffold(
        backgroundColor: PrimaryColor.primary_00,
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<MedicalHistoryForm>>(
                future: medicalHistoryListRender,
                builder: (context, snapshot) {
                  // Kiểm tra trạng thái kết nối với Future
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Nếu dữ liệu đang được tải, hiển thị loading indicator
                    return Center(child: CircularProgressIndicator());
                  }
                  // Nếu có lỗi xảy ra khi tải dữ liệu
                  else if (snapshot.hasError) {
                    return Center(
                        child: Text('Có lỗi xảy ra: ${snapshot.error}'));
                  }
                  // Nếu không có dữ liệu (null)
                  else if (!snapshot.hasData) {
                    return Center(child: Text('Không có dữ liệu bệnh nhân'));
                  }

                  // Dữ liệu đã được tải thành công
                  var medicalHistoryData = snapshot.data;

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
                            width: iconSize.mediumIcon(context),
                            height: iconSize.mediumIcon(context),
                            icon: Icons.add_circle_outline_rounded,
                            onPressed: () => _showMedicalHistory(context, null),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SpacingUtil.spacingHeight8(context)),
                          child: Text(
                            'Ghi chú: Bỏ qua nếu không có',
                            style: TextStyleCustom.bodySmall,
                          ),
                        ),
                        SizedBox(height: SpacingUtil.spacingHeight16(context)),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: medicalHistoryList.length,
                            itemBuilder: (context, index) {
                              var medicalHistoryData =
                                  medicalHistoryList[index];
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: PrimaryColor.primary_00,
                                    border: Border.all(
                                      color: PrimaryColor.primary_10,
                                      width: 1.2,
                                    )),
                                margin: EdgeInsets.symmetric(
                                    vertical:
                                        SpacingUtil.spacingHeight12(context)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SpacingUtil.spacingWidth12(context),
                                      vertical:
                                          SpacingUtil.spacingHeight12(context)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(medicalHistoryData.typeOfDisease,
                                              style: TextStyleCustom.bodyLarge
                                                  .copyWith(
                                                      color: PrimaryColor
                                                          .primary_10)),
                                          SizedBox(
                                              width: SpacingUtil.spacingWidth12(
                                                  context)),
                                          Text('-'),
                                          SizedBox(
                                              width: SpacingUtil.spacingWidth12(
                                                  context)),
                                          Text(
                                              medicalHistoryData
                                                  .yearOfDiagnosis,
                                              style: TextStyleCustom.bodySmall
                                                  .copyWith(
                                                      color: NeutralColor
                                                          .neutral_08)),
                                        ],
                                      ),
                                      PopupMenuTheme(
                                        data: PopupMenuThemeData(
                                          color: PrimaryColor.primary_00,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: PopupMenuButton<String>(
                                          icon: Icon(Icons.more_vert),
                                          onSelected: (String newValue) {
                                            if (newValue == option1) {
                                              _showMedicalHistory(
                                                  context, medicalHistoryData);
                                            } else if (newValue == option2) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: Text(
                                                            'Xác nhận xóa'),
                                                        content: Text(
                                                            'Bạn có chắc chắn muốn xóa mục này không?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text('Không'),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                              await _deleteMedicalHistoryForm(
                                                                  medicalHistoryData
                                                                      .medicalHistoryID,
                                                                  "TieuSuBenhTat");
                                                              setState(() {
                                                                medicalHistoryList
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                            },
                                                            child: Text('Có'),
                                                          ),
                                                        ],
                                                      ));
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              [
                                            PopupMenuItem<String>(
                                              value: option1,
                                              child: Text(option1,
                                                  style: TextStyleCustom
                                                      .bodySmall),
                                            ),
                                            PopupMenuItem<String>(
                                              value: option2,
                                              child: Text(option2,
                                                  style: TextStyleCustom
                                                      .bodySmall),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  );
                }),
          ],
        )));
  }

  void _showMedicalHistory(
      BuildContext context, MedicalHistoryForm? medicalHistoryForm) {
    if (medicalHistoryForm != null) {
      medicalHistoryIDController.text =
          medicalHistoryForm.medicalHistoryID ?? '';
      typeOfDiseaseController.text = medicalHistoryForm.typeOfDisease;
      yearOfDiagnosisController.text = medicalHistoryForm.yearOfDiagnosis;
      _selectedLevelID = medicalHistoryForm.medicalLevel;
      _selectedTreatmentMethodID = medicalHistoryForm.treatmentMethod;
      complicationsController.text = medicalHistoryForm.complications;
      hospitalTreatmentController.text = medicalHistoryForm.hospitalTreatment;
      noteDiseaseController.text = medicalHistoryForm.noteDisease;
    }
    showModalBottomSheet(
        backgroundColor: PrimaryColor.primary_00,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          final iconSize = IconSizeUtil();
          return Scaffold(
              backgroundColor: PrimaryColor.primary_00,
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                      SpacingUtil.spacingWidth16(context),
                      SpacingUtil.spacingHeight56(context),
                      SpacingUtil.spacingWidth16(context),
                      SpacingUtil.spacingHeight24(context)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: screenWidth * 0.8,
                            ),
                            child: Text(
                              'Bệnh đang điều trị hoặc từng mắc phải',
                              style: TextStyleCustom.heading_2b
                                  .copyWith(color: PrimaryColor.primary_10),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close,
                                  size: iconSize.largeIcon(context),
                                  color: StatusColor.errorFull)),
                        ],
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight24(context)),
                      Divider(
                        color: NeutralColor.neutral_03,
                        thickness: 1.2,
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      CustomTextInput(
                        type: TextFieldType.text,
                        state: TextFieldState.defaultState,
                        label: 'Loại bệnh',
                        hintText: 'Điền loại bệnh mắc phải',
                        isRequired: true,
                        controller: typeOfDiseaseController,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextInput(
                            label: 'Năm phát hiện',
                            type: TextFieldType.text,
                            state: TextFieldState.defaultState,
                            hintText: 'Điền năm',
                            isRequired: true,
                            controller: yearOfDiagnosisController,
                            keyboardType: TextInputType.multiline,
                          )),
                          SizedBox(width: SpacingUtil.spacingWidth12(context)),
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
                                                  style: TextStyleCustom
                                                      .heading_3c),
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
                                                        height: SpacingUtil
                                                            .spacingHeight12(
                                                                context)),
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
                                                        height: SpacingUtil
                                                            .spacingHeight12(
                                                                context)),
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
                                        width: iconSize.mediumIcon(context),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height:
                                        SpacingUtil.spacingHeight12(context)),
                                DropdownButtonFormField<int>(
                                  value: _selectedLevelID,
                                  hint: Text(
                                    'Chọn mức độ',
                                    style: TextStyleCustom.bodySmall.copyWith(
                                        color: NeutralColor.neutral_06),
                                  ),
                                  isExpanded: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                            SpacingUtil.spacingWidth12(context),
                                        vertical: SpacingUtil.spacingHeight16(
                                            context)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: NeutralColor.neutral_04,
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: NeutralColor.neutral_04,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  dropdownColor: PrimaryColor.primary_00,
                                  items: levelList.map((mucDo) {
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
                                      _selectedLevelID = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      Column(
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
                                            style: TextStyleCustom.heading_3c),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "• Điều trị nội khoa (dùng thuốc):",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Thuốc giảm đau, Thuốc kháng sinh, Thuốc chống viêm, Thuốc hạ huyết áp, "
                                                "Thuốc điều trị tiểu đường, Thuốc điều trị bệnh lý tim mạch, Thuốc kháng histamine, "
                                                "Thuốc chống lo âu hoặc trầm cảm...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),
                                              // Điều trị phẫu thuật
                                              Text(
                                                "• Điều trị phẫu thuật:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Phẫu thuật cấp cứu, Phẫu thuật chỉnh hình, Phẫu thuật tim mạch, Phẫu thuật thần kinh, "
                                                "Phẫu thuật nội soi...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),

                                              // Điều trị bằng liệu pháp vật lý
                                              Text(
                                                "• Điều trị bằng liệu pháp vật lý:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Vật lý trị liệu, Massage trị liệu, Xung điện trị liệu, Điều trị bằng nhiệt hoặc lạnh, "
                                                "Châm cứu...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),

                                              // Điều trị tâm lý
                                              Text(
                                                "• Điều trị tâm lý:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Tâm lý trị liệu, Liệu pháp nhóm, Liệu pháp thư giãn, Điều trị bằng thuốc an thần hoặc chống trầm cảm...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),

                                              // Điều trị bằng dinh dưỡng
                                              Text(
                                                "• Điều trị bằng dinh dưỡng:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Chế độ ăn đặc biệt, Bổ sung vitamin và khoáng chất, Điều trị bằng chế độ ăn giảm muối hoặc giảm đường, "
                                                "Dinh dưỡng qua ống thông...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),

                                              // Điều trị bằng vật lý và các phương pháp thay thế
                                              Text(
                                                "• Điều trị bằng vật lý và các phương pháp thay thế:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Điều trị bằng phương pháp thay thế, Điều trị bằng thảo dược, Điều trị bằng phương pháp nắn chỉnh...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),

                                              // Điều trị bằng liệu pháp hormon
                                              Text(
                                                "• Điều trị bằng liệu pháp hormon:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Thay thế hormon, Liệu pháp hormon tăng trưởng...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),

                                              // Điều trị bằng phóng xạ
                                              Text(
                                                "• Điều trị bằng phóng xạ (xạ trị):",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Xạ trị, Điều trị bằng isotopes phóng xạ...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),

                                              // Điều trị bằng truyền máu
                                              Text(
                                                "• Điều trị bằng truyền máu:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Truyền máu, Truyền huyết thanh...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),

                                              // Điều trị bằng các phương pháp chăm sóc đặc biệt
                                              Text(
                                                "• Điều trị bằng các phương pháp chăm sóc đặc biệt:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Hồi sức cấp cứu, Chăm sóc giảm nhẹ, Chăm sóc tại nhà...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),

                                              // Điều trị bằng liệu pháp miễn dịch
                                              Text(
                                                "• Điều trị bằng liệu pháp miễn dịch:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Điều trị miễn dịch, Vaccine...",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(
                                                        color: NeutralColor
                                                            .neutral_06),
                                              ),
                                              SizedBox(
                                                  height: SpacingUtil
                                                      .spacingHeight12(
                                                          context)),
                                              // Điều trị thay thế cơ quan
                                              Text(
                                                "• Điều trị thay thế cơ quan:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(
                                                        color: PrimaryColor
                                                            .primary_10),
                                              ),
                                              Text(
                                                "Ví dụ: Lọc thận (Dialysis), Ghép tạng...",
                                                style: TextStyleCustom.bodySmall
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
                                                style: TextStyleCustom.bodyLarge
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
                                  width: iconSize.mediumIcon(context),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SpacingUtil.spacingHeight12(context)),
                          DropdownButtonFormField<int>(
                            value: _selectedTreatmentMethodID,
                            hint: Text(
                              'Chọn phương pháp điều trị',
                              style: TextStyleCustom.bodySmall
                                  .copyWith(color: NeutralColor.neutral_06),
                            ),
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      SpacingUtil.spacingWidth12(context),
                                  vertical:
                                      SpacingUtil.spacingHeight16(context)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: NeutralColor.neutral_04,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: NeutralColor.neutral_04,
                                  width: 2,
                                ),
                              ),
                            ),
                            dropdownColor: PrimaryColor.primary_00,
                            items: treatmentMethodList.map((phuongPhapDieuTri) {
                              return DropdownMenuItem<int>(
                                value: phuongPhapDieuTri.treatmentMethodID,
                                child: Text(
                                  phuongPhapDieuTri.treatmentMethodName,
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(color: PrimaryColor.primary_10),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedTreatmentMethodID = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      CustomTextInput(
                        type: TextFieldType.text,
                        state: TextFieldState.defaultState,
                        label: 'Biến chứng',
                        hintText: 'Điền các loại biến chứng gặp phải',
                        controller: complicationsController,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      CustomTextInput(
                        type: TextFieldType.text,
                        state: TextFieldState.defaultState,
                        label: 'Bệnh viện điều trị',
                        hintText: 'Điền tên bệnh viện điều trị',
                        controller: hospitalTreatmentController,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      CustomTextInput(
                        type: TextFieldType.text,
                        state: TextFieldState.defaultState,
                        label: 'Ghi chú',
                        hintText: 'Điền ghi chú',
                        controller: noteDiseaseController,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight24(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomButton(
                              type: ButtonType.standard,
                              state: ButtonState.outline,
                              text: 'Xóa thông tin',
                              width: double.infinity,
                              height: SpacingUtil.spacingHeight56(context),
                              onPressed: () {
                                _resetFormMedicalHistory();
                              },
                            ),
                          ),
                          SizedBox(width: SpacingUtil.spacingWidth12(context)),
                          Expanded(
                            child: CustomButton(
                              type: ButtonType.standard,
                              state: isMedicalHistoryValid
                                  ? ButtonState.fill1
                                  : ButtonState.disabled,
                              text: 'Lưu thông tin',
                              width: double.infinity,
                              height: SpacingUtil.spacingHeight56(context),
                              onPressed: isMedicalHistoryValid
                                  ? () {
                                      _submitFormMedicalHistory();
                                    }
                                  : null,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
