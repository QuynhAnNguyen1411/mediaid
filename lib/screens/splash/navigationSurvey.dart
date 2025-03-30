import 'package:flutter/material.dart';
import 'package:mediaid/routes.dart';
import 'package:mediaid/screens/login/login.dart';
import 'package:mediaid/screens/registration/registration.dart';

import '../../design_system/button/button.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class NavigationSurvey extends StatelessWidget {
  const NavigationSurvey({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: PrimaryColor.primary_00,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            Center(
              child: Image.asset(
                'assets/images/splash/female_doctor_navigation_survey.jpg',
                height: screenHeight * 0.4,
                width: screenWidth * 0.8,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Bạn đã có hồ sơ điện tử tại viện K chưa?',
              style: TextStyleCustom.heading_2a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomButton(
                      type: ButtonType.standard,
                      state: ButtonState.outline,
                      text: 'Chưa có',
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      onPressed: () {
                        Navigator.pushNamed(context, MediaidRoutes.patientGroup);
                      },
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: CustomButton(
                      type: ButtonType.standard,
                      state: ButtonState.fill1,
                      text: 'Đã có',
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      onPressed: () {
                        Navigator.pushNamed(context, MediaidRoutes.logIn);
                      },
                    ),
                  )
                ],
              ),
            )
          ]),
        ));
  }
}
