import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/routes.dart';

import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class MaleBody extends StatefulWidget {
  const MaleBody({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MaleBodyState();
  }
}

class _MaleBodyState extends State<MaleBody> {
  List<String> bodyPartsFrontMan = [
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

  List<Color> colorBodyPartsFrontMan =
      List.generate(9, (index) => Colors.transparent);

  List<String> bodyPartsBackMan = [
    'assets/icons/setExaminationNumber/back-man/head-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/neck-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/back-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/left-hand-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/right-hand-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/male-butt-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/left-foot-back-man.svg',
    'assets/icons/setExaminationNumber/back-man/right-foot-back-man.svg',
  ];
  List<Color> colorBodyPartsBackMan =
      List.generate(8, (index) => Colors.transparent);

  bool _isFront = true;

  void _toggleManBody() {
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

  bool isHeadBackSelected = false;
  bool isNeckBackSelected = false;
  bool isBackBackSelected = false;
  bool isLeftHandBackSelected = false;
  bool isRightHandBackSelected = false;
  bool isMaleButtBackSelected = false;
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
      isMaleButtBackSelected = !isMaleButtBackSelected;
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

  void _showListBody(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: PrimaryColor.primary_00,
        context: context,
        isScrollControlled: true,
        builder: (context){
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          return Scaffold(
            backgroundColor: PrimaryColor.primary_00,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.04, screenHeight * 0.08,
                    screenWidth * 0.04, screenHeight * 0.02
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Lựa chọn bộ phận cơ thể", style: TextStyleCustom.heading_3b.copyWith(color: PrimaryColor.primary_10),),
                        CustomButton(
                          type: ButtonType.standard,
                          state: ButtonState.text,
                          text: "Hủy",
                          width: screenWidth * 0.01,
                          height: screenHeight * 0.02,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      width: 0.5,
                      color: NeutralColor.neutral_03,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ListTile(
                      title: Text('Đầu'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Container(
                      width: 0.5,
                      color: NeutralColor.neutral_03,
                    ),
                    ListTile(
                      title: Text('Cổ'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Container(
                      width: 0.5,
                      color: NeutralColor.neutral_03,
                    ),
                    ListTile(
                      title: Text('Ngực'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Container(
                      width: 0.5,
                      color: NeutralColor.neutral_03,
                    ),
                    ListTile(
                      title: Text('Tay'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Container(
                      width: 0.5,
                      color: NeutralColor.neutral_03,
                    ),
                    ListTile(
                      title: Text('Bụng'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Container(
                      width: 0.5,
                      color: NeutralColor.neutral_03,
                    ),
                    ListTile(
                      title: Text('Xương chậu'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Container(
                      width: 0.5,
                      color: NeutralColor.neutral_03,
                    ),
                    ListTile(
                      title: Text('Lưng'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Container(
                      width: 0.5,
                      color: NeutralColor.neutral_03,
                    ),
                    ListTile(
                      title: Text('Mông'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Container(
                      width: 0.5,
                      color: NeutralColor.neutral_03,
                    ),
                    ListTile(
                      title: Text('Chân'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    Container(
                      width: 0.5,
                      color: NeutralColor.neutral_03,
                    ),
                  ],
                ),
              )
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035, vertical: screenHeight * 0.02),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
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
                              "assets/images/setExaminationNumber/front-male-body.png",
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              left: 122.75,
                              top: 23.02,
                              child: GestureDetector(
                                onTap: () {
                                  toggleHeadFrontColor();
                                },
                                child: SvgPicture.asset(
                                  bodyPartsFrontMan[0],
                                  color: isHeadFrontSelected
                                      ? PrimaryColor.primary_01.withOpacity(0.5)
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 126.82,
                              top: 89.71,
                              child: GestureDetector(
                                onTap: () {
                                  toggleNeckFrontColor();
                                },
                                child: SvgPicture.asset(
                                  bodyPartsFrontMan[1],
                                  color: isNeckFrontSelected
                                      ? PrimaryColor.primary_01.withOpacity(0.5)
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 96.57,
                              top: 114.5,
                              child: GestureDetector(
                                onTap: () {
                                  toggleChestFrontColor();
                                },
                                child: SvgPicture.asset(
                                  bodyPartsFrontMan[2],
                                  color: isChestFrontSelected
                                      ? PrimaryColor.primary_01.withOpacity(0.5)
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 103.35,
                              top: 180.97,
                              child: GestureDetector(
                                onTap: () {
                                  toggleAbdomenFrontColor();
                                },
                                child: SvgPicture.asset(
                                  bodyPartsFrontMan[3],
                                  color: isAbdomenFrontSelected
                                      ? PrimaryColor.primary_01.withOpacity(0.5)
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 25.97,
                              top: 124.2,
                              child: GestureDetector(
                                onTap: () {
                                  toggleLeftHandFrontColor();
                                },
                                child: SvgPicture.asset(
                                  bodyPartsFrontMan[4],
                                  color: isLeftHandFrontSelected
                                      ? PrimaryColor.primary_01.withOpacity(0.5)
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 202.41,
                              top: 126.96,
                              child: GestureDetector(
                                onTap: () {
                                  toggleRightHandFrontColor();
                                },
                                child: SvgPicture.asset(
                                  bodyPartsFrontMan[5],
                                  color: isRightHandFrontSelected
                                      ? PrimaryColor.primary_01.withOpacity(0.5)
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 101.4,
                              top: 281.76,
                              child: GestureDetector(
                                onTap: () {
                                  toggleMaleGenitaliaFrontColor();
                                },
                                child: SvgPicture.asset(
                                  bodyPartsFrontMan[6],
                                  color: isMaleGenitaliaFrontSelected
                                      ? PrimaryColor.primary_01.withOpacity(0.5)
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 95.99,
                              top: 310.42,
                              child: GestureDetector(
                                onTap: () {
                                  toggleLeftFootFrontColor();
                                },
                                child: SvgPicture.asset(
                                  bodyPartsFrontMan[7],
                                  color: isLeftFootFrontSelected
                                      ? PrimaryColor.primary_01.withOpacity(0.5)
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 156.13,
                              top: 304.61,
                              child: GestureDetector(
                                onTap: () {
                                  toggleRightFootFrontColor();
                                },
                                child: SvgPicture.asset(
                                  bodyPartsFrontMan[8],
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
                            "assets/images/setExaminationNumber/back-male-body.png",
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 127.27,
                            top: 10.18,
                            child: GestureDetector(
                              onTap: () {
                                toggleHeadBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackMan[0],
                                color: isHeadBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 133.04,
                            top: 77.54,
                            child: GestureDetector(
                              onTap: () {
                                toggleNeckBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackMan[1],
                                color: isNeckBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 100.14,
                            top: 95.67,
                            child: GestureDetector(
                              onTap: () {
                                toggleBackBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackMan[2],
                                color: isBackBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 31.84,
                            top: 110.17,
                            child: GestureDetector(
                              onTap: () {
                                toggleLeftHandBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackMan[3],
                                color: isLeftHandBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 215.65,
                            top: 110.14,
                            child: GestureDetector(
                              onTap: () {
                                toggleRightHandBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackMan[4],
                                color: isRightHandBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 102.56,
                            top: 278.99,
                            child: GestureDetector(
                              onTap: () {
                                toggleMaleButtBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackMan[5],
                                color: isMaleButtBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 100.28,
                            top: 326.15,
                            child: GestureDetector(
                              onTap: () {
                                toggleLeftFootBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackMan[6],
                                color: isLeftFootBackSelected
                                    ? PrimaryColor.primary_01.withOpacity(0.5)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 161.04,
                            top: 324.59,
                            child: GestureDetector(
                              onTap: () {
                                toggleRightFootBackColor();
                              },
                              child: SvgPicture.asset(
                                bodyPartsBackMan[7],
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
                  _toggleManBody();
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
