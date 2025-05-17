import 'package:flutter/material.dart';
import 'package:mediaid/routes.dart';
import 'package:mediaid/util/spacingStandards.dart';

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
          padding: EdgeInsets.symmetric(
              horizontal: SpacingUtil.spacingWidth16(context),
              vertical: SpacingUtil.spacingHeight24(context)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo Hospital K
                  Image.asset(
                    'assets/logo/national_cancer_hospital_logo.jpg',
                    width: LogoSizeUtil.medium(context),
                  ),

                  // Button display language
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SpacingUtil.spacingWidth16(context),
                        vertical: SpacingUtil.spacingHeight12(context)),
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
                          width: SpacingUtil.spacingWidth32(context),
                          // width: screenWidth * 0.08,
                          // height: screenHeight * 0.04,
                        ),
                        SizedBox(width: SpacingUtil.spacingWidth12(context)),
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
            SizedBox(height: SpacingUtil.spacingHeight32(context)),
            Center(
              child: Image.asset(
                'assets/images/splash/doctor_navigation_survey.png',
              ),
            ),
            SizedBox(height: SpacingUtil.spacingHeight24(context)),
            Text(
              'Bạn đã có hồ sơ điện tử tại viện K chưa?',
              style: TextStyleCustom.heading_2a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        type: ButtonType.standard,
                        state: ButtonState.outline,
                        text: 'Chưa có',
                        width: double.infinity,
                        height: SpacingUtil.spacingHeight56(context),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MediaidRoutes.registration);
                        },
                      ),
                    ),
                    SizedBox(width: SpacingUtil.spacingWidth12(context)),
                    Expanded(
                      child: CustomButton(
                        type: ButtonType.standard,
                        state: ButtonState.fill1,
                        text: 'Đã có',
                        width: double.infinity,
                        height: SpacingUtil.spacingHeight56(context),
                        onPressed: () {
                          Navigator.pushNamed(context, MediaidRoutes.logIn);
                        },
                      ),
                    )
                  ],
                ),
          ]),
        ));
  }
}
