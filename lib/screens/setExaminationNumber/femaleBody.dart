import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class FemaleBody extends StatefulWidget {
  const FemaleBody({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FemaleBodyState();
  }
}

class _FemaleBodyState extends State<FemaleBody> {
  List<String> bodyPartsFrontWoman = [
    'assets/icons/setExaminationNumber/front-woman/head-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/neck-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/chest-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/abdomen-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/left-hand-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/right-hand-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/female-genitalia-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/left-foot-front-woman.svg',
    'assets/icons/setExaminationNumber/front-woman/right-foot-front-woman.svg',
  ];

  List<Color> colorBodyPartsFrontWoman =
  List.generate(9, (index) => Colors.transparent);

  List<String> bodyPartsBackWoman = [
    'assets/icons/setExaminationNumber/back-woman/head-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/neck-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/back-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/left-hand-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/right-hand-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/female-butt-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/left-foot-back-woman.svg',
    'assets/icons/setExaminationNumber/back-woman/right-foot-back-woman.svg',
  ];
  List<Color> colorBodyPartsBackWoman =
  List.generate(8, (index) => Colors.transparent);

  bool _isFront = true;

  void _toggleWomanBody() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  bool isHeadFrontSelected = false;
  bool isNeckFrontSelected = false;
  bool isChestFrontSelected = false;
  bool isAbdomenFrontSelected = false;
  bool isLeftHandFrontSelected = false;
  bool isRightHandFrontSelected = false;
  bool isFemaleGenitaliaFrontSelected = false;
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
      isFemaleGenitaliaFrontSelected = !isFemaleGenitaliaFrontSelected;
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

  bool isHeadBackSelected = false;
  bool isNeckBackSelected = false;
  bool isBackBackSelected = false;
  bool isLeftHandBackSelected = false;
  bool isRightHandBackSelected = false;
  bool isFemaleButtBackSelected = false;
  bool isLeftFootBackSelected = false;
  bool isRightFootBackSelected = false;

  void toggleHeadBackColor() {
    setState(() {
      isHeadBackSelected = !isHeadBackSelected;
    });
  }

  void toggleNeckBackColor() {
    setState(() {
      isNeckBackSelected = !isNeckBackSelected;
    });
  }

  void toggleBackBackColor() {
    setState(() {
      isBackBackSelected = !isBackBackSelected;
    });
  }

  void toggleLeftHandBackColor() {
    setState(() {
      isLeftHandBackSelected = !isLeftHandBackSelected;
    });
  }

  void toggleRightHandBackColor() {
    setState(() {
      isRightHandBackSelected = !isRightHandBackSelected;
    });
  }

  void toggleMaleButtBackColor() {
    setState(() {
      isFemaleButtBackSelected = !isFemaleButtBackSelected;
    });
  }

  void toggleLeftFootBackColor() {
    setState(() {
      isLeftFootBackSelected = !isLeftFootBackSelected;
    });
  }

  void toggleRightFootBackColor() {
    setState(() {
      isRightFootBackSelected = !isRightFootBackSelected;
    });
  }


  void _showListBody(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035, vertical: screenHeight * 0.02),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Text(
                    'Bạn muốn khám hoặc tư vấn về khu vực nào?',
                    style: TextStyleCustom.heading_2a
                        .copyWith(color: PrimaryColor.primary_10),
                  ),
                  _isFront
                      ? LayoutBuilder(builder: (context, constraints) {
                    return Center(
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/setExaminationNumber/front-female-body.png",
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 160.36,
                            top: 11,
                            child: GestureDetector(
                              onTap: () {
                                toggleHeadFrontColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[0],
                                color: isHeadFrontSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 169.1,
                            top: 80.79,
                            child: GestureDetector(
                              onTap: () {
                                toggleNeckFrontColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[1],
                                color: isNeckFrontSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 138.42,
                            top: 102.98,
                            child: GestureDetector(
                              onTap: () {
                                toggleChestFrontColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[2],
                                color: isChestFrontSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 139.17,
                            top: 185.25,
                            child: GestureDetector(
                              onTap: () {
                                toggleAbdomenFrontColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[3],
                                color: isAbdomenFrontSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 40,
                            top: 107.45,
                            child: GestureDetector(
                              onTap: () {
                                toggleLeftHandFrontColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[4],
                                color: isLeftHandFrontSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 229.43,
                            top: 107.6,
                            child: GestureDetector(
                              onTap: () {
                                toggleRightHandFrontColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[5],
                                color: isRightHandFrontSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 133.63,
                            top: 271.29,
                            child: GestureDetector(
                              onTap: () {
                                toggleMaleGenitaliaFrontColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[6],
                                color: isFemaleGenitaliaFrontSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 126.93,
                            top: 296.7,
                            child: GestureDetector(
                              onTap: () {
                                toggleLeftFootFrontColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[7],
                                color: isLeftFootFrontSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 195.04,
                            top: 294.11,
                            child: GestureDetector(
                              onTap: () {
                                toggleRightFootFrontColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsFrontWoman[8],
                                color: isRightFootFrontSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                      : LayoutBuilder(builder: (context, constraints) {
                    return Center(
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/setExaminationNumber/back-female-body.png",
                            // width: screenWidth * 0.65,
                            // height: screenHeight * 0.67,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 160.66,
                            top: 23,
                            child: GestureDetector(
                              onTap: () {
                                toggleHeadBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[0],
                                color: isHeadBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 166.69,
                            top: 91.36,
                            child: GestureDetector(
                              onTap: () {
                                toggleNeckBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[1],
                                color: isNeckBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 141.65,
                            top: 110.69,
                            child: GestureDetector(
                              onTap: () {
                                toggleBackBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[2],
                                color: isBackBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 56,
                            top: 116.13,
                            child: GestureDetector(
                              onTap: () {
                                toggleLeftHandBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[3],
                                color: isLeftHandBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 234.03,
                            top: 116.45,
                            child: GestureDetector(
                              onTap: () {
                                toggleRightHandBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[4],
                                color: isRightHandBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 132.18,
                            top: 279.2,
                            child: GestureDetector(
                              onTap: () {
                                toggleMaleButtBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[5],
                                color: isFemaleButtBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 131.34,
                            top: 328.2,
                            child: GestureDetector(
                              onTap: () {
                                toggleLeftFootBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[6],
                                color: isLeftFootBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 196.55,
                            top: 324.4,
                            child: GestureDetector(
                              onTap: () {
                                toggleRightFootBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackWoman[7],
                                color: isRightFootBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
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
            Positioned(
              left: 0,
              top: 250,
              child: GestureDetector(
                onTap: () {
                  _toggleWomanBody();
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: PrimaryColor.primary_01,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/setExaminationNumber/rotate.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 320,
              child: GestureDetector(
                onTap: () {
                  _showListBody(context);
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: PrimaryColor.primary_01,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/setExaminationNumber/list.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: screenHeight * 0.01),
          ],
        ),
      ),
    );
  }
}
