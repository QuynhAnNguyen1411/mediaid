import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/api/setExaminationNumberAPI/medicalFacility_api.dart';
import 'package:mediaid/api/setExaminationNumberAPI/setExaminationNumber_api.dart';
import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/selection/radio_button.dart';
import 'package:mediaid/models/setExamNumberModel/bodyPart_1Model.dart';
import 'package:mediaid/models/setExamNumberModel/diagnoseModel.dart';
import 'package:mediaid/models/setExamNumberModel/medicalFacilityModel.dart';
import 'package:mediaid/models/setExamNumberModel/symptomModel.dart';
import 'package:mediaid/screens/setExaminationNumber/symptomSurvey.dart';

import '../../design_system/color/neutral_color.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';
import '../../models/setExamNumberModel/bodyPart_2Model.dart';
import '../../util/spacingStandards.dart';
import '../electronicHealthRecord/medicalRecord/detailedMedicalHistoryList.dart';


class FemaleBody extends StatefulWidget {
  const FemaleBody({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FemaleBodyState();
  }
}

class _FemaleBodyState extends State<FemaleBody> {
  late List<MedicalFacilityModel> medicalFacilityList = [];

  int selectedMedicalFacilityID = 1;

  Future<void> _getMedicalFacilityData() async {
    try {
      List<MedicalFacilityModel> response =
      await MedicalFacilityApi.getStaticDataForMedicalFacility();

      if (response != null) {
        setState(() {
          medicalFacilityList = response;
        });

        print("✅ Đã cập nhật danh sách Cơ sở khám bệnh: $medicalFacilityList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
  }

  Future<void> _submitMedicalFacilityData(int selectedMedicalFacilityID) async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');
    try {
      await MedicalFacilityApi.submitModelMedicalFacility(
          selectedMedicalFacilityID);
      print('Dữ liệu Cơ sở khám bệnh đã được gửi thành công.');
    } catch (e) {
      print('Có lỗi xảy ra khi gửi dữ liệu Cơ sở khám bệnh: $e');
    }
  }

  List<String> bodyPartsFrontWoman = [
    'assets/icons/setExaminationNumber/front-woman/head-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/neck-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/chest-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/abdomen-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/left-hand-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/right-hand-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/female-genitalia-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/left-foot-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/right-foot-front-woman.svg',
  ];
  List<Color> colorBodyPartsFrontWoman = List.generate(
      9, (index) => Colors.transparent);

  List<String> bodyPartsBackWoman = [
    'assets/icons/setExaminationNumber/back-woman/head-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/neck-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/back-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/left-hand-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/right-hand-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/female-butt-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/left-foot-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/right-foot-back-woman.svg',
  ];
  List<Color> colorBodyPartsBackWoman = List.generate(
      8, (index) => Colors.transparent);

  bool _isFront = true;

  void _toggleWomanBody() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  bool isHeadFrontSelected = false;
  bool isNeckFrontSelected = false;
  bool isChestFrontSelected = false;
  bool isAbdomenFrontSelected = false;
  bool isLeftHandFrontSelected = false;
  bool isRightHandFrontSelected = false;
  bool isFemaleGenitaliaFrontSelected = false;
  bool isLeftFootFrontSelected = false;
  bool isRightFootFrontSelected = false;

  bool isHeadBackSelected = false;
  bool isNeckBackSelected = false;
  bool isBackBackSelected = false;
  bool isLeftHandBackSelected = false;
  bool isRightHandBackSelected = false;
  bool isFemaleButtBackSelected = false;
  bool isLeftFootBackSelected = false;
  bool isRightFootBackSelected = false;

  late List<BodyPart2Model> bodyPart2Process;

  Future<void> toggleColor(String bodyPart1, bool frontOrBack, bool? leftOrRight) async {
    if (kDebugMode) {
      print("Danh sach phan vung chua ID $bodyPart1");
    }
    switch (bodyPart1) {
      case "pv_1":
        setState(() {
          if (frontOrBack) {
            isHeadFrontSelected = true;
          } else {
            isHeadBackSelected = true;
          }
        });

        await Future.delayed(const Duration(milliseconds: 300));

        setState(() {
          if (frontOrBack) {
            isHeadFrontSelected = false;
          } else {
            isHeadBackSelected = false;
          }
        });
        break;

      case "pv_2":
        break;

      case "pv_3":
        if (frontOrBack) {
          setState(() => isNeckFrontSelected = true);
          await Future.delayed(const Duration(milliseconds: 300));
          setState(() => isNeckFrontSelected = false);
        } else {
          setState(() => isNeckBackSelected = true);
          await Future.delayed(const Duration(milliseconds: 300));
          setState(() => isNeckBackSelected = false);
        }
        break;

      case "pv_4":
        setState(() => isChestFrontSelected = true);
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() => isChestFrontSelected = false);
        break;

      case "pv_5":
        if (frontOrBack) {
          if (leftOrRight != null && leftOrRight) {
            setState(() => isLeftHandFrontSelected = true);
            await Future.delayed(const Duration(milliseconds: 300));
            setState(() => isLeftHandFrontSelected = false);
          } else {
            setState(() => isRightHandFrontSelected = true);
            await Future.delayed(const Duration(milliseconds: 300));
            setState(() => isRightHandFrontSelected = false);
          }
        } else {
          if (leftOrRight != null && leftOrRight) {
            setState(() => isLeftHandBackSelected = true);
            await Future.delayed(const Duration(milliseconds: 300));
            setState(() => isLeftHandBackSelected = false);
          } else {
            setState(() => isRightHandBackSelected = true);
            await Future.delayed(const Duration(milliseconds: 300));
            setState(() => isRightHandBackSelected = false);
          }
        }
        break;

      case "pv_6":
        setState(() => isAbdomenFrontSelected = true);
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() => isAbdomenFrontSelected = false);
        break;

      case "pv_7":
        setState(() => isFemaleGenitaliaFrontSelected = true);
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() => isFemaleGenitaliaFrontSelected = false);
        break;

      case "pv_8":
        setState(() => isBackBackSelected = true);
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() => isBackBackSelected = false);
        break;

