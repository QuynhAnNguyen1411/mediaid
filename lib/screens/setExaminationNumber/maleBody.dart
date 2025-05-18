import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/screens/setExaminationNumber/symptomSurvey.dart';

import '../../api/setExaminationNumberAPI/medicalFacility_api.dart';
import '../../api/setExaminationNumberAPI/setExaminationNumber_api.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/color/status_color.dart';
import '../../design_system/selection/radio_button.dart';
import '../../design_system/textstyle/textstyle.dart';
import '../../models/setExamNumberModel/bodyPart_1Model.dart';
import '../../models/setExamNumberModel/bodyPart_2Model.dart';
import '../../models/setExamNumberModel/diagnoseModel.dart';
import '../../models/setExamNumberModel/medicalFacilityModel.dart';
import '../../models/setExamNumberModel/symptomModel.dart';
import '../../util/spacingStandards.dart';
import '../electronicHealthRecord/medicalRecord/detailedMedicalHistoryList.dart';

class MaleBody extends StatefulWidget {
  const MaleBody({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MaleBodyState();
  }
}

class _MaleBodyState extends State<MaleBody> {
  late List<MedicalFacilityModel> medicalFacilityList = [];

  int selectedMedicalFacilityID = 0;

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

  List<String> bodyPartsFrontMan = [
    'assets/icons/setExaminationNumber/front-man/head-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/neck-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/chest-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/abdomen-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/left-hand-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/right-hand-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/male-genitalia-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/left-foot-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/right-foot-front-man.svg',
  ];
  List<Color> colorBodyPartsFrontMan =
      List.generate(9, (index) => Colors.transparent);

  List<String> bodyPartsBackMan = [
    'assets/icons/setExaminationNumber/back-man/head-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/neck-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/back-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/left-hand-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/right-hand-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/male-butt-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/left-foot-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/right-foot-back-man.svg',
  ];
  List<Color> colorBodyPartsBackMan =
      List.generate(8, (index) => Colors.transparent);

  bool _isFront = true;

  void _toggleManBody() {
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
  bool isMaleGenitaliaFrontSelected = false;
  bool isLeftFootFrontSelected = false;
  bool isRightFootFrontSelected = false;

  bool isHeadBackSelected = false;
  bool isNeckBackSelected = false;
  bool isBackBackSelected = false;
  bool isLeftHandBackSelected = false;
  bool isRightHandBackSelected = false;
  bool isMaleButtBackSelected = false;
  bool isLeftFootBackSelected = false;
  bool isRightFootBackSelected = false;

  late List<BodyPart2Model> bodyPart2Process;

  Future<void> toggleColor(
      String bodyPart1, bool frontOrBack, bool? leftOrRight) async {
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
        setState(() => isMaleGenitaliaFrontSelected = true);
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() => isMaleGenitaliaFrontSelected = false);
        break;

      case "pv_8":
        setState(() => isBackBackSelected = true);
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() => isBackBackSelected = false);
        break;

