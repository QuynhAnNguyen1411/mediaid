import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import '../../../../api/electronicHealthRecordAPI/basicMedicalInformationAPI/lifestyleSurvey_api.dart';
import '../../../../design_system/button/button.dart';
import '../../../../design_system/color/primary_color.dart';
import '../../../../design_system/input_field/text_input.dart';
import '../../../../design_system/textstyle/textstyle.dart';
import '../../../../models/electronicHealthRecordModel/personalInformation/habitPatientModel.dart';
import '../../../../models/electronicHealthRecordModel/personalInformation/lifestyleSurveyForm.dart';
import '../../../../models/electronicHealthRecordModel/personalInformation/workingEnvironmentModel.dart';
import '../../../../routes.dart';
import '../../../../util/spacingStandards.dart';

class LifestyleSurvey extends StatefulWidget {
  const LifestyleSurvey({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LifestyleSurveyState();
  }
}

class _LifestyleSurveyState extends State<LifestyleSurvey> {

  final TextEditingController lifestyleSurveyIDController = TextEditingController();
  final TextEditingController noteWorkingEnvironmentController = TextEditingController();

  // Danh sách chứa trạng thái của từng checkbox
  List<bool> isCheckedList = [false, false, false, false, false, false];

  // Dropdown
  int _selectedMoitruonglamviecId =2;
  late List<WorkingEnvironmentModel> moiTruongLamViecList = [];
  late List<HabitPatientModel> thoiQuenList = [];

