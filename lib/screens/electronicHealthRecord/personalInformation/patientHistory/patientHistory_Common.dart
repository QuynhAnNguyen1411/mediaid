import 'package:flutter/material.dart';
import 'package:mediaid/routes.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientHistory/surgeryHistory.dart';
import 'package:mediaid/screens/registration/registration.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/recentDrugUseHistory.dart';

import '../../../../components/electronicHealthRecord/tabItem_MedicalInformation.dart';
import '../../../../design_system/button/button.dart';
import '../../../../design_system/color/primary_color.dart';
import '../../../../design_system/textstyle/textstyle.dart';
import 'allergyHistory.dart';
import 'medicalHistory.dart';

class PatientHistory extends StatefulWidget {
  const PatientHistory({super.key});

  @override
  PatientHistoryState createState() => PatientHistoryState();
}

class PatientHistoryState extends State<PatientHistory>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      selectedIndex = index; // Cập nhật selectedIndex khi chọn tab mới
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onContinuePressed() {
    if (selectedIndex == 0) {
      // Tiền sử bệnh tật -> Tiền sử dị ứng
      _pageController.animateToPage(1,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        selectedIndex = 1;
      });
    } else if (selectedIndex == 1) {
      // Tiền sử dị ứng -> Tiền sử phẫu thuật
      _pageController.animateToPage(2,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        selectedIndex = 2;
      });
    } else if (selectedIndex == 2) {
      // Tiền sử phẫu thuật -> Chuyển sang trang mới
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DrugHistory()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
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
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.005),
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
            SizedBox(height: screenHeight * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đăng ký hồ sơ điện tử',
                  style: TextStyleCustom.heading_2a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Thông tin y tế cơ bản',
                  style: TextStyleCustom.heading_3a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabItem(
                      title: "Tiền sử\nbệnh tật",
                      state: selectedIndex == 0
                          ? TabState.selectedState
                          : TabState.defaultState,
                      onTap: () => _onTabSelected(0),
                    ),
                    TabItem(
                      title: "Tiền sử\ndị ứng",
                      state: selectedIndex == 1
                          ? TabState.selectedState
                          : TabState.defaultState,
                      onTap: () => _onTabSelected(1),
                    ),
                    TabItem(
                      title: "Tiền sử\nphẫu thuật",
                      state: selectedIndex == 2
                          ? TabState.selectedState
                          : TabState.defaultState,
                      onTap: () => _onTabSelected(2),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        selectedIndex =
                            index; // Cập nhật lại selectedIndex khi cuộn trang
                      });
                    },
                    children: [
                      MedicalHistory(),
                      AllergyHistory(),
                      SurgeryHistory(),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomButton(
                    type: ButtonType.standard,
                    state: ButtonState.fill2,
                    text: 'Quay lại',
                    width: double.infinity,
                    height: screenHeight * 0.06,
                    onPressed: () {
                      Navigator.pushNamed(context, MediaidRoutes.personalInformation);
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: CustomButton(
                    type: ButtonType.standard,
                    state: ButtonState.fill1,
                    text: 'Tiếp tục',
                    width: double.infinity,
                    height: screenHeight * 0.06,
                    onPressed: _onContinuePressed,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
