import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/input_field/text_input.dart';
import 'package:mediaid/models/electronicHealthRecordModel/personalInformation/levelModel.dart';
import '../../../../../api/electronicHealthRecordAPI/basicMedicalInformationAPI/patientHistory_api.dart';
import '../../../../../design_system/button/button.dart';
import '../../../../../design_system/color/primary_color.dart';
import '../../../../../design_system/textstyle/textstyle.dart';
import '../../../../../models/electronicHealthRecordModel/personalInformation/geneticDiseaseHistoryForm.dart';
import '../../../../../util/spacingStandards.dart';

class GeneticDiseaseHistory extends StatefulWidget {
  const GeneticDiseaseHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GeneticDiseaseHistoryState();
  }
}

class _GeneticDiseaseHistoryState extends State<GeneticDiseaseHistory> {
  bool isFamilyHistoryValid = false;

  bool isChecked = false;
  bool isDisabled = false;

  // Controller Bệnh di truyền - FM: Family Member
  final TextEditingController geneticDiseaseHistoryIDController =
      TextEditingController();
  final TextEditingController geneticDiseaseController =
      TextEditingController();
  final TextEditingController relationshipController =
      TextEditingController();
  final TextEditingController yearOfDiseaseController =
      TextEditingController();
  final TextEditingController medicalLevelController =
      TextEditingController();
  final TextEditingController noteDiseaseController = TextEditingController();

  // Danh sách chứa các form nhập liệu
  List<Widget> familyHistoryForms = [];

  //Dropdown
  late List<LevelModel> mucDoList = [];

  int? _selectedMucdoId;

  void _validateForm() {
    setState(() {
      isFamilyHistoryValid = geneticDiseaseController.text.isNotEmpty &&
          yearOfDiseaseController.text.isNotEmpty;
    });
  }

