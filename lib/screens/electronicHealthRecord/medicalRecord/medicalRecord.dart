import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/primary_color.dart';

import '../../../components/home/examinationHistoryCard.dart';
import '../../../design_system/color/status_color.dart';

class MedicalRecord extends StatelessWidget {
  const MedicalRecord({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExaminationHistoryCard(
              diseaseConclusion: 'U phổi lành tính',
              conclusionTime: DateTime(2024, 10, 12),
              medicalFacility: 'Viện K - Cơ sở Tân Triều',
              doctorName: 'BS Nguyễn Hải Nam - chuyên khoa Hô Hấp',
              statusLabel: 'Ổn định',
              statusColor: StatusColor.successFull,
            ),
            SizedBox(height: screenHeight * 0.02),
            ExaminationHistoryCard(
              diseaseConclusion: 'Nghi ngờ lao phổi',
              conclusionTime: DateTime(2024, 9, 24),
              medicalFacility: 'Viện K - Cơ sở Quán Sứ',
              doctorName: 'BS Nguyễn Đức Long - chuyên khoa Hô Hấp',
              statusLabel: 'Cần tái khám',
              statusColor: StatusColor.warningFull,
            ),
            SizedBox(height: screenHeight * 0.02),
            ExaminationHistoryCard(
              diseaseConclusion: 'Nghi ngờ K phổi',
              conclusionTime: DateTime(2024, 7, 25),
              medicalFacility: 'Viện K - Cơ sở Thanh Trì',
              doctorName: 'BS Nguyễn Vân Anh - chuyên khoa Hô Hấp',
              statusLabel: 'Nguy hiểm',
              statusColor: StatusColor.errorFull,
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
