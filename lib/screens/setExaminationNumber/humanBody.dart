import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class HumanBody extends StatefulWidget {
  const HumanBody({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HumanBodyState();
  }
}

class _HumanBodyState extends State<HumanBody> {
  List<String> bodyParts = [
    'assets/icons/setExaminationNumber/head-front-man.svg',
    'assets/icons/setExaminationNumber/neck-front-man.svg',
    'assets/icons/setExaminationNumber/chest-front-man.svg',
    'assets/icons/setExaminationNumber/abdomen-front-man.svg',
    'assets/icons/setExaminationNumber/left-hand-front-man.svg',
    'assets/icons/setExaminationNumber/right-hand-front-man.svg',
    'assets/icons/setExaminationNumber/male-genitalia-front-man.svg',
    'assets/icons/setExaminationNumber/left-foot-front-man.svg',
    'assets/icons/setExaminationNumber/right-foot-front-man.svg',
  ];

  List<Color> colorBodyParts = List.generate(9, (index) => Colors.transparent);

  void onPartTapped(int index) {
    setState(() {
      colorBodyParts[index] = PrimaryColor.primary_01.withOpacity(0.5);
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
              style: TextStyleCustom.heading_2a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            SizedBox(height: screenHeight * 0.03),
            LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Image.asset(
                      "assets/images/setExaminationNumber/front-body-man.png",
                      
                      fit: BoxFit.cover,
                    ),
                    // Positioned(
                    //   top: height * 0.2,
                    //   left: width * 0.3,
                    //   child: GestureDetector(
                    //     onTap: () => onPartTapped(0),
                    //     child: SvgPicture.asset(
                    //       bodyParts[0],
                    //       color: Colors.red,
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
