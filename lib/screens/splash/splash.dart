import 'package:flutter/material.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

import '../../design_system/color/primary_color.dart';
import '../../routes.dart';
import '../../util/spacingStandards.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}
class _SplashState extends State<Splash>{

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, MediaidRoutes.navigationSurvey);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: Image.asset('assets/images/splash/bg.png'),
            ),
            Positioned(
                bottom: screenHeight * 0.25,
                child: Image.asset('assets/images/splash/hospital.png')),
            Positioned(
                bottom: 0,
                child: Image.asset('assets/images/splash/doctor_group.png')),
            Positioned(
                top: screenHeight * 0.1,
                left: 0,
                right: 0,
                child: Image.asset(
                    'assets/logo/national_cancer_hospital_logo.jpg',
                    height: screenHeight * 0.15,
                    width: screenWidth * 0.4)),
            Positioned(
                top: screenHeight * 0.3,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 250,
                        ),
                        child: Container(
                          child: Text(
                            'Y TẾ THÔNG MINH',
                            style: TextStyleCustom.heading_1a
                                .copyWith(color: PrimaryColor.primary_05),
                          ),
                        ),
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight8(context)),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 250,
                        ),
                        child: Container(
                          child: Text(
                            'CHẠM LÀ ĐẾN',
                            style: TextStyleCustom.heading_1a
                                .copyWith(color: PrimaryColor.primary_05),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