  // dropdown
  Future<void> _fetchDropdownDataMedicalHistory() async {
    try {
      Map<String, List<Object>>? response =
          await PatientHistoryApi.getStaticDataForPatientHistory();

      if (response != null) {
        setState(() {
          mucDoList = (response['mucDo'] as List<LevelModel>).toList();
        });

        print("✅ Đã cập nhật danh sách Mức độ: $mucDoList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
  }

  // Hàm gửi dữ liệu form khi nhấn nút "Lưu thông tin" - Tiểu sử bệnh di truyền
  Future<void> _submitFormGeneticDiseaseHistory() async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');
    GeneticDiseaseHistoryForm form = GeneticDiseaseHistoryForm(
      geneticDiseaseHistoryID: geneticDiseaseHistoryIDController.text,
      accountID: accountID,
      geneticDisease: geneticDiseaseController.text,
      relationshipFM: relationshipController.text,
      yearOfDiseaseFM: yearOfDiseaseController.text,
      noteDiseaseFM: noteDiseaseController.text,
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

  void _resetFormFamilyHistory() {
    geneticDiseaseController.clear();
    relationshipController.clear();
    yearOfDiseaseController.clear();
    noteDiseaseController.clear();
    setState(() {
      _selectedMucdoId = null;
    });
  }

  List<GeneticDiseaseHistoryForm> geneticDiseaseHistoryList = [];

  late Future<List<GeneticDiseaseHistoryForm>> geneticDiseaseHistoryListRender;

  // Load data form tóm tắt - Tiểu sử bệnh di truyền
  Future<List<GeneticDiseaseHistoryForm>> _loadGeneticDiseaseHistoryData() async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');
    List<GeneticDiseaseHistoryForm> geneticDiseaseHistory =
        await PatientHistoryApi.getGeneticDiseaseHistoryData(
            accountID, 'TieuSuBenhDiTruyen');
    setState(() {
      geneticDiseaseHistoryList = geneticDiseaseHistory;
    });
    return geneticDiseaseHistory;
  }

  // Xóa form Tiểu sử bệnh di truyền
  Future<void> _deleteGeneticDiseaseHistoryForm(String? tieuSuYTeID, String type) async {
    if (tieuSuYTeID == null) {
      return;
    }
    // Gọi API để xóa mục theo ID
    await PatientHistoryApi.deleteGeneticDiseaseHistoryForm(tieuSuYTeID, type);

    // Gọi lại hàm tải lại danh sách
    _loadGeneticDiseaseHistoryData();
  }

  @override
  void initState() {
    super.initState();
    geneticDiseaseController.addListener(_validateForm);
    yearOfDiseaseController.addListener(_validateForm);
    _fetchDropdownDataMedicalHistory();
    geneticDiseaseHistoryListRender = _loadGeneticDiseaseHistoryData();
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
            FutureBuilder<List<GeneticDiseaseHistoryForm>>(
                future: geneticDiseaseHistoryListRender,
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
                  var geneticDiseaseHistoryData = snapshot.data;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('Bệnh di truyền',
                              style: TextStyleCustom.heading_3a),
                          trailing: CustomButton(
                            type: ButtonType.iconOnly,
                            state: ButtonState.text,
                            width: iconSize.mediumIcon(context),
                            height: iconSize.mediumIcon(context),
                            icon: Icons.add_circle_outline_rounded,
                            onPressed: () =>
                                _showGeneticDiseaseHistory(context, null),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SpacingUtil.spacingHeight8(context)),
                          child: Text('Ghi chú: Bỏ qua nếu không có',
                              style: TextStyleCustom.bodySmall),
                        ),
                        SizedBox(height: SpacingUtil.spacingHeight16(context)),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: geneticDiseaseHistoryList.length,
                            itemBuilder: (context, index) {
                              var geneticDiseaseHistoryData =
                                  geneticDiseaseHistoryList[index];
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
                                          Text(
                                              geneticDiseaseHistoryData
                                                  .geneticDisease,
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
                                              geneticDiseaseHistoryData
                                                  .yearOfDiseaseFM,
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
                                              _showGeneticDiseaseHistory(
                                                  context,
                                                  geneticDiseaseHistoryData);
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
                                                              await _deleteGeneticDiseaseHistoryForm(
                                                                  geneticDiseaseHistoryData
                                                                      .geneticDiseaseHistoryID,
                                                                  "TieuSuBenhDiTruyen");
                                                              setState(() {
                                                                geneticDiseaseHistoryList
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
                })
          ],
        )));
  }

  void _showGeneticDiseaseHistory(BuildContext context,
      GeneticDiseaseHistoryForm? geneticDiseaseHistoryForm) {
    if (geneticDiseaseHistoryForm != null) {
      geneticDiseaseHistoryIDController.text =
          geneticDiseaseHistoryForm.geneticDiseaseHistoryID ?? '';
      geneticDiseaseController.text = geneticDiseaseHistoryForm.geneticDisease;
      relationshipController.text = geneticDiseaseHistoryForm.relationshipFM;
      _selectedMucdoId = geneticDiseaseHistoryForm.medicalLevelFM;
      yearOfDiseaseController.text =
          geneticDiseaseHistoryForm.yearOfDiseaseFM;
      noteDiseaseController.text = geneticDiseaseHistoryForm.noteDiseaseFM;
    }
    showModalBottomSheet(
        backgroundColor: PrimaryColor.primary_00,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          final iconSize = IconSizeUtil();
          return Scaffold(
            backgroundColor: PrimaryColor.primary_00,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    SpacingUtil.spacingWidth16(context),
                    SpacingUtil.spacingHeight56(context),
                    SpacingUtil.spacingWidth16(context),
                    SpacingUtil.spacingHeight24(context)),
                child: Column(
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
                            'Bệnh di truyền',
                            style: TextStyleCustom.heading_2b
                                .copyWith(color: PrimaryColor.primary_10),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close,
                                size: iconSize.largeIcon(context), color: StatusColor.errorFull)),
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
                      controller: geneticDiseaseController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    CustomTextInput(
                      label: 'Thành viên gia đình mắc bệnh',
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      hintText: 'Điền mối quan hệ',
                      controller: relationshipController,
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
                            controller: yearOfDiseaseController,
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
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
                                                  SizedBox(height: SpacingUtil.spacingHeight12(context)),
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
                                                  SizedBox(height: SpacingUtil.spacingHeight12(context)),
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
                                      width: iconSize.mediumIcon(context),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: SpacingUtil.spacingHeight12(context)),
                              DropdownButtonFormField<int>(
                                value: _selectedMucdoId,
                                hint: Text(
                                  'Chọn mức độ',
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(color: NeutralColor.neutral_06),
                                ),
                                isExpanded: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: SpacingUtil.spacingWidth12(context),vertical: SpacingUtil.spacingHeight16(context)),
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
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    CustomTextInput(
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      label: 'Ghi chú',
                      hintText: 'Điền ghi chú',
                      controller: noteDiseaseController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomButton(
                            type: ButtonType.standard,
                            state: ButtonState.fill2,
                            text: 'Xóa thông tin',
                            width: double.infinity,
                            height: SpacingUtil.spacingHeight56(context),
                            onPressed: () {
                              _resetFormFamilyHistory();
                            },
                          ),
                        ),
                        SizedBox(width: SpacingUtil.spacingWidth12(context)),
                        Expanded(
                          child: CustomButton(
                            type: ButtonType.standard,
                            state: ButtonState.fill1,
                            text: 'Lưu thông tin',
                            width: double.infinity,
                            height: SpacingUtil.spacingHeight56(context),
                            onPressed: isFamilyHistoryValid ? () {
                              _submitFormGeneticDiseaseHistory();
                            } : null,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
