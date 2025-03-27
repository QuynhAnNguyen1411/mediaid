import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mediaid/components/home/bottom_nav_bar.dart';
import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';
import 'package:mediaid/routes.dart';
import 'package:mediaid/screens/electronicHealthRecord/electronicHealthRecord.dart';
import 'package:mediaid/screens/setExaminationNumber/humanBody.dart';
import '../../components/home/examinationHistoryCard.dart';
import '../../design_system/color/primary_color.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo Hospital K
                  Image.asset(
                    'assets/logo/national_cancer_hospital_logo.jpg',
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.2,
                  ),

                  // Button display language
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.005),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFCCDEE7),
                          Color(0xFFCCDEE7),
                          Color(0xFF015C89),
                        ],
                        stops: [0.0, 0.12, 0.88],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // VN flag
                        Image.asset(
                          'assets/images/registration/vietnam_flag.jpg',
                          width: screenWidth * 0.08,
                          height: screenHeight * 0.04,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        // Text Vietnam
                        Text(
                          'Vietnam',
                          style: TextStyleCustom.heading_3b
                              .copyWith(color: PrimaryColor.primary_00),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Dịch vụ phổ biến',
                    style: TextStyleCustom.heading_2a
                        .copyWith(color: PrimaryColor.primary_10)),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // First button
                    Expanded(
                      child: Container(
                        height: screenHeight * 0.07,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: PrimaryColor.primary_05,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                            vertical: screenHeight * 0.009),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/home/cancer_screening.svg',
                              width: screenWidth * 0.06,
                              height: screenHeight * 0.03,
                              color: PrimaryColor.primary_05,
                            ),
                            SizedBox(width: screenWidth * 0.015),
                            Text(
                              'Tầm soát ung thư',
                              style: TextStyleCustom.bodySmall
                                  .copyWith(color: PrimaryColor.primary_05),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    // Second button
                    Expanded(
                      child: Container(
                        height: screenHeight * 0.07,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: PrimaryColor.primary_05,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                            vertical: screenHeight * 0.009),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/home/register_for_examination.svg',
                              width: screenWidth * 0.06,
                              height: screenHeight * 0.03,
                              color: PrimaryColor.primary_05,
                            ),
                            SizedBox(width: screenWidth * 0.015),
                            Text(
                              'Đăng ký khám',
                              style: TextStyleCustom.bodySmall
                                  .copyWith(color: PrimaryColor.primary_05),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Lịch sử gần đây',
                        style: TextStyleCustom.heading_2a
                            .copyWith(color: PrimaryColor.primary_10)),
                    CustomButton(
                      type: ButtonType.standard,
                      state: ButtonState.text,
                      text: "Xem tất cả",
                      width: screenWidth * 0.03,
                      height: screenHeight * 0.06,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, MediaidRoutes.medicalRecord);
                      },
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  children: [
                    ExaminationHistoryCard(
                      diseaseConclusion: 'U phổi lành tính',
                      conclusionTime: DateTime(2024, 10, 12),
                      medicalFacility: 'Viện K - Cơ sở Tân Triều',
                      doctorName: 'BS Nguyễn Hải Nam - chuyên khoa Hô Hấp',
                      statusLabel: 'Ổn định',
                      statusColor: StatusColor.successFull,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    ExaminationHistoryCard(
                      diseaseConclusion: 'Nghi ngờ lao phổi',
                      conclusionTime: DateTime(2024, 9, 24),
                      medicalFacility: 'Viện K - Cơ sở Quán Sứ',
                      doctorName: 'BS Nguyễn Đức Long - chuyên khoa Hô Hấp',
                      statusLabel: 'Cần tái khám',
                      statusColor: StatusColor.warningFull,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    ExaminationHistoryCard(
                      diseaseConclusion: 'Nghi ngờ K phổi',
                      conclusionTime: DateTime(2024, 7, 25),
                      medicalFacility: 'Viện K - Cơ sở Thanh Trì',
                      doctorName: 'BS Nguyễn Vân Anh - chuyên khoa Hô Hấp',
                      statusLabel: 'Nguy hiểm',
                      statusColor: StatusColor.errorFull,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
