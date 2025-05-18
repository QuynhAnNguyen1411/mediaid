import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/models/electronicHealthRecordModel/personalInformation/levelModel.dart';
import '../../../../../api/electronicHealthRecordAPI/basicMedicalInformationAPI/patientHistory_api.dart';
import '../../../../../design_system/button/button.dart';
import '../../../../../design_system/color/neutral_color.dart';
import '../../../../../design_system/color/status_color.dart';
import '../../../../../design_system/input_field/text_input.dart';
import '../../../../../design_system/textstyle/textstyle.dart';
import '../../../../../models/electronicHealthRecordModel/personalInformation/allergyHistoryForm.dart';
import '../../../../../util/spacingStandards.dart';

class AllergyHistory extends StatefulWidget {
  const AllergyHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AllergyHistoryState();
  }
}

class _AllergyHistoryState extends State<AllergyHistory>
    with SingleTickerProviderStateMixin {
  bool isAllergyHistoryValid = false;

  // Controller Tiểu sử dị ứng
  final TextEditingController allergicHistoryIDController =
  TextEditingController();
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
  late List<LevelModel> mucDoList = [];
  int? _selectedMucdoId;

  void _validateForm() {
    setState(() {
      isAllergyHistoryValid = allergicAgentsController.text.isNotEmpty &&
          lastHappenedController.text.isNotEmpty;
    });
  }

  Future<void> _fetchDropdownDataAllergyHistory() async {
    try {
      Map<String, List<Object>>? response =
      await PatientHistoryApi.getStaticDataForPatientHistory();

      if (response != null) {
        print("a");
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

  // Hàm gửi dữ liệu form khi nhấn nút "Lưu thông tin" - Tiền sử dị ứng
  Future<void> _submitFormAllergyHistory() async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');
    AllergyHistoryForm form = AllergyHistoryForm(
      allergyHistoryID: allergicHistoryIDController.text,
      accountID: accountID,
      allergicAgents: allergicAgentsController.text,
      allergySymptoms: allergySymptomsController.text,
      allergyLevel: _selectedMucdoId ?? 1,
      lastHappened: lastHappenedController.text,
      noteAllergy: noteAllergyController.text,
    );

    // Gửi form đến API
    try {
      print(form.toJson());
      await PatientHistoryApi.submitFormAllergyHistory(form);
      print('Form đã được gửi thành công.');
    } catch (e) {
      print('Có lỗi xảy ra khi gửi form: $e');
    }

    Navigator.pop(context);
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
  List<AllergyHistoryForm> allergyHistoryList = [];

  late Future<List<AllergyHistoryForm>> allergyHistoryListRender;

  // Load data form tóm tắt - Tiền sử dị ứng
  Future<List<AllergyHistoryForm>> _loadAllergyHistoryData() async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');
    List<AllergyHistoryForm> allergyHistory =
    await PatientHistoryApi.getAllergyHistoryData(accountID, 'TieuSuDiUng');
    setState(() {
      allergyHistoryList = allergyHistory;
    });
    return allergyHistory;
  }

  // Xóa form Tiền sử dị ứng
  Future<void> _deleteAllergyHistoryForm(String? tieuSuYTeID, String type) async {
    if(tieuSuYTeID==null){
      return;
    }
    // Gọi API để xóa mục theo ID
    await PatientHistoryApi.deleteAllergyHistoryForm(tieuSuYTeID, type);

    // Gọi lại hàm tải lại danh sách
    _loadAllergyHistoryData();
  }

  @override
  void initState() {
    super.initState();
    allergicAgentsController.addListener(_validateForm);
    lastHappenedController.addListener(_validateForm);
    _fetchDropdownDataAllergyHistory();
    allergyHistoryListRender = _loadAllergyHistoryData();
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
                FutureBuilder<List<AllergyHistoryForm>>(
                    future: allergyHistoryListRender ,
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
                      var allergyHistoryData = snapshot.data;

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text('Tiểu sử dị ứng', style: TextStyleCustom.heading_3a),
                              trailing: CustomButton(
                                type: ButtonType.iconOnly,
                                state: ButtonState.text,
                                width: iconSize.mediumIcon(context),
                                height: iconSize.mediumIcon(context),
                                icon: Icons.add_circle_outline_rounded,
                                onPressed: () => _showAllergyHistory(context, null),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: SpacingUtil.spacingHeight8(context)),
                              child: Text(
                                'Ghi chú: Bỏ qua nếu không có',
                                style: TextStyleCustom.bodySmall,
                              ),
                            ),
                            SizedBox(height: SpacingUtil.spacingHeight16(context)),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: allergyHistoryList.length,
                                itemBuilder: (context, index) {
                                  var allergyHistoryData = allergyHistoryList[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: PrimaryColor.primary_00,
                                        border: Border.all(
                                          color: PrimaryColor.primary_10,
                                          width: 1.2,
                                        )),
                                    margin: EdgeInsets.symmetric(
                                        vertical: SpacingUtil.spacingHeight12(context)),
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
                                              Text(allergyHistoryData.allergicAgents,
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
                                              Text(allergyHistoryData.lastHappened,
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
                                                  _showAllergyHistory(
                                                      context, allergyHistoryData);
                                                } else if (newValue == option2) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title:
                                                            Text('Xác nhận xóa'),
                                                            content: Text(
                                                                'Bạn có chắc chắn muốn xóa mục này không?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text('Không'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () async {
                                                                  Navigator.pop(
                                                                      context);
                                                                  await _deleteAllergyHistoryForm(allergyHistoryData.allergyHistoryID, "TieuSuDiUng");
                                                                  setState(() {
                                                                    allergyHistoryList
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
                                              itemBuilder: (BuildContext context) => [
                                                PopupMenuItem<String>(
                                                  value: option1,
                                                  child: Text(option1,
                                                      style:
                                                      TextStyleCustom.bodySmall),
                                                ),
                                                PopupMenuItem<String>(
                                                  value: option2,
                                                  child: Text(option2,
                                                      style:
                                                      TextStyleCustom.bodySmall),
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
            )
        )
    );
  }


  void _showAllergyHistory(BuildContext context, AllergyHistoryForm? allergyHistoryForm){
    if (allergyHistoryForm!= null){
      allergicHistoryIDController.text = allergyHistoryForm.allergyHistoryID ?? '';
      allergicAgentsController.text = allergyHistoryForm.allergicAgents ?? '';
      allergySymptomsController.text = allergyHistoryForm.allergySymptoms ?? '';
      _selectedMucdoId = allergyHistoryForm.allergyLevel ?? 0;
      lastHappenedController.text = allergyHistoryForm.lastHappened ?? '';
      noteAllergyController.text = allergyHistoryForm.noteAllergy ?? '';
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
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(SpacingUtil.spacingWidth16(context),
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
                          child: Text('Tiền sử dị ứng', style: TextStyleCustom.heading_2b.copyWith(color: PrimaryColor.primary_10),),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close, size: iconSize.largeIcon(context), color: StatusColor.errorFull)
                        ),
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
                      label: 'Tác nhân dị ứng',
                      hintText: 'Điền tác nhân dị ứng',
                      isRequired: true,
                      controller: allergicAgentsController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    CustomTextInput(
                      label: 'Triệu chứng',
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      hintText: 'Điền chi tiết các triệu chứng gặp phải',
                      controller: allergySymptomsController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
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
                                                  SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                                  // Vừa
                                                  Text(
                                                    "• Dị ứng vừa:",
                                                    style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10),
                                                  ),
                                                  Text(
                                                    "Phát ban sưng tấy, khó thở nhẹ, chóng mặt, nôn mửa hoặc tiêu chảy.",
                                                    style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                                  ),
                                                  SizedBox(height: SpacingUtil.spacingHeight12(context)),
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
                                  style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                ),
                                isExpanded: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: SpacingUtil.spacingWidth12(context), vertical: SpacingUtil.spacingHeight16(context)),
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
                        SizedBox(width: SpacingUtil.spacingWidth12(context)),
                        Expanded(
                            child: CustomTextInput(
                              label: 'Lần gần nhất',
                              type: TextFieldType.text,
                              state: TextFieldState.defaultState,
                              hintText: 'Điền thời gian',
                              isRequired: true,
                              controller: lastHappenedController,
                              keyboardType: TextInputType.multiline,
                            )),
                      ],
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    CustomTextInput(
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      label: 'Ghi chú',
                      hintText: 'Điền ghi chú',
                      controller: noteAllergyController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
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
                              _resetFormAllergyHistory();
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
                            onPressed: isAllergyHistoryValid ? () {
                              _submitFormAllergyHistory();
                            } : null,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          );
        }
    );
  }
}
