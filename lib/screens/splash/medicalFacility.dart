import 'package:flutter/material.dart';
import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/routes.dart';
import 'package:mediaid/screens/splash/navigationSurvey.dart';

import '../../components/registration/medicalFacilityItem.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class MedicalFacility extends StatefulWidget {
  const MedicalFacility({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MedicalFacilityState();
  }
}

class _MedicalFacilityState extends State<MedicalFacility> {
  int? _selectedFacilityIndex;

  bool get isContinueEnabled => _selectedFacilityIndex != null;

  void _selectFacility(int index) {
    setState(() {
      if (_selectedFacilityIndex == index) {
        // Nếu cơ sở đã được chọn, bỏ chọn nó
        _selectedFacilityIndex = null;
      } else {
        // Chọn cơ sở mới
        _selectedFacilityIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Center(
              child: Image.asset(
                'assets/images/splash/male_doctor_medical_facility.jpg',
                height: screenHeight * 0.4,
                width: screenWidth * 0.8,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              children: [
                Text(
                  'Chọn cơ sở khám bệnh hiện tại',
                  style: TextStyleCustom.heading_2a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  children: [
                    MedicalFacilityItem(
                      address:
                          'Cơ sở 1: Số 43 Quán Sứ và số 9A - 9B Phan Chu Trinh, Hoàn Kiếm, Hà Nội',
                      isSelected: _selectedFacilityIndex == 0,
                      // So sánh với index
                      isDisabled: false,
                      onChanged: (isSelected) {
                        _selectFacility(0); // Chọn cơ sở 1
                      },
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    MedicalFacilityItem(
                      address: 'Cơ sở 2: Tựu Liệt, Tam Hiệp, Thanh Trì, Hà Nội',
                      isSelected: _selectedFacilityIndex == 1,
                      // So sánh với index
                      isDisabled: false,
                      onChanged: (isSelected) {
                        _selectFacility(1); // Chọn cơ sở 2
                      },
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    MedicalFacilityItem(
                      address:
                          'Cơ sở 3: Số 30 Cầu Bươu, Tân Triều, Thanh Trì, Hà Nội',
                      isSelected: _selectedFacilityIndex == 2,
                      isDisabled: false,
                      onChanged: (value) {
                        setState(() {
                          _selectFacility(2);
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            CustomButton(
              type: ButtonType.standard,
              state:
                  isContinueEnabled ? ButtonState.fill1 : ButtonState.disabled,
              text: "Tiếp tục",
              width: double.infinity,
              height: screenHeight * 0.06,
              onPressed: isContinueEnabled
                  ? () {
                      Navigator.pushNamed(context, MediaidRoutes.navigationSurvey);
                    }
                  : null,
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
