import 'package:flutter/material.dart';
import 'package:mediaid/screens/login/login.dart';
import 'package:mediaid/screens/registration/patientInformation.dart';

import '../../design_system/button/button.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class NavigationSurvey extends StatelessWidget {
  const NavigationSurvey({super.key});

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
                const SizedBox(height: 35),
                Center(
                  child: Image.asset(
                    'assets/images/splash/female_doctor_navigation_survey.jpg',
                    height: 330,
                    width: 330,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                      'Bạn đã có hồ sơ điện tử tại viện K chưa?',
                      style: TextStyleCustom.heading_2a
                          .copyWith(color: PrimaryColor.primary_10),
                    ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          type: ButtonType.standard,
                          state: ButtonState.fill2,
                          text: 'Chưa có',
                          width: double.infinity,
                          height: 50,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientInformation()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          type: ButtonType.standard,
                          state: ButtonState.fill1,
                          text: 'Đã có',
                          width: double.infinity,
                          height: 50,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogIn()),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ]
          ),
        )
    );
  }
}
