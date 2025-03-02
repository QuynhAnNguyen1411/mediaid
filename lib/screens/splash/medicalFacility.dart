import 'package:flutter/material.dart';
import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/screens/splash/navigationSurvey.dart';

import '../../components/registration/medicalFacilityItem.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class MedicalFacility extends StatefulWidget{
  const MedicalFacility({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MedicalFacilityState();
  }
}

class _MedicalFacilityState extends State<MedicalFacility>{
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
                    height: 65,
                    width: 85,
                  ),

                  // Button display language
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
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
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(width: 12),
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
                height: 330,
                width: 320,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 25),
            Column(
              children: [
                Text(
                  'Chọn cơ sở khám bệnh hiện tại',
                  style: TextStyleCustom.heading_2a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                const SizedBox(height: 24),
                Column(
                    children: [
                      MedicalFacilityItem(
                        address: 'Cơ sở 1: Số 43 Quán Sứ và số 9A - 9B Phan Chu Trinh, Hoàn Kiếm, Hà Nội',
                        isSelected: _selectedFacilityIndex == 0, // So sánh với index
                        isDisabled: false,
                        onChanged: (isSelected) {
                          _selectFacility(0); // Chọn cơ sở 1
                        },
                      ),
                      const SizedBox(height: 16),
                      MedicalFacilityItem(
                        address: 'Cơ sở 2: Tựu Liệt, Tam Hiệp, Thanh Trì, Hà Nội',
                        isSelected: _selectedFacilityIndex == 1, // So sánh với index
                        isDisabled: false,
                        onChanged: (isSelected) {
                          _selectFacility(1); // Chọn cơ sở 2
                        },
                      ),
                      const SizedBox(height: 16),
                      MedicalFacilityItem(
                        address: 'Cơ sở 3: Số 30 Cầu Bươu, Tân Triều, Thanh Trì, Hà Nội',
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
            const SizedBox(height: 24),
            CustomButton(
              type: ButtonType.standard,
              state: isContinueEnabled ? ButtonState.fill1 : ButtonState.disabled,
              text: "Tiếp tục",
              width: double.infinity,
              height: 50,
              onPressed: isContinueEnabled ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationSurvey()),
                );
              } : null,
            )
          ],
        ),
      ),
    );
  }
}
