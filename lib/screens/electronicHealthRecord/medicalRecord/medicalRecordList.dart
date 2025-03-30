import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

import '../../../components/electronicHealthRecord/medicalRecordListCard.dart';
import '../../../components/electronicHealthRecord/statusResult.dart';

class MedicalRecordList extends StatelessWidget {

  const MedicalRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                  child: Column(
                    children: [
                      Text(
                        'Chi tiết kết quả khám',
                        style: TextStyleCustom.heading_2b.copyWith(color: PrimaryColor.primary_10),
                      ),
                    ],
                  )
              ),
              SizedBox(height: screenHeight * 0.02),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'U phổi lành tính',
                        style: TextStyleCustom.heading_2a.copyWith(color: PrimaryColor.primary_10),
                      ),
                      StatusResult(
                        statusLabel: 'Ổn định',
                        statusColor: StatusColor.successFull,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Column(
                    children: [
                      MedicalRecordListCard(
                        examinationType: 'Lịch Xét nghiệm máu',
                        examinationName: 'Xét nghiệm sinh hóa máu',
                        examinationTime: DateTime(2024, 9, 24, 08, 30),
                        examinationLocation: 'Phòng 101 - Viện K Tân Triều',
                        examinationNote: 'Nhịn ăn ít nhất 8 tiếng trước khi xét nghiệm',
                        examinationTypeBar: 'Lịch Xét nghiệm máu',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      MedicalRecordListCard(
                        examinationType: 'Lịch Xét nghiệm nước tiểu',
                        examinationName: 'Xét nghiệm nước tiểu',
                        examinationTime: DateTime(2024, 10, 11, 09, 30),
                        examinationLocation: 'Phòng 106 - Viện K Tân Triều',
                        examinationNote: 'Uống đủ nước',
                        examinationTypeBar: 'Lịch Xét nghiệm nước tiểu',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      MedicalRecordListCard(
                        examinationType: 'Lịch Phẫu thuật',
                        examinationName: 'Phẫu thuật sinh thiết',
                        examinationTime: DateTime(2024, 10, 14, 13, 30),
                        examinationLocation: 'Phòng 207 - Viện K Tân Triều',
                        examinationNote: 'Nên đến sớm 1h để chuẩn bị tâm lý và ký giấy đảm bảo ',
                        examinationTypeBar: 'Lịch Phẫu thuật',
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          )
      ),
    );
  }
}
