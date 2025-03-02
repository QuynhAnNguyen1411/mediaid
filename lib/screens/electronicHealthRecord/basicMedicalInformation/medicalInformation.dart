import 'package:flutter/material.dart';
import 'package:mediaid/screens/electronicHealthRecord/basicMedicalInformation/surgeryHistory.dart';
import 'package:mediaid/screens/registration/patientInformation.dart';
import 'package:mediaid/screens/electronicHealthRecord/recentDrugUseHistory.dart';

import '../../../components/electronicHealthRecord/tabItem_MedicalInformation.dart';
import '../../../design_system/button/button.dart';
import '../../../design_system/color/primary_color.dart';
import '../../../design_system/textstyle/textstyle.dart';
import 'allergyHistory.dart';
import 'medicalHistory.dart';

class MedicalInformation extends StatefulWidget {
  const MedicalInformation({super.key});

  @override
  MedicalInformationState createState() => MedicalInformationState();
}

class MedicalInformationState extends State<MedicalInformation>
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
      _pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        selectedIndex = 1;
      });
    } else if (selectedIndex == 1) {
      // Tiền sử dị ứng -> Tiền sử phẫu thuật
      _pageController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.ease);
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
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đăng ký hồ sơ điện tử',
                      style: TextStyleCustom.heading_2a
                          .copyWith(color: PrimaryColor.primary_10),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Thông tin y tế cơ bản',
                      style: TextStyleCustom.heading_3a
                          .copyWith(color: PrimaryColor.primary_10),
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 400,
                      // Đảm bảo chiều cao của PageView không bị tràn
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
                    const SizedBox(height: 30),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      type: ButtonType.standard,
                      state: ButtonState.fill2,
                      text: 'Quay lại',
                      width: 180,
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientInformation()),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    CustomButton(
                      type: ButtonType.standard,
                      state: ButtonState.fill1,
                      text: 'Tiếp tục',
                      width: 180,
                      height: 50,
                      onPressed: _onContinuePressed,
                    ),
                  ],
                )
              ],
            ),
          ),
      );
  }
}