  Future<void> _fetchDropdownDataLifeStyleSurvey() async {
    try {
      Map<String, List<Object>>? response =
          await LifestyleSurveyApi.getStaticDataForLifestyleSurvey();

      if (response != null) {
        setState(() {
          moiTruongLamViecList =
              (response['moiTruongLamViec'] as List<WorkingEnvironmentModel>)
                  .toList();
          thoiQuenList = (response['thoiQuen'] as List<HabitPatientModel>).toList();
        });


        print("✅ Đã cập nhật danh sách Môi trường làm việc: $moiTruongLamViecList");
        print("✅ Đã cập nhật danh sách Thói quen: $thoiQuenList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
  }

  void _resetFormLifestyleSurvey() {
    setState(() {
      for (int i = 0; i < isCheckedList.length; i++) {
        isCheckedList[i] = false;
      }
      noteWorkingEnvironmentController.clear();
    });
  }

  Future<void> _submitFormLifestyleSurvey() async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');

    List<int> thoiQuenSelected = [];
    for(int i=0;i<thoiQuenList.length;i++){
      print (i);
      if(isCheckedList[i]){
        thoiQuenSelected.add(thoiQuenList[i].habitPatientID);
      }
    }
    LifestyleSurveyForm form = LifestyleSurveyForm(
      lifestyleSurveyID: lifestyleSurveyIDController.text,
      accountID: accountID,
      isCheckedList: thoiQuenSelected,
      workingEnvironment: _selectedMoitruonglamviecId,
      noteLifestyleSurvey: noteWorkingEnvironmentController.text,
    );

    // Gửi form đến API
    try {
      print("_submitFormLifestyleSurvey");
      print(form.toJson());
      await LifestyleSurveyApi.submitFormLifestyleSurvey(form);
      print('Form đã được gửi thành công.');
    } catch (e) {
      print('Có lỗi xảy ra khi gửi form: $e');
    }
    Navigator.pop(context);
  }
  late Future<LifestyleSurveyForm> lifestyleSurveyListRender;

  LifestyleSurveyForm? lifestyleSurvey;
  Future<LifestyleSurveyForm> _loadLifestyleSurveyData() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      var box = await Hive.openBox('loginBox');
      String accountID = await box.get('accountID');
      LifestyleSurveyForm lifestyleSurveys = await LifestyleSurveyApi.getLifestyleSurveyData(accountID);
      // print ("loisongnguoibenh ");
      // print (lifestyleSurveys.lifestyleSurveyID);
      lifestyleSurveyIDController.text =
          lifestyleSurveys.lifestyleSurveyID ?? '';
      _selectedMoitruonglamviecId = lifestyleSurveys.workingEnvironment == 0 ? 1 : lifestyleSurveys.workingEnvironment!;
      noteWorkingEnvironmentController.text =
          lifestyleSurveys.noteLifestyleSurvey ?? '';
      lifestyleSurveys.isCheckedList.forEach((a){
        isCheckedList[a-1]=true;
      });
      return lifestyleSurveys;
    } catch (e) {
      throw "Error loading patient data: $e";
    }

  }
  @override
  void initState() {
    super.initState();
    _fetchDropdownDataLifeStyleSurvey();
    // _loadLifestyleSurveyData();
    lifestyleSurveyListRender = _loadLifestyleSurveyData();
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: PrimaryColor.primary_00,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.08),
          child: AppBar(
            title: Text(
              'Khảo sát lối sống',
              style: TextStyleCustom.heading_2a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            backgroundColor: PrimaryColor.primary_01,
            elevation: 4.0,
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<LifestyleSurveyForm>(
              future: lifestyleSurveyListRender,
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
                var lifestyleSurveyData = snapshot.data;

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                      SpacingUtil.spacingWidth16(context),
                      SpacingUtil.spacingHeight24(context),
                      SpacingUtil.spacingWidth16(context),
                      SpacingUtil.spacingHeight24(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Lối sống người bệnh",
                              style: TextStyleCustom.heading_3a
                                  .copyWith(color: PrimaryColor.primary_10)),
                          SizedBox(height: SpacingUtil.spacingHeight12(context)),
                          Container(
                              height: screenHeight * 0.37,
                              padding: EdgeInsets.symmetric(
                                  horizontal: SpacingUtil.spacingWidth16(context),
                                  vertical: SpacingUtil.spacingHeight16(context)),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: NeutralColor.neutral_04,
                                    width: 1.5
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: thoiQuenList.isEmpty
                                  ? Center(child: CircularProgressIndicator())
                                  : ListView.builder(
                                itemCount: thoiQuenList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isCheckedList[index] = !isCheckedList[index];
                                              });
                                            },
                                            child: Transform.scale(
                                              scale: 1.3,
                                              child: Checkbox(
                                                value: isCheckedList[index],
                                                activeColor: PrimaryColor.primary_05,
                                                checkColor: PrimaryColor.primary_00,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isCheckedList[index] = value!;
                                                  });
                                                },
                                                side: BorderSide(
                                                  color: NeutralColor.neutral_06,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: SpacingUtil.spacingWidth8(context)),
                                          Container(
                                            constraints:
                                            BoxConstraints(maxWidth: screenWidth * 0.75),
                                            child: Text(
                                              thoiQuenList[index].habitPatientName,
                                              style: TextStyleCustom.bodySmall
                                                  .copyWith(color: PrimaryColor.primary_10),
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              )
                          )
                        ],
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Môi trường làm việc",
                              style: TextStyleCustom.heading_3a
                                  .copyWith(color: PrimaryColor.primary_10)),
                          SizedBox(height: SpacingUtil.spacingHeight12(context)),
                          DropdownButtonFormField<int>(
                            value: _selectedMoitruonglamviecId,
                            hint: Text(
                              'Chọn môi trường làm việc',
                              style: TextStyleCustom.bodySmall.copyWith(
                                color: NeutralColor.neutral_06,
                              ),
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
                            items: moiTruongLamViecList.map((moiTruongLamViec) {
                              return DropdownMenuItem<int>(
                                value: moiTruongLamViec.workingEnvironmentID,
                                child: Text(
                                  moiTruongLamViec.workingEnvironmentName,
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(color: PrimaryColor.primary_10),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedMoitruonglamviecId = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ghi chú",
                              style: TextStyleCustom.heading_3a
                                  .copyWith(color: PrimaryColor.primary_10)),
                          CustomTextInput(
                            type: TextFieldType.text,
                            state: TextFieldState.defaultState,
                            hintText: 'Thêm tác nhân hoặc nguy cơ đáng ngại khác',
                            controller: noteWorkingEnvironmentController,
                            keyboardType: TextInputType.multiline,
                          ),
                        ],
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
                                _resetFormLifestyleSurvey();
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
                              onPressed: () {
                                _submitFormLifestyleSurvey();
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }),

        ));
  }
}
