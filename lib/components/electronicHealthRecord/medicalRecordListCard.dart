import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

class MedicalRecordListCard extends StatelessWidget {
  final String examinationType;
  final String examinationTypeBar;
  final String examinationName;
  final DateTime examinationTime;
  final String examinationLocation;
  final String examinationNote;

  const MedicalRecordListCard(
      {super.key,
      required this.examinationType,
      required this.examinationName,
      required this.examinationTime,
      required this.examinationLocation,
      required this.examinationNote,
      required this.examinationTypeBar});

  Color getExaminationTypeColor() {
    switch (examinationType) {
      case 'Lịch Xạ trị':
      case 'Lịch Hóa trị':
      case 'Lịch Phẫu thuật':
      case 'Lịch Tiêm thuốc sinh học':
        return StatusColor.errorBackground;
      case 'Lịch Siêu âm':
      case 'Lịch Chụp CT':
      case 'Lịch Chụp MRI':
      case 'Lịch Chụp X-quang':
        return StatusColor.informationBackground;
      case 'Lịch Xét nghiệm máu':
      case 'Lịch Xét nghiệm nước tiểu':
      case 'Lịch Xét nghiệm tế bào học':
      case 'Lịch Xét nghiệm sinh học phân tử':
        return StatusColor.warningBackground;
      case 'Lịch Tái khám':
      case 'Lịch Chăm sóc giảm nhẹ':
        return StatusColor.successBackground;
      default:
        return NeutralColor.neutral_02;
    }
  }

  Color getExaminationTypeBarColor() {
    switch (examinationTypeBar) {
      case 'Lịch Xạ trị':
      case 'Lịch Hóa trị':
      case 'Lịch Phẫu thuật':
      case 'Lịch Tiêm thuốc sinh học':
        return StatusColor.errorFull;
      case 'Lịch Siêu âm':
      case 'Lịch Chụp CT':
      case 'Lịch Chụp MRI':
      case 'Lịch Chụp X-quang':
        return StatusColor.informationFull;
      case 'Lịch Xét nghiệm máu':
      case 'Lịch Xét nghiệm nước tiểu':
      case 'Lịch Xét nghiệm tế bào học':
      case 'Lịch Xét nghiệm sinh học phân tử':
        return StatusColor.warningFull;
      case 'Lịch Tái khám':
      case 'Lịch Chăm sóc giảm nhẹ':
        return StatusColor.successFull;
      default:
        return NeutralColor.neutral_02;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    String formattedDay = DateFormat('dd').format(examinationTime);
    String formattedMonth = DateFormat('MM').format(examinationTime);
    String formattedTime =
        DateFormat('dd/MM/yyyy HH:mm').format(examinationTime);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimaryColor.primary_00,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PrimaryColor.primary_05,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: screenWidth * 0.2,
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                    color: getExaminationTypeColor(),
                    border: Border(
                        left: BorderSide(
                      color: getExaminationTypeBarColor(),
                      width: screenWidth * 0.005,
                    ))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        formattedDay,
                        style: TextStyleCustom.heading_3a
                            .copyWith(color: PrimaryColor.primary_10),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        'Tháng$formattedMonth',
                        style: TextStyleCustom.bodySmall
                            .copyWith(color: PrimaryColor.primary_10),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.015),
              Expanded(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          examinationType,
                          style: TextStyleCustom.bodySmall
                              .copyWith(color: PrimaryColor.primary_10),
                        ),
                        SizedBox(height: screenHeight * 0.009),
                        Text(
                          examinationName,
                          style: TextStyleCustom.heading_3b
                              .copyWith(color: PrimaryColor.primary_10),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/home/calendar.svg',
                                  width: screenWidth * 0.055,
                                  height: screenHeight * 0.025,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  formattedTime,
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(color: PrimaryColor.primary_10),
                                )
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/home/hospital.svg',
                                  width: screenWidth * 0.055,
                                  height: screenHeight * 0.025,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Text(
                                  examinationLocation,
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(color: PrimaryColor.primary_10),
                                )
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/electronicHealthRecord/notes.svg',
                                  width: screenWidth * 0.055,
                                  height: screenHeight * 0.025,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: screenWidth * 0.5),
                                  child: Text(
                                    examinationNote,
                                    style: TextStyleCustom.bodySmall.copyWith(
                                        color: PrimaryColor.primary_10),
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          CustomButton(
            type: ButtonType.standard,
            state: ButtonState.fill1,
            width: double.infinity,
            height: screenHeight * 0.06,
            text: 'Xem chi tiết',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
