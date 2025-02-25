import 'package:flutter/material.dart';

import '../../../components/registerElectronicRecords/tabItem_MedicalInformation.dart';
import '../../../design_system/button/button.dart';
import '../../../design_system/color/primary_color.dart';
import '../../../design_system/textstyle/textstyle.dart';
import 'medicalHistory.dart';

class MedicalInformation extends StatefulWidget {
  const MedicalInformation({super.key});

  @override
  MedicalInformationState createState() => MedicalInformationState();
}

class MedicalInformationState extends State<MedicalInformation>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                const SizedBox(
                  child: Column(
                    children: [
                      MedicalHistory(), // Tiền sử bệnh tật
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  type: ButtonType.standard,
                  state: ButtonState.fill1,
                  text: 'Tiếp tục',
                  width: double.infinity,
                  height: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicalHistory()),
                    );
                  },
                ),
                const SizedBox(height: 35),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
