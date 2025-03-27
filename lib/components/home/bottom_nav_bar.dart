
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

import '../../screens/electronicHealthRecord/electronicHealthRecord.dart';
import '../../screens/home/home.dart';
import '../../screens/setExaminationNumber/humanBody.dart';

class BottomNavBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BottomNavBarState();
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndexTab = 0;

  List<Widget> pages = [
    Home(),
    ElectronicHealthRecord(),
    FrontManBody(),
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: pages[currentIndexTab],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
        child: GNav(
          gap: screenWidth * 0.03,
          activeColor: PrimaryColor.primary_05,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          tabBackgroundColor: PrimaryColor.primary_01.withOpacity(0.5),
          backgroundColor: PrimaryColor.primary_00,
          color: NeutralColor.neutral_04,
          textStyle: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_05),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Trang chủ',
            ),
            GButton(
              icon: Icons.assignment_ind_outlined,
              text: 'Sổ khám',
            ),
            GButton(
              icon: Icons.archive_outlined,
              text: 'Đặt số',
            ),
            GButton(
              icon: Icons.account_circle,
              text: 'Tài khoản',
            ),
          ],
          selectedIndex: currentIndexTab,
          onTabChange: (index) {
            setState((){
              currentIndexTab = index;
            });
          },  // Gọi hàm thay đổi tab khi nhấn
        ),
      ),
    );
  }
}
