import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

class ExaminationHistoryCard extends StatelessWidget{
  final String diseaseConclusion;
  final DateTime conclusionTime;
  final String medicalFacility;
  final String doctorName;
  final String statusLabel;
  final Color statusColor;

  const ExaminationHistoryCard({super.key, required this.diseaseConclusion, required this.conclusionTime, required this.medicalFacility, required this.doctorName, required this.statusLabel, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/home/disease_conclusion.svg',
                      width: screenWidth * 0.06,
                      height: screenHeight * 0.03,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Container(
                      constraints: BoxConstraints(maxWidth: screenWidth * 0.5),
                      child: Text(
                        diseaseConclusion,
                        style: TextStyleCustom.heading_2b.copyWith(color: PrimaryColor.primary_10),
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.04,
                width: screenWidth * 0.3,
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    statusLabel,
                    style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_00),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          SizedBox(
            width: double.infinity,
            child: Divider(
              color: NeutralColor.neutral_05,
              thickness: 0.8,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/home/calendar.svg',
                    width: screenWidth * 0.06,
                    height: screenHeight * 0.03,
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    DateFormat('yyyy-MM-dd').format(conclusionTime),
                    style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/home/hospital.svg',
                    width: screenWidth * 0.06,
                    height: screenHeight * 0.03,
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    medicalFacility,
                    style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/home/doctor.svg',
                    width: screenWidth * 0.06,
                    height: screenHeight * 0.03,
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Container(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.7),
                    child: Text(
                      doctorName,
                      style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomButton(
            type: ButtonType.standard,
            state: ButtonState.fill1,
            text: 'Xem chi tiết',
            width: double.infinity,
            height: screenHeight * 0.06,
            onPressed: () {
              // Logic khi nút được nhấn
            },
          )
        ],
      ),

    );
  }

}