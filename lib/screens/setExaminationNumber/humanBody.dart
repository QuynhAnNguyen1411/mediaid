import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class FrontManBody extends StatefulWidget {
  const FrontManBody({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FrontManBodyState();
  }
}

class _FrontManBodyState extends State<FrontManBody> {
  List<String> bodyParts = [
    'assets/icons/setExaminationNumber/front-man/head-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/neck-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/chest-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/abdomen-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/left-hand-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/right-hand-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/male-genitalia-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/left-foot-front-man.svg',
    'assets/icons/setExaminationNumber/front-man/right-foot-front-man.svg',
  ];

  List<Color> colorBodyParts = List.generate(9, (index) => Colors.transparent);

  bool isHeadFrontSelected = false;
  bool isNeckFrontSelected = false;
  bool isChestFrontSelected = false;
  bool isAbdomenFrontSelected = false;
  bool isLeftHandFrontSelected = false;
  bool isRightHandFrontSelected = false;
  bool isMaleGenitaliaFrontSelected = false;
  bool isLeftFootFrontSelected = false;
  bool isRightFootFrontSelected = false;

  void toggleHeadFrontColor() {
    setState(() {
      isHeadFrontSelected = !isHeadFrontSelected;
    });
  }
  void toggleNeckFrontColor() {
    setState(() {
      isNeckFrontSelected = !isNeckFrontSelected;
    });
  }
  void toggleChestFrontColor() {
    setState(() {
      isChestFrontSelected = !isChestFrontSelected;
    });
  }
  void toggleAbdomenFrontColor() {
    setState(() {
      isAbdomenFrontSelected = !isAbdomenFrontSelected;
    });
  }
  void toggleLeftHandFrontColor() {
    setState(() {
      isLeftHandFrontSelected = !isLeftHandFrontSelected;
    });
  }
  void toggleRightHandFrontColor() {
    setState(() {
      isRightHandFrontSelected = !isRightHandFrontSelected;
    });
  }
  void toggleMaleGenitaliaFrontColor() {
    setState(() {
      isMaleGenitaliaFrontSelected = !isMaleGenitaliaFrontSelected;
    });
  }
  void toggleLeftFootFrontColor() {
    setState(() {
      isLeftFootFrontSelected = !isLeftFootFrontSelected;
    });
  }
  void toggleRightFootFrontColor() {
    setState(() {
      isRightFootFrontSelected = !isRightFootFrontSelected;
    });
  }

  // void _showClinicDialog(String part, String clinic) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("Chọn bộ phận: $part"),
  //       content: Text("Phòng khám phù hợp: $clinic"),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: Text("OK"),
  //         ),
  //       ],
  //     ),
  //   );
  // }
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
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Bạn đang gặp phải vấn đề gì vậy?',
              style: TextStyleCustom.heading_3a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            // SizedBox(height: screenHeight * 0.01),
            LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/setExaminationNumber/front-body-man.png",
                      width: screenWidth * 0.77,
                      height: screenHeight * 0.79,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 130.49,
                      top: 24.47,
                      child: GestureDetector(
                        onTap: () {
                          toggleHeadFrontColor();
                        },
                        child: SvgPicture.asset(
                          bodyParts[0],
                          color: isHeadFrontSelected ? PrimaryColor.primary_02.withOpacity(0.5) : Colors.transparent,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 134.83,
                      top: 96.43,
                      child: GestureDetector(
                        onTap: () {
                          toggleNeckFrontColor();
                        },
                        child: SvgPicture.asset(
                          bodyParts[1],
                          color: isNeckFrontSelected ? PrimaryColor.primary_02.withOpacity(0.5) : Colors.transparent,
                        ),
                      ),

                    ),
                    Positioned(
                      left: 102.66,
                      top: 121.72,
                      child: GestureDetector(
                        onTap: () {
                          toggleChestFrontColor();
                        },
                        child: SvgPicture.asset(
                          bodyParts[2],
                          color: isChestFrontSelected ? PrimaryColor.primary_02.withOpacity(0.5) : Colors.transparent,
                        ),
                      ),

                    ),
                    Positioned(
                      left: 109.88,
                      top: 192.39,
                      child: GestureDetector(
                        onTap: () {
                          toggleAbdomenFrontColor();
                        },
                        child: SvgPicture.asset(
                          bodyParts[3],
                          color: isAbdomenFrontSelected ? PrimaryColor.primary_02.withOpacity(0.5) : Colors.transparent,
                        ),
                      ),

                    ),
                    Positioned(
                      left: 27.61,
                      top: 132.04,
                      child: GestureDetector(
                        onTap: () {
                          toggleLeftHandFrontColor();
                        },
                        child: SvgPicture.asset(
                          bodyParts[4],
                          color: isLeftHandFrontSelected ? PrimaryColor.primary_02.withOpacity(0.5) : Colors.transparent,
                        ),
                      ),

                    ),
                    Positioned(
                      left: 215.18,
                      top: 134.97,
                      child: GestureDetector(
                        onTap: () {
                          toggleRightHandFrontColor();
                        },
                        child: SvgPicture.asset(
                          bodyParts[5],
                          color: isRightHandFrontSelected ? PrimaryColor.primary_02.withOpacity(0.5) : Colors.transparent,
                        ),
                      ),

                    ),
                    Positioned(
                      left: 107.8,
                      top: 299.53,
                      child: GestureDetector(
                        onTap: () {
                          toggleMaleGenitaliaFrontColor();
                        },
                        child: SvgPicture.asset(
                          bodyParts[6],
                          color: isMaleGenitaliaFrontSelected ? PrimaryColor.primary_02.withOpacity(0.5) : Colors.transparent,
                        ),
                      ),

                    ),
                    Positioned(
                      left: 104.17,
                      top: 327,
                      child: GestureDetector(
                        onTap: () {
                          toggleLeftFootFrontColor();
                        },
                        child: SvgPicture.asset(
                          bodyParts[7],
                          color: isLeftFootFrontSelected ? PrimaryColor.primary_02.withOpacity(0.5) : Colors.transparent,
                        ),
                      ),

                    ),
                    Positioned(
                      left: 167.05,
                      top: 319.83,
                      child: GestureDetector(
                        onTap: () {
                          toggleRightFootFrontColor();
                        },
                        child: SvgPicture.asset(
                          bodyParts[8],
                          color: isRightFootFrontSelected ? PrimaryColor.primary_02.withOpacity(0.5) : Colors.transparent,
                        ),
                      ),

                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
