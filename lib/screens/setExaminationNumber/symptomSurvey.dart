import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/api/setExaminationNumberAPI/setExaminationNumber_api.dart';
import 'package:mediaid/models/setExamNumberModel/symptomModel.dart';

import '../../design_system/button/button.dart';
import '../../design_system/color/neutral_color.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';
import '../../models/setExamNumberModel/diagnoseModel.dart';
import '../../util/spacingStandards.dart';
import '../electronicHealthRecord/medicalRecord/detailedExaminationResults.dart';
import '../electronicHealthRecord/medicalRecord/detailedMedicalHistoryList.dart';

class SymptomSurvey extends StatefulWidget {
  final String bodyPart2ID;
  final List<SymptomModel> SymptomModels;
  final int selectedMedicalFacilityID;

  const SymptomSurvey(
      {super.key,
      required this.bodyPart2ID,
      required this.SymptomModels,
      required this.selectedMedicalFacilityID});

  @override
  State<StatefulWidget> createState() {
    return _SymptomSurveyState();
  }
}

class _SymptomSurveyState extends State<SymptomSurvey> {
  late List<SymptomModel> trieuChungList;
  late List<bool> isCheckedList;

  @override
  void initState() {
    super.initState();
    trieuChungList = widget.SymptomModels;
    isCheckedList = List.generate(trieuChungList.length, (index) => false);

    print("=== Danh sách triệu chứng đã nhận ===");
    for (int i = 0; i < trieuChungList.length; i++) {
      print("[$i] ${trieuChungList[i].symptomName}");
    }
  }

  // Hàm gửi dữ liệu form khi nhấn nút "Tiếp tục"
  Future<void> _submitSurvey() async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');
    // Lọc triệu chứng đã chọn
    List<String> selectedSymptoms = [];
    for (int i = 0; i < isCheckedList.length; i++) {
      if (isCheckedList[i]) {
        selectedSymptoms.add(trieuChungList[i].symptomID);
      }
    }
    print(selectedSymptoms);
    DiagnoseModel form = DiagnoseModel(
      accountID: accountID,
      bodyPart1ID: null,
      bodyPart2ID: widget.bodyPart2ID,
      medicalFacilityID: widget.selectedMedicalFacilityID,
      symptomList: selectedSymptoms,
    );
    String? lichSuKhamID =
        await SetExamNumberApi().submitInputForChanDoan(form, context);
    if (lichSuKhamID == "Xin hãy chọn cơ sở khám") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Xin hãy chọn cơ sở khám trước'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(16, 50, 16, 750), // Position at the top
          duration: Duration(seconds: 2),
        ),
      );
    } else if (lichSuKhamID != null && lichSuKhamID != "") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailedRecordList(detailedRecordID: lichSuKhamID),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: PrimaryColor.primary_00,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.08),
          child: AppBar(
            title: Text(
              'Khảo sát triệu chứng',
              style: TextStyleCustom.heading_2a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            backgroundColor: PrimaryColor.primary_01,
            elevation: 4.0,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: SpacingUtil.spacingWidth16(context),
                  vertical: SpacingUtil.spacingHeight24(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SpacingUtil.spacingHeight16(context)),
                  Text("Bạn có gặp phải những triệu chứng này không?",
                      style: TextStyleCustom.heading_3a
                          .copyWith(color: PrimaryColor.primary_10)),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.001),
                    child: Text(
                      'Ghi chú: Bỏ qua nếu không có',
                      style: TextStyleCustom.bodySmall,
                    ),
                  ),
                  SizedBox(height: SpacingUtil.spacingHeight16(context)),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: trieuChungList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCheckedList[index] =
                                        !isCheckedList[index];
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
                              SizedBox(width: screenWidth * 0.02),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth: screenWidth * 0.75),
                                child: Text(
                                  trieuChungList[index].symptomName,
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
                  ),
                  SizedBox(height: SpacingUtil.spacingHeight16(context)),
                  CustomButton(
                      type: ButtonType.standard,
                      state: ButtonState.fill1,
                      text: "Xếp số",
                      width: double.infinity,
                      height: SpacingUtil.spacingHeight56(context),
                      onPressed: () {
                        _submitSurvey();
                      }),
                ],
              )),
        ));
  }
}