      case "pv_9":
        setState(() => isMaleGenitaliaFrontSelected = true);
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() => isMaleGenitaliaFrontSelected = false);
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
    List<BodyPart2Model>? result =
        await SetExamNumberApi().findBodyPart2Models(bodyPart1, _bodyPartsData);
    if (result == null) {
      var box = await Hive.openBox('loginBox');
      String accountID = await box.get('accountID');
      DiagnoseModel diagnoseModel = new DiagnoseModel(
          accountID: accountID,
          bodyPart1ID: bodyPart1,
          medicalFacilityID: selectedMedicalFacilityID);
      String? lichSuKhamID = await SetExamNumberApi()
          .submitInputForChanDoan(diagnoseModel, context);
      if (lichSuKhamID == "Xin hãy chọn cơ sở khám") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Xin hãy chọn cơ sở khám'),
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
      return;
    }
    print("Chon phan vung voi id " + bodyPart1);
    bodyPart2Process = result;
    _showBodyPart2List(result);
  }

  Future<void> chooseMedicalFacility(int medicalFacilityID) async {
    print("medicalFacilityID");
    print(medicalFacilityID);
    selectedMedicalFacilityID = medicalFacilityID;
    Navigator.pop(context);
  }

  void _showMedicalFacility(List<MedicalFacilityModel> medicalFacilityList) {
    showModalBottomSheet(
      backgroundColor: PrimaryColor.primary_00,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;
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
                        'Chọn cơ sở khám bệnh',
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
                    itemCount: medicalFacilityList.length,
                    itemBuilder: (context, index) {
                      MedicalFacilityModel medicalFacility =
                          medicalFacilityList[index];
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              medicalFacility.medicalFacilityName,
                              style: TextStyleCustom.bodyLarge
                                  .copyWith(color: PrimaryColor.primary_10),
                            ),
                            // Hiển thị tên phần cơ thể
                            Icon(Icons.arrow_forward_ios, size: 16),
                            // Dấu mũi tên
                          ],
                        ),
                        onTap: () async {
                          print(medicalFacility.toJson());
                          chooseMedicalFacility(
                              medicalFacility.medicalFacilityID);
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

  List<BodyPart1Model> _bodyPartsData = [];

  Future<void> _navigateToChooseSymptomScreen(
      BuildContext context, BodyPart2Model bodyPart2Model) async {
    List<SymptomModel>? symptomModels = await SetExamNumberApi()
        .findSymptomModels(bodyPart2Model.bodyPart2ID, bodyPart2Process);

    if (symptomModels != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SymptomSurvey(
                bodyPart2ID: bodyPart2Model.bodyPart2ID,
                SymptomModels: symptomModels,
                selectedMedicalFacilityID: selectedMedicalFacilityID)),
      );
    } else {
      var box = await Hive.openBox('loginBox');
      String accountID = await box.get('accountID');
      DiagnoseModel diagnoseModel = new DiagnoseModel(
          accountID: accountID,
          bodyPart2ID: bodyPart2Model.bodyPart2ID,
          medicalFacilityID: selectedMedicalFacilityID);
      String? lichSuKhamID = await SetExamNumberApi()
          .submitInputForChanDoan(diagnoseModel, context);
      if (lichSuKhamID == "Xin hãy chọn cơ sở khám") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Xin hãy chọn cơ sở khám'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.fromLTRB(16, 50, 16, 750),
            // Position at the top
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      } else if (lichSuKhamID != null && lichSuKhamID != "") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailedRecordList(detailedRecordID: lichSuKhamID),
          ),
        );
      }
      return;
    }
  }

  // Hàm tải dữ liệu từ API
  Future<void> _loadBodyPartsData() async {
    var box = await Hive.openBox('loginBox');
    String? accountID =
        await box.get('accountID'); // Lấy giá trị accountID từ Hive
    try {
      if (accountID == null) {
        return;
      }
      List<BodyPart1Model> response = await SetExamNumberApi()
          .fetchBodyParts(accountID); // Gọi API và truyền accountID
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
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;
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
                            Text(
                              bodyPart1.bodyPart1Name,
                              style: TextStyleCustom.bodyLarge
                                  .copyWith(color: PrimaryColor.primary_10),
                            ),
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
  BodyPart1Model? findBodyPart1ById(
      List<BodyPart1Model> bodyPart1List, String bodyPart1ID) {
    return bodyPart1List
        .firstWhere((bodyPart1) => bodyPart1.bodyPart1ID == bodyPart1ID);
  }

  void _showBodyPart2List(List<BodyPart2Model> bodyPart2List) {
    showModalBottomSheet(
      backgroundColor: PrimaryColor.primary_00,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;
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
                                  style: TextStyleCustom.bodyLarge
                                      .copyWith(color: PrimaryColor.primary_10),
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
            ));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getMedicalFacilityData();
    _loadBodyPartsData();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final iconSize = IconSizeUtil();
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: SpacingUtil.spacingWidth16(context),
            vertical: SpacingUtil.spacingHeight24(context)),
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
                          _showMedicalFacility(medicalFacilityList);
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
                                  "assets/images/setExaminationNumber/front-male-body.png",
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  left: 122.75,
                                  top: 23.02,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_1", true, null);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsFrontMan[0],
                                      color: isHeadFrontSelected
                                          ? StatusColor.informationBackground
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 126.82,
                                  top: 89.71,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_3", true, null);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsFrontMan[1],
                                      color: isNeckFrontSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 96.57,
                                  top: 114.5,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_4", true, null);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsFrontMan[2],
                                      color: isChestFrontSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 103.35,
                                  top: 180.97,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_6", true, null);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsFrontMan[3],
                                      color: isAbdomenFrontSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 25.97,
                                  top: 124.2,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_5", true, true);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsFrontMan[4],
                                      color: isLeftHandFrontSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 202.41,
                                  top: 126.96,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_5", true, false);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsFrontMan[5],
                                      color: isRightHandFrontSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 101.4,
                                  top: 281.76,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_7", true, null);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsFrontMan[6],
                                      color: isMaleGenitaliaFrontSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 95.99,
                                  top: 310.42,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_10", true, true);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsFrontMan[7],
                                      color: isLeftFootFrontSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 156.13,
                                  top: 304.61,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_10", true, false);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsFrontMan[8],
                                      color: isRightFootFrontSelected
                                          ? PrimaryColor.primary_01
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
                                  "assets/images/setExaminationNumber/back-male-body.png",
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  left: 127.27,
                                  top: 10.18,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_1", false, null);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsBackMan[0],
                                      color: isHeadBackSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 133.04,
                                  top: 77.54,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_2", false, null);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsBackMan[1],
                                      color: isNeckBackSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 100.14,
                                  top: 95.67,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_8", false, null);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsBackMan[2],
                                      color: isBackBackSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 31.84,
                                  top: 110.17,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_5", false, true);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsBackMan[3],
                                      color: isLeftHandBackSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 215.65,
                                  top: 110.14,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_5", false, false);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsBackMan[4],
                                      color: isRightHandBackSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 102.56,
                                  top: 278.99,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_9", false, null);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsBackMan[5],
                                      color: isMaleButtBackSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 100.28,
                                  top: 326.15,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_10", false, true);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsBackMan[6],
                                      color: isLeftFootBackSelected
                                          ? PrimaryColor.primary_01
                                              .withOpacity(0.5)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 161.04,
                                  top: 324.59,
                                  child: GestureDetector(
                                    onTap: () {
                                      toggleColor("pv_10", false, false);
                                    },
                                    child: SvgPicture.asset(
                                      bodyPartsBackMan[7],
                                      color: isRightFootBackSelected
                                          ? PrimaryColor.primary_01
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
                  _toggleManBody();
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