      case "pv_9":
        setState(() => isFemaleButtBackSelected = true);
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() => isFemaleButtBackSelected = false);
        break;

      case "pv_10":
        if (frontOrBack) {
          if (leftOrRight != null && leftOrRight) {
            setState(() => isLeftFootFrontSelected = true);
            await Future.delayed(const Duration(milliseconds: 300));
            setState(() => isLeftFootFrontSelected = false);
          } else {
            setState(() => isRightFootFrontSelected = true);
            await Future.delayed(const Duration(milliseconds: 300));
            setState(() => isRightFootFrontSelected = false);
          }
        } else {
          if (leftOrRight != null && leftOrRight) {
            setState(() => isLeftFootBackSelected = true);
            await Future.delayed(const Duration(milliseconds: 300));
            setState(() => isLeftFootBackSelected = false);
          } else {
            setState(() => isRightFootBackSelected = true);
            await Future.delayed(const Duration(milliseconds: 300));
            setState(() => isRightFootBackSelected = false);
          }
        }
        break;

      default:
        return;
    }
    print("Lay danh sach bo phan 2 cho id " + bodyPart1);
    List<BodyPart2Model>? result = await SetExamNumberApi().findBodyPart2Models(
        bodyPart1, _bodyPartsData);
    if (result == null) {
      var box = await Hive.openBox('loginBox');
      String accountID = await box.get('accountID');
      DiagnoseModel diagnoseModel = new DiagnoseModel(accountID: accountID,
          bodyPart1ID: bodyPart1,
          medicalFacilityID: selectedMedicalFacilityID);
      String? lichSuKhamID = await SetExamNumberApi().submitInputForChanDoan(
          diagnoseModel);
      if (lichSuKhamID != null) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              DetailedRecordList(detailedRecordID: lichSuKhamID),
        ),);
      }
      return;
    }
    print("Chon phan vung voi id " + bodyPart1);
    bodyPart2Process = result;
    _showBodyPart2List(result);
  }

  void _showMedicalFacility(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double iconSize = screenWidth * 0.08;
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: PrimaryColor.primary_00,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chọn cơ sở khám ',
              style: TextStyleCustom.heading_3a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close,
                    size: iconSize, color: StatusColor.errorFull)),
          ],
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.3,
            child: ListView.builder(
                itemCount: medicalFacilityList.length,
                itemBuilder: (BuildContext context, int index) {
                  var medicalFacilityData = medicalFacilityList[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRadioButton(
                        isSelected: selectedMedicalFacilityID ==
                            medicalFacilityData.medicalFacilityID,
                        isDisabled: false,
                        label: medicalFacilityData.medicalFacilityName,
                        onChanged: (selected) {
                          setState(() {
                            if (selected) {
                              selectedMedicalFacilityID =
                                  medicalFacilityData.medicalFacilityID ?? 1;
                            } else {
                              selectedMedicalFacilityID = 1;
                            }
                          });
                        },
                      )
                    ],
                  );
                }),
          ),
        ),
        actions: <Widget>[
          CustomButton(
            type: ButtonType.standard,
            state: selectedMedicalFacilityID == null
                ? ButtonState.disabled
                : ButtonState.fill1,
            width: screenWidth * 0.15,
            height: screenHeight * 0.06,
            text: 'Tiếp tục',
            onPressed: selectedMedicalFacilityID == null
                ? null
                : () {
              _submitMedicalFacilityData(selectedMedicalFacilityID!);
              Navigator.pop(context);
            },
          )
        ],
      );
    });
  }

  List<BodyPart1Model> _bodyPartsData = [];

  Future<void> _navigateToChooseSymptomScreen(BuildContext context, BodyPart2Model bodyPart2Model) async {
    List<SymptomModel>? symptomModels = await SetExamNumberApi()
        .findSymptomModels(bodyPart2Model.bodyPart2ID, bodyPart2Process);

    if (symptomModels != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SymptomSurvey(
            bodyPart2ID: bodyPart2Model.bodyPart2ID,
            SymptomModels: symptomModels,
            selectedMedicalFacilityID: selectedMedicalFacilityID)),
      );
    } else {
      var box = await Hive.openBox('loginBox');
      String accountID = await box.get('accountID');
      DiagnoseModel diagnoseModel = new DiagnoseModel(accountID: accountID,
          bodyPart2ID: bodyPart2Model.bodyPart2ID,
          medicalFacilityID: selectedMedicalFacilityID);
      String? lichSuKhamID = await SetExamNumberApi().submitInputForChanDoan(diagnoseModel);
      if (lichSuKhamID != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedRecordList(detailedRecordID: lichSuKhamID),),);
      }
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _getMedicalFacilityData();
    _loadBodyPartsData();
  }

  // Hàm tải dữ liệu từ API
  Future<void> _loadBodyPartsData() async {
    var box = await Hive.openBox('loginBox');
    String? accountID = await box.get(
        'accountID'); // Lấy giá trị accountID từ Hive
    try {
      if (accountID == null) {
        return;
      }
      List<BodyPart1Model> response = await SetExamNumberApi().fetchBodyParts(
          accountID); // Gọi API và truyền accountID
      print("_loadBodyPartsData ");
      print(response);
      setState(() {
        _bodyPartsData = response;
      });
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void _showListBodyPart1(List<BodyPart1Model> bodyPart1List) {
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
        return Container(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04,
              screenHeight * 0.04, screenWidth * 0.04, screenHeight * 0.02),
          decoration: BoxDecoration(
            color: PrimaryColor.primary_00,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tra cứu triệu chứng',
                  style: TextStyleCustom.heading_3b
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Hủy',
                    style: TextStyleCustom.bodyLarge
                        .copyWith(color: StatusColor.informationFull),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Divider(
              color: NeutralColor.neutral_05,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: bodyPart1List.length,
              itemBuilder: (context, index) {
                var bodyPart1 = bodyPart1List[index];

                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(bodyPart1.bodyPart1Name,
                        style: TextStyleCustom.bodyLarge.copyWith(
                            color: PrimaryColor.primary_10),),
                      // Hiển thị tên phần cơ thể
                      Icon(Icons.arrow_forward_ios, size: 16),
                      // Dấu mũi tên
                    ],
                  ),
                  onTap: () async {
                    toggleColor(bodyPart1.bodyPart1ID, true, null);
                  },
                );
              },
            ),

            ],
          ),
        ));
      },
    );
  }

  // Hàm tìm kiếm và xử lý
  BodyPart1Model? findBodyPart1ById(List<BodyPart1Model> bodyPart1List,
      String bodyPart1ID) {
    return bodyPart1List.firstWhere((bodyPart1) =>
    bodyPart1.bodyPart1ID == bodyPart1ID);
  }

  void _showBodyPart2List(List<BodyPart2Model> bodyPart2List) {
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
        return Container(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.04,
                screenHeight * 0.04, screenWidth * 0.04, screenHeight * 0.02),
            decoration: BoxDecoration(
              color: PrimaryColor.primary_00,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Danh sách bộ phận loại 2',
                        style: TextStyleCustom.heading_3b
                            .copyWith(color: PrimaryColor.primary_10),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Hủy',
                          style: TextStyleCustom.bodyLarge


                              .copyWith(color: StatusColor.informationFull),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Divider(
                    color: NeutralColor.neutral_05,
                  ),
                  SizedBox(
                    height: screenHeight * 0.7,
                    child: ListView.builder(
                      itemCount: bodyPart2List.length,
                      itemBuilder: (context, index) {
                        BodyPart2Model bodyPart2 = bodyPart2List[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: Text(
                                  bodyPart2.bodyPart2Name,
                                  style: TextStyleCustom.bodyLarge.copyWith(
                                      color: PrimaryColor.primary_10),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                          onTap: () {
                            _navigateToChooseSymptomScreen(context, bodyPart2);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final iconSize = IconSizeUtil();
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: SpacingUtil.spacingWidth16(context), vertical: SpacingUtil.spacingHeight24(context)),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Đặt số khám',
                        style: TextStyleCustom.heading_2a
                            .copyWith(color: PrimaryColor.primary_10),
                      ),
                      IconButton(
                        onPressed: () {
                          _showMedicalFacility(context);
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/setExaminationNumber/medical-facility.svg',
                          width: iconSize.largeIcon(context),
                        ),
                      )
                    ],
                  ),
                  _isFront
                      ? LayoutBuilder(builder: (context, constraints) {
                    return Center(
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/setExaminationNumber/front-female-body.png",
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 160.36,
                            top: 11,
                            child: GestureDetector(
                              onTap: () {
                                // toggleHeadFrontColor();
                                toggleColor("pv_1", true, null);
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[0],
                                color: isHeadFrontSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 169.1,
                            top: 80.79,
                            child: GestureDetector(
                              onTap: () {
                                // toggleNeckFrontColor();
                                toggleColor("pv_3", true, null);
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[1],
                                color: isNeckFrontSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 138.42,
                            top: 102.98,
                            child: GestureDetector(
                              onTap: () {
                                // toggleChestFrontColor();
                                toggleColor("pv_4", true, null);
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[2],
                                color: isChestFrontSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 139.17,
                            top: 185.25,
                            child: GestureDetector(
                              onTap: () {
                                // toggleAbdomenFrontColor();
                                toggleColor("pv_6", true, null);
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[3],
                                color: isAbdomenFrontSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 40,
                            top: 107.45,
                            child: GestureDetector(
                              onTap: () {
                                // toggleLeftHandFrontColor();
                                toggleColor("pv_5", true, true);
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[4],
                                color: isLeftHandFrontSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 229.43,
                            top: 107.6,
                            child: GestureDetector(
                              onTap: () {
                                // toggleRightHandFrontColor();
                                toggleColor("pv_5", true, false);
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[5],
                                color: isRightHandFrontSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 133.63,
                            top: 271.29,
                            child: GestureDetector(
                              onTap: () {
                                // toggleFemaleGenitaliaFrontColor();
                                toggleColor("pv_7", true, null);
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[6],
                                color: isFemaleGenitaliaFrontSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 126.93,
                            top: 296.7,
                            child: GestureDetector(
                              onTap: () {
                                // toggleLeftFootFrontColor();
                                toggleColor("pv_10", true, true);
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[7],
                                color: isLeftFootFrontSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 195.04,
                            top: 294.11,
                            child: GestureDetector(
                              onTap: () {
                                // toggleRightFootFrontColor();
                                toggleColor("pv_10", true, false);
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[8],
                                color: isRightFootFrontSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                      : LayoutBuilder(builder: (context, constraints) {
                    return Center(
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/setExaminationNumber/back-female-body.png",
                            // width: screenWidth * 0.65,
                            // height: screenHeight * 0.67,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 160.66,
                            top: 23,
                            child: GestureDetector(
                              onTap: () {
                                // toggleHeadBackColor();
                                toggleColor("pv_1", false, null);
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[0],
                                color: isHeadBackSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 166.69,
                            top: 91.36,
                            child: GestureDetector(
                              onTap: () {
                                // toggleNeckBackColor();
                                toggleColor("pv_2", false, null);
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[1],
                                color: isNeckBackSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 141.65,
                            top: 110.69,
                            child: GestureDetector(
                              onTap: () {
                                // toggleBackBackColor();
                                toggleColor("pv_8", false, null);
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[2],
                                color: isBackBackSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 56,
                            top: 116.13,
                            child: GestureDetector(
                              onTap: () {
                                // toggleLeftHandBackColor();
                                toggleColor("pv_5", false, true);
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[3],
                                color: isLeftHandBackSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 234.03,
                            top: 116.45,
                            child: GestureDetector(
                              onTap: () {
                                // toggleRightHandBackColor();
                                toggleColor("pv_5", false, false);
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[4],
                                color: isRightHandBackSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 132.18,
                            top: 279.2,
                            child: GestureDetector(
                              onTap: () {
                                // toggleMaleButtBackColor();
                                toggleColor("pv_9", false, null);
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[5],
                                color: isFemaleButtBackSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 131.34,
                            top: 328.2,
                            child: GestureDetector(
                              onTap: () {
                                // toggleLeftFootBackColor();
                                toggleColor("pv_10", false, true);
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[6],
                                color: isLeftFootBackSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 196.55,
                            top: 324.4,
                            child: GestureDetector(
                              onTap: () {
                                // toggleRightFootBackColor();
                                toggleColor("pv_10", false, false);
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[7],
                                color: isRightFootBackSelected
                                    ? StatusColor.informationBackground
                                    .withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            Positioned(
              left: 0,
              top: 250,
              child: GestureDetector(
                onTap: () {
                  _toggleWomanBody();
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: PrimaryColor.primary_01,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/setExaminationNumber/rotate.svg',
                      width: iconSize.largeIcon(context),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 320,
              child: GestureDetector(
                onTap: () {
                  _showListBodyPart1(_bodyPartsData);
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: PrimaryColor.primary_01,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/setExaminationNumber/list.svg',
                      width: iconSize.largeIcon(context),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: screenHeight * 0.01),
          ],
        ),
      ),
    );
  }
}
