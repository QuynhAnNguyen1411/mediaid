import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/screens/electronicHealthRecord/medicalRecord/detailedMedicalHistoryList.dart';
import '../../../api/electronicHealthRecordAPI/medicalRecordAPI/medicalRecord_api.dart';
import '../../../design_system/button/button.dart';
import '../../../design_system/color/neutral_color.dart';
import '../../../design_system/textstyle/textstyle.dart';
import '../../../models/electronicHealthRecordModel/medicalRecordModel/generalRecordForm.dart';
import '../../../routes.dart';
import '../../../util/spacingStandards.dart';
class GeneralRecordList extends StatefulWidget {
  const GeneralRecordList({super.key});
  @override
  State<StatefulWidget> createState() {
    return _GeneralRecordListState();
  }
}

class _GeneralRecordListState extends State<GeneralRecordList> {
  Future<List<GeneralRecordForm>> _loadGeneralRecordCardData() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      var box = await Hive.openBox('loginBox');
      var examinationBookID = await box.get('soKhamID');
      var generalRecords = await MedicalRecordApi.getGeneralExaminationHistoryData(examinationBookID);
      return generalRecords; // Make sure this returns a List<GeneralRecordCardForm>
    } catch (e) {
      print("Error loading patient data: $e");
      return []; // Return an empty list if there is an error
    }
  }
  @override
  void initState() {
    super.initState();
    // generalRecordCardListRender = _loadGeneralRecordCardData();
  }

  Color getStatusColor(String statusLabel) {
    switch (statusLabel) {
      case 'Đã khám':
        return StatusColor.informationFull;
      case 'Cần tái khám':
        return StatusColor.warningFull;
      case 'Đang khám':
        return StatusColor.successFull;
      case 'Đã hủy':
        return StatusColor.errorFull;
      default:
        return NeutralColor.neutral_05;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final iconSize = IconSizeUtil();
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: FutureBuilder(
          future: _loadGeneralRecordCardData(),
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
            var generalMedicalRecordData = snapshot.data!;
            return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: generalMedicalRecordData.length,
                itemBuilder: (context, index) {
                  var record = generalMedicalRecordData[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: SpacingUtil.spacingHeight16(context)),
                    padding: EdgeInsets.symmetric(horizontal: SpacingUtil.spacingWidth16(context), vertical: SpacingUtil.spacingHeight16(context)),
                    decoration: BoxDecoration(
                      color: PrimaryColor.primary_00,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: PrimaryColor.primary_05,
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/home/disease_conclusion.svg',
                                    width: iconSize.largeIcon(context),
                                  ),
                                  SizedBox(width: SpacingUtil.spacingWidth12(context)),
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth: screenWidth * 0.4),
                                    child: Text(
                                      record.diseaseConclusion,
                                      style: TextStyleCustom.heading_3a
                                          .copyWith(
                                          color: PrimaryColor
                                              .primary_10),
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: SpacingUtil.spacingWidth16(context), vertical: SpacingUtil.spacingHeight12(context)),
                              width: screenWidth * 0.33,
                              decoration: BoxDecoration(
                                color: getStatusColor(record.statusLabel),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  record.statusLabel,
                                  style: TextStyleCustom.bodyLarge
                                      .copyWith(
                                      color: PrimaryColor.primary_00),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SpacingUtil.spacingHeight8(context)),
                        SizedBox(
                          width: double.infinity,
                          child: Divider(
                            color: NeutralColor.neutral_05,
                            thickness: 1,
                          ),
                        ),
                        SizedBox(height: SpacingUtil.spacingHeight8(context)),
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/home/calendar.svg',
                                  width: iconSize.mediumIcon(context),
                                ),
                                SizedBox(width: SpacingUtil.spacingWidth12(context)),
                                Text(
                                  DateFormat('dd/MM/YYYY').format(
                                      record.conclusionTime),
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(
                                      color: PrimaryColor.primary_10),
                                )
                              ],
                            ),
                            SizedBox(height: SpacingUtil.spacingHeight8(context)),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/home/hospital.svg',
                                  width: iconSize.mediumIcon(context),
                                ),
                                SizedBox(width: SpacingUtil.spacingWidth12(context)),
                                Text(
                                  record.medicalFacility,
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(
                                      color: PrimaryColor.primary_10),
                                )
                              ],
                            ),
                            SizedBox(height: SpacingUtil.spacingHeight8(context)),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/home/doctor.svg',
                                  width: iconSize.mediumIcon(context),
                                ),
                                SizedBox(width: SpacingUtil.spacingWidth12(context)),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: screenWidth * 0.7),
                                  child: Text(
                                    record.doctorName,
                                    style: TextStyleCustom.bodySmall
                                        .copyWith(
                                        color:
                                        PrimaryColor.primary_10),
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: SpacingUtil.spacingHeight12(context)),
                        CustomButton(
                          type: ButtonType.standard,
                          state: ButtonState.fill1,
                          text: 'Xem chi tiết',
                          width: double.infinity,
                          height: SpacingUtil.spacingHeight56(context),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailedRecordList(detailedRecordID: record.examHistoryID,),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                });
          })
    );
  }

}
